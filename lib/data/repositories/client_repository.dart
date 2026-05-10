// lib/data/repositories/client_repository.dart

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/client_dto.dart';
import '../supabase/supabase_provider.dart';

part 'client_repository.g.dart';

enum ClientDeletionMode {
  clientOnly,
  clientWithContracts,
  clientWithContractsAndProposals,
}

class ClientDeletionImpact {
  final int contractsCount;
  final int proposalsCount;

  const ClientDeletionImpact({
    required this.contractsCount,
    required this.proposalsCount,
  });
}

class ClientRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ClientRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('clients');

  /// Lista clientes com paginação. Exclui arquivados por padrão.
  Future<List<ClientDto>> getAll({
    int offset = 0,
    int limit = 20,
    String? providerId,
    bool refreshRemote = false,
  }) async {
    final cached = await _getCachedClients(
      offset: offset,
      limit: limit,
      providerId: providerId,
    );

    if (cached.isNotEmpty && !refreshRemote) {
      _refreshClientsInBackground(
        offset: offset,
        limit: limit,
        providerId: providerId,
      );
      return cached;
    }

    try {
      final remote = await _fetchRemoteClients(
        offset: offset,
        limit: limit,
        providerId: providerId,
      );
      await _upsertClientsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ClientDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedClients)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshClientByIdInBackground(id);
      return _clientFromCache(cached);
    }

    try {
      final data = await _table.select().eq('id', id).single();
      final remote = ClientDto.fromJson(data);
      await _upsertClientCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ClientDto> create(ClientDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      final saved = ClientDto.fromJson(data);
      await _upsertClientCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ClientDto> update(ClientDto dto) async {
    if (dto.id == null) {
      throw const ValidationException('Falha de integridade: Não é possível atualizar um cliente sem ID.', code: 'missing_id');
    }

    try {
      final data = await _table
          .update(dto.toJson())
          .eq('id', dto.id!)
          .select()
          .single();
      final saved = ClientDto.fromJson(data);
      await _upsertClientCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Busca Full Text Search via trigrams (pg_trgm).
  Future<List<ClientDto>> search(String query, {String? providerId}) async {
    final cached = await _searchCachedClients(query, providerId: providerId);
    if (cached.isNotEmpty) {
      return cached;
    }

    try {
      var builder = _table
          .select()
          .isFilter('archived_at', null)
          .or('nome.ilike.%$query%,cpf_cnpj.ilike.%$query%');
      if (providerId != null && providerId.isNotEmpty) {
        builder = builder.eq('provider_id', providerId);
      }
      final data = await builder.order('nome').limit(50);
      final remote = data.map(ClientDto.fromJson).toList();
      await _upsertClientsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Soft-delete: seta archived_at com timestamp atual.
  Future<void> archive(String id) async {
    try {
      final archivedAt = DateTime.now();
      await _table.update({
        'archived_at': archivedAt.toIso8601String(),
      }).eq('id', id);
      await (_database.update(_database.cachedClients)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedClientsCompanion(
          archivedAt: drift.Value(archivedAt),
          syncedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ClientDto>> getArchived({
    int offset = 0,
    int limit = 20,
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final cached = await ((_database.select(_database.cachedClients)
          ..where((tbl) => tbl.providerId.equals(providerId) & tbl.archivedAt.isNotNull())
          ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)])
          ..limit(limit, offset: offset))
        .get());

    if (cached.isNotEmpty) {
      _refreshArchivedClientsInBackground(
        offset: offset,
        limit: limit,
        providerId: providerId,
      );
      return cached.map(_clientFromCache).toList();
    }

    try {
      var query = _table.select().not('archived_at', 'is', null);
      query = query.eq('provider_id', providerId);
      final data = await query.order('nome').range(offset, offset + limit - 1);
      final remote = data.map(ClientDto.fromJson).toList();
      await _upsertClientsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> restore(String id) async {
    try {
      await _table.update({'archived_at': null}).eq('id', id);
      await (_database.update(_database.cachedClients)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedClientsCompanion(
          archivedAt: const drift.Value(null),
          syncedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ClientDeletionImpact> getDeletionImpact(String clientId) async {
    try {
      final proposals = await _client
          .from('proposals')
          .select('id')
          .eq('client_id', clientId);
      final contracts = await _client
          .from('contracts')
          .select('id')
          .eq('client_id', clientId);

      return ClientDeletionImpact(
        contractsCount: contracts.length,
        proposalsCount: proposals.length,
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> deletePermanently(String clientId, ClientDeletionMode mode) async {
    try {
      final impact = await getDeletionImpact(clientId);

      if (mode == ClientDeletionMode.clientOnly &&
          (impact.contractsCount > 0 || impact.proposalsCount > 0)) {
        throw const ValidationException(
          'Este cliente possui vínculos. Escolha uma opção que remova também os registros relacionados.',
        );
      }

      if (mode == ClientDeletionMode.clientWithContracts && impact.proposalsCount > 0) {
        throw const ValidationException(
          'Este cliente possui propostas vinculadas. Use a opção que remove cliente, contratos e propostas.',
        );
      }

      if (mode == ClientDeletionMode.clientWithContracts ||
          mode == ClientDeletionMode.clientWithContractsAndProposals) {
        await _client.from('contracts').delete().eq('client_id', clientId);
      }

      if (mode == ClientDeletionMode.clientWithContractsAndProposals) {
        await _client.from('proposals').delete().eq('client_id', clientId);
        await (_database.delete(_database.cachedProposals)
              ..where((tbl) => tbl.clientId.equals(clientId)))
            .go();
      }

      await _table.delete().eq('id', clientId);
      await (_database.delete(_database.cachedClients)
            ..where((tbl) => tbl.id.equals(clientId)))
          .go();
      await (_database.delete(_database.cachedContracts)
            ..where((tbl) => tbl.clientId.equals(clientId)))
          .go();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ClientDto>> _fetchRemoteClients({
    required int offset,
    required int limit,
    String? providerId,
  }) async {
    var query = _table.select().isFilter('archived_at', null);
    if (providerId != null && providerId.isNotEmpty) {
      query = query.eq('provider_id', providerId);
    }
    final data = await query.order('nome').range(offset, offset + limit - 1);
    return data.map(ClientDto.fromJson).toList();
  }

  Future<List<ClientDto>> _getCachedClients({
    required int offset,
    required int limit,
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final query = _database.select(_database.cachedClients)
      ..where((tbl) => tbl.providerId.equals(providerId) & tbl.archivedAt.isNull());

    query
      ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)])
      ..limit(limit, offset: offset);

    final rows = await query.get();
    return rows.map(_clientFromCache).toList();
  }

  Future<List<ClientDto>> _searchCachedClients(
    String query, {
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final normalized = query.trim().toLowerCase();
    final rows = await ((_database.select(_database.cachedClients)
          ..where((tbl) => tbl.providerId.equals(providerId) & tbl.archivedAt.isNull())
          ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)]))
        .get());

    return rows
        .map(_clientFromCache)
        .where((client) {
          final name = client.nome.toLowerCase();
          final document = client.cpfCnpj.toLowerCase();
          return name.contains(normalized) || document.contains(normalized);
        })
        .take(50)
        .toList();
  }

  Future<void> _upsertClientsCache(List<ClientDto> clients) async {
    for (final client in clients) {
      await _upsertClientCache(client);
    }
  }

  Future<void> _upsertClientCache(ClientDto client) async {
    final companion = _clientToCache(client);
    final existing = await (_database.select(_database.cachedClients)
          ..where((tbl) => tbl.id.equals(client.id ?? '')))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, client.updatedAt)) {
      await _database.into(_database.cachedClients).insertOnConflictUpdate(companion);
    }
  }

  Future<void> _refreshClientsInBackground({
    required int offset,
    required int limit,
    String? providerId,
  }) async {
    try {
      final remote = await _fetchRemoteClients(
        offset: offset,
        limit: limit,
        providerId: providerId,
      );
      await _upsertClientsCache(remote);
    } catch (_) {}
  }

  Future<void> _refreshArchivedClientsInBackground({
    required int offset,
    required int limit,
    String? providerId,
  }) async {
    try {
      if (providerId == null || providerId.isEmpty) return;
      var query = _table.select().not('archived_at', 'is', null);
      query = query.eq('provider_id', providerId);
      final data = await query.order('nome').range(offset, offset + limit - 1);
      await _upsertClientsCache(data.map(ClientDto.fromJson).toList());
    } catch (_) {}
  }

  Future<void> _refreshClientByIdInBackground(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      await _upsertClientCache(ClientDto.fromJson(data));
    } catch (_) {}
  }

  ClientDto _clientFromCache(CachedClient row) {
    return ClientDto(
      id: row.id,
      providerId: row.providerId,
      nome: row.nome,
      cpfCnpj: row.cpfCnpj,
      email: row.email,
      telefone: row.telefone,
      endereco: row.enderecoJson == null
          ? null
          : Map<String, dynamic>.from(jsonDecode(row.enderecoJson!)),
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
      archivedAt: row.archivedAt,
    );
  }

  CachedClientsCompanion _clientToCache(ClientDto client) {
    return CachedClientsCompanion.insert(
      id: client.id ?? '',
      providerId: client.providerId ?? '',
      nome: client.nome,
      cpfCnpj: client.cpfCnpj,
      email: drift.Value(client.email),
      telefone: drift.Value(client.telefone),
      enderecoJson: drift.Value(
        client.endereco == null ? null : jsonEncode(client.endereco),
      ),
      updatedAt: client.updatedAt,
      archivedAt: drift.Value(client.archivedAt),
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ClientRepository clientRepository(Ref ref) {
  return ClientRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}