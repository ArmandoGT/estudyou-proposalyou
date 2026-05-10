// lib/data/repositories/contract_repository.dart

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/contract_dto.dart';
import '../supabase/supabase_provider.dart';

part 'contract_repository.g.dart';

class ContractRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ContractRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('contracts');

  Future<List<ContractDto>> getAll({
    int offset = 0,
    int limit = 20,
    String? status,
    String? providerId,
    bool refreshRemote = false,
  }) async {
    final cached = await _getCachedContracts(
      offset: offset,
      limit: limit,
      status: status,
      providerId: providerId,
    );

    if (cached.isNotEmpty && !refreshRemote) {
      _refreshContractsInBackground(
        offset: offset,
        limit: limit,
        status: status,
        providerId: providerId,
      );
      return cached;
    }

    try {
      final remote = await _fetchRemoteContracts(
        offset: offset,
        limit: limit,
        status: status,
        providerId: providerId,
      );
      await _upsertContractsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ContractDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedContracts)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshContractByIdInBackground(id);
      return _contractFromCache(cached);
    }

    try {
      final data = await _table
          .select('*, client:clients(nome), signatures!contract_id(id)')
          .eq('id', id).single();
      final remote = ContractDto.fromJson(data);
      await _upsertContractCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractDto> create(ContractDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      final saved = ContractDto.fromJson(data);
      await _upsertContractCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractDto> update(ContractDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id)
          .select().single();
      final saved = ContractDto.fromJson(data);
      await _upsertContractCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Busca contrato por share_token (acesso público para assinatura).
  Future<ContractDto?> getByShareToken(String token) async {
    try {
      final data = await _table
          .select('*, client:clients(nome), signatures!contract_id(id)')
          .eq('share_token', token).maybeSingle();
      final remote = data != null ? ContractDto.fromJson(data) : null;
      if (remote != null) {
        await _upsertContractCache(remote);
      }
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Atualiza status. Usado após todas as assinaturas serem coletadas.
  Future<void> updateStatus(String id, String status) async {
    try {
      await _table.update({'status': status}).eq('id', id);
      await (_database.update(_database.cachedContracts)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedContractsCompanion(
          status: drift.Value(status),
          updatedAt: drift.Value(DateTime.now()),
          syncedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Salva hash SHA-256 e URL do PDF final.
  Future<void> updateFinalDocument(String id, {
    required String pdfUrl, required String hash,
  }) async {
    try {
      await _table.update({
        'pdf_url': pdfUrl, 'hash_documento': hash,
      }).eq('id', id);
      await (_database.update(_database.cachedContracts)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedContractsCompanion(
          pdfUrl: drift.Value(pdfUrl),
          hashDocumento: drift.Value(hash),
          syncedAt: drift.Value(DateTime.now()),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Contagem de contratos aguardando assinatura (Dashboard).
  Future<int> countAguardandoAssinatura({String? providerId}) async {
    try {
      var query = _table.select('id')
          .eq('status', 'aguardando_assinatura');
      if (providerId != null && providerId.isNotEmpty) {
        query = query.eq('provider_id', providerId);
      }
      final data = await query;
      return (data as List).length;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ContractDto>> search(String query, {String? providerId}) async {
    final cached = await _searchCachedContracts(query, providerId: providerId);
    if (cached.isNotEmpty) {
      return cached;
    }

    try {
      var builder = _table.select('*, client:clients(nome), signatures(id)')
          .ilike('id', '%$query%');
      if (providerId != null && providerId.isNotEmpty) {
        builder = builder.eq('provider_id', providerId);
      }
      final data = await builder
          .order('updated_at', ascending: false)
          .limit(20);
      final remote = data.map(ContractDto.fromJson).toList();
      await _upsertContractsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ContractDto>> _fetchRemoteContracts({
    required int offset,
    required int limit,
    String? status,
    String? providerId,
  }) async {
    var query = _table.select('*, client:clients(nome), signatures!contract_id(id)');
    if (status != null) query = query.eq('status', status);
    if (providerId != null && providerId.isNotEmpty) {
      query = query.eq('provider_id', providerId);
    }
    final data = await query.order('updated_at', ascending: false)
        .range(offset, offset + limit - 1);
    return data.map(ContractDto.fromJson).toList();
  }

  Future<List<ContractDto>> _getCachedContracts({
    required int offset,
    required int limit,
    String? status,
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final query = _database.select(_database.cachedContracts)
      ..where((tbl) => tbl.providerId.equals(providerId));

    if (status != null) {
      query.where((tbl) => tbl.status.equals(status));
    }

    query
      ..orderBy([(tbl) => drift.OrderingTerm.desc(tbl.updatedAt)])
      ..limit(limit, offset: offset);

    final rows = await query.get();
    return rows.map(_contractFromCache).toList();
  }

  Future<List<ContractDto>> _searchCachedContracts(
    String query, {
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final normalized = query.trim().toLowerCase();
    final rows = await ((_database.select(_database.cachedContracts)
          ..where((tbl) => tbl.providerId.equals(providerId))
          ..orderBy([(tbl) => drift.OrderingTerm.desc(tbl.updatedAt)]))
        .get());

    return rows
        .map(_contractFromCache)
        .where((contract) {
          final id = contract.id.toLowerCase();
          final clientName = (contract.clienteNome ?? '').toLowerCase();
          return id.contains(normalized) || clientName.contains(normalized);
        })
        .take(20)
        .toList();
  }

  Future<void> _upsertContractsCache(List<ContractDto> contracts) async {
    for (final contract in contracts) {
      await _upsertContractCache(contract);
    }
  }

  Future<void> _upsertContractCache(ContractDto contract) async {
    final existing = await (_database.select(_database.cachedContracts)
          ..where((tbl) => tbl.id.equals(contract.id)))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, contract.updatedAt)) {
      await _database.into(_database.cachedContracts).insertOnConflictUpdate(
            _contractToCache(contract),
          );
    }
  }

  Future<void> _refreshContractsInBackground({
    required int offset,
    required int limit,
    String? status,
    String? providerId,
  }) async {
    try {
      final remote = await _fetchRemoteContracts(
        offset: offset,
        limit: limit,
        status: status,
        providerId: providerId,
      );
      await _upsertContractsCache(remote);
    } catch (_) {}
  }

  Future<void> _refreshContractByIdInBackground(String id) async {
    try {
      final data = await _table
          .select('*, client:clients(nome), signatures!contract_id(id)')
          .eq('id', id).single();
      await _upsertContractCache(ContractDto.fromJson(data));
    } catch (_) {}
  }

  ContractDto _contractFromCache(CachedContract row) {
    return ContractDto(
      id: row.id,
      providerId: row.providerId,
      clientId: row.clientId,
      templateId: row.templateId,
      proposalId: row.proposalId,
      status: row.status,
      textoFinal: row.textoFinal,
      vigenciaInicio: row.vigenciaInicio,
      vigenciaFim: row.vigenciaFim,
      shareToken: row.shareToken,
      pdfUrl: row.pdfUrl,
      hashDocumento: row.hashDocumento,
      totalSignatarios: row.totalSignatarios,
      linkAssinatura: row.linkAssinatura,
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
      clienteNome: row.clienteNome,
      assinaturasRealizadas: row.assinaturasRealizadas,
    );
  }

  CachedContractsCompanion _contractToCache(ContractDto contract) {
    return CachedContractsCompanion.insert(
      id: contract.id,
      providerId: contract.providerId,
      clientId: contract.clientId,
      status: drift.Value(contract.status),
      textoFinal: drift.Value(contract.textoFinal),
      proposalId: drift.Value(contract.proposalId),
      templateId: drift.Value(contract.templateId),
      vigenciaInicio: drift.Value(contract.vigenciaInicio),
      vigenciaFim: drift.Value(contract.vigenciaFim),
      shareToken: drift.Value(contract.shareToken),
      pdfUrl: drift.Value(contract.pdfUrl),
      hashDocumento: drift.Value(contract.hashDocumento),
      totalSignatarios: drift.Value(contract.totalSignatarios),
      linkAssinatura: drift.Value(contract.linkAssinatura),
      clienteNome: drift.Value(contract.clienteNome),
      assinaturasRealizadas: drift.Value(contract.assinaturasRealizadas),
      updatedAt: contract.updatedAt,
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ContractRepository contractRepository(Ref ref) {
  return ContractRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
