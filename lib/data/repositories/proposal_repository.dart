// lib/data/repositories/proposal_repository.dart

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/proposal_dto.dart';
import '../supabase/supabase_provider.dart';

part 'proposal_repository.g.dart';

class ProposalRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ProposalRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('proposals');

  Future<List<ProposalDto>> getAll({
    int offset = 0,
    int limit = 20,
    String? status,
    String? providerId,
    bool refreshRemote = false,
    bool archivedOnly = false,
  }) async {
    final cached = await _getCachedProposals(
      offset: offset,
      limit: limit,
      status: status,
      providerId: providerId,
      archivedOnly: archivedOnly,
    );

    if (cached.isNotEmpty && !refreshRemote) {
      _refreshProposalsInBackground(
        offset: offset,
        limit: limit,
        status: status,
        providerId: providerId,
        archivedOnly: archivedOnly,
      );
      return cached;
    }

    try {
      final remote = await _fetchRemoteProposals(
        offset: offset,
        limit: limit,
        status: status,
        providerId: providerId,
        archivedOnly: archivedOnly,
      );
      await _upsertProposalsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ProposalDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedProposals)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshProposalByIdInBackground(id);
      return _proposalFromCache(cached);
    }

    try {
      final data = await _table.select('*, client:clients(nome)')
          .eq('id', id).single();
      final remote = ProposalDto.fromJson(data);
      await _upsertProposalCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalDto> create(ProposalDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      final saved = ProposalDto.fromJson(data);
      await _upsertProposalCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalDto> update(ProposalDto dto) async {
    if (dto.isLocked) {
      throw const ValidationException(
        'Propostas enviadas ou aprovadas não podem ser editadas. '
        'Use "Duplicar para Nova Versão".',
        code: 'proposal_locked',
      );
    }
    if (dto.id == null || dto.id!.isEmpty) {
      throw const ValidationException('ID da proposta não informado para atualização.');
    }
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id!)
          .select().single();
      final saved = ProposalDto.fromJson(data);
      await _upsertProposalCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      await _table.update({'status': status}).eq('id', id);
      await (_database.update(_database.cachedProposals)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedProposalsCompanion(
          status: drift.Value(status),
          syncedAt: drift.Value(DateTime.now()),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> archive(String id) async {
    try {
      final archivedAt = DateTime.now();
      await _table.update({
        'archived_at': archivedAt.toIso8601String(),
      }).eq('id', id);
      await (_database.update(_database.cachedProposals)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedProposalsCompanion(
          archivedAt: drift.Value(archivedAt),
          syncedAt: drift.Value(DateTime.now()),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> restore(String id) async {
    try {
      await _table.update({'archived_at': null}).eq('id', id);
      await (_database.update(_database.cachedProposals)
            ..where((tbl) => tbl.id.equals(id)))
          .write(
        CachedProposalsCompanion(
          archivedAt: const drift.Value(null),
          syncedAt: drift.Value(DateTime.now()),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> deletePermanently(String id) async {
    try {
      await _table.delete().eq('id', id);
      await (_database.delete(_database.cachedProposals)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Duplica proposta como nova versão (incrementa versao, reseta status).
  Future<ProposalDto> duplicateAsNewVersion(String id) async {
    try {
      final original = await getById(id);
      final json = original.toJson()
        ..remove('id')
        ..['status'] = 'rascunho'
        ..['versao'] = original.versao + 1;
      final data = await _table.insert(json).select().single();
      final saved = ProposalDto.fromJson(data);
      await _upsertProposalCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalDto?> getByShareToken(String token) async {
    try {
      final data = await _table.select('*, client:clients(nome)')
          .eq('share_token', token).maybeSingle();
      final remote = data != null ? ProposalDto.fromJson(data) : null;
      if (remote != null) {
        await _upsertProposalCache(remote);
      }
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Itens recentes para o Dashboard (propostas + updated_at desc).
  Future<List<ProposalDto>> getRecentItems({int limit = 5, String? providerId}) async {
    try {
      var query = _table
          .select('id, status, client:clients(nome), total, updated_at, provider_id, client_id, created_at');
      if (providerId != null && providerId.isNotEmpty) {
        query = query.eq('provider_id', providerId);
      }
      final data = await query.order('updated_at', ascending: false).limit(limit);
      final remote = data.map(ProposalDto.fromJson).toList();
      await _upsertProposalsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Contagem de propostas por status para métricas do Dashboard.
  Future<Map<String, int>> getCountByStatus({String? providerId}) async {
    try {
      var query = _table.select('status');
      if (providerId != null && providerId.isNotEmpty) {
        query = query.eq('provider_id', providerId);
      }
      final data = await query;
      final counts = <String, int>{};
      for (final row in data) {
        final s = row['status'] as String;
        counts[s] = (counts[s] ?? 0) + 1;
      }
      return counts;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> updatePdfUrl(String id, String pdfUrl) async {
    try {
      await _table.update({'pdf_url': pdfUrl}).eq('id', id);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ProposalDto>> search(String query, {String? providerId, bool archivedOnly = false}) async {
    final cached = await _searchCachedProposals(query, providerId: providerId, archivedOnly: archivedOnly);
    if (cached.isNotEmpty) {
      return cached;
    }

    try {
      var builder = _table.select('*, client:clients(nome)')
          .ilike('id', '%$query%');
      builder = archivedOnly
          ? builder.not('archived_at', 'is', null)
          : builder.isFilter('archived_at', null);
      if (providerId != null && providerId.isNotEmpty) {
        builder = builder.eq('provider_id', providerId);
      }
      final data = await builder
          .order('updated_at', ascending: false)
          .limit(20);
      final remote = data.map(ProposalDto.fromJson).toList();
      await _upsertProposalsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (_isMissingArchivedAtColumn(e)) {
        var fallbackBuilder = _table.select('*, client:clients(nome)')
            .ilike('id', '%$query%');
        if (providerId != null && providerId.isNotEmpty) {
          fallbackBuilder = fallbackBuilder.eq('provider_id', providerId);
        }
        final data = await fallbackBuilder
            .order('updated_at', ascending: false)
            .limit(20);
        final remote = data.map(ProposalDto.fromJson).toList();
        await _upsertProposalsCache(remote);
        return archivedOnly ? const [] : remote;
      }
      throw e.toAppException();
    }
  }

  Future<List<ProposalDto>> _fetchRemoteProposals({
    required int offset,
    required int limit,
    String? status,
    String? providerId,
    bool archivedOnly = false,
  }) async {
    try {
      var query = _table.select('*, client:clients(nome)');
      query = archivedOnly
          ? query.not('archived_at', 'is', null)
          : query.isFilter('archived_at', null);
      if (status != null) query = query.eq('status', status);
      if (providerId != null && providerId.isNotEmpty) {
        query = query.eq('provider_id', providerId);
      }
      final data = await query.order('updated_at', ascending: false)
          .range(offset, offset + limit - 1);
      return data.map(ProposalDto.fromJson).toList();
    } on PostgrestException catch (e) {
      if (_isMissingArchivedAtColumn(e)) {
        var fallbackQuery = _table.select('*, client:clients(nome)');
        if (status != null) fallbackQuery = fallbackQuery.eq('status', status);
        if (providerId != null && providerId.isNotEmpty) {
          fallbackQuery = fallbackQuery.eq('provider_id', providerId);
        }
        final data = await fallbackQuery.order('updated_at', ascending: false)
            .range(offset, offset + limit - 1);
        final remote = data.map(ProposalDto.fromJson).toList();
        return archivedOnly ? const [] : remote;
      }
      rethrow;
    }
  }

  Future<List<ProposalDto>> _getCachedProposals({
    required int offset,
    required int limit,
    String? status,
    String? providerId,
    bool archivedOnly = false,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final query = _database.select(_database.cachedProposals)
      ..where((tbl) => tbl.providerId.equals(providerId) & (archivedOnly ? tbl.archivedAt.isNotNull() : tbl.archivedAt.isNull()));

    if (status != null) {
      query.where((tbl) => tbl.status.equals(status));
    }

    query
      ..orderBy([(tbl) => drift.OrderingTerm.desc(tbl.updatedAt)])
      ..limit(limit, offset: offset);

    final rows = await query.get();
    return rows.map(_proposalFromCache).toList();
  }

  Future<List<ProposalDto>> _searchCachedProposals(
    String query, {
    String? providerId,
    bool archivedOnly = false,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final normalized = query.trim().toLowerCase();
    final rows = await ((_database.select(_database.cachedProposals)
          ..where((tbl) => tbl.providerId.equals(providerId) & (archivedOnly ? tbl.archivedAt.isNotNull() : tbl.archivedAt.isNull()))
          ..orderBy([(tbl) => drift.OrderingTerm.desc(tbl.updatedAt)]))
        .get());

    return rows
        .map(_proposalFromCache)
        .where((proposal) {
          final id = (proposal.id ?? '').toLowerCase();
          final clientName = (proposal.clienteNome ?? '').toLowerCase();
          return id.contains(normalized) || clientName.contains(normalized);
        })
        .take(20)
        .toList();
  }

  Future<void> _upsertProposalsCache(List<ProposalDto> proposals) async {
    for (final proposal in proposals) {
      await _upsertProposalCache(proposal);
    }
  }

  Future<void> _upsertProposalCache(ProposalDto proposal) async {
    final companion = _proposalToCache(proposal);
    final existing = await (_database.select(_database.cachedProposals)
          ..where((tbl) => tbl.id.equals(proposal.id ?? '')))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, proposal.updatedAt)) {
      await _database.into(_database.cachedProposals).insertOnConflictUpdate(companion);
    }
  }

  Future<void> _refreshProposalsInBackground({
    required int offset,
    required int limit,
    String? status,
    String? providerId,
    bool archivedOnly = false,
  }) async {
    try {
      final remote = await _fetchRemoteProposals(
        offset: offset,
        limit: limit,
        status: status,
        providerId: providerId,
        archivedOnly: archivedOnly,
      );
      await _upsertProposalsCache(remote);
    } catch (_) {}
  }

  Future<void> _refreshProposalByIdInBackground(String id) async {
    try {
      final data = await _table.select('*, client:clients(nome)')
          .eq('id', id).single();
      await _upsertProposalCache(ProposalDto.fromJson(data));
    } catch (_) {}
  }

  bool _isMissingArchivedAtColumn(PostgrestException e) {
    return e.code == 'PGRST204' && e.message.contains("archived_at");
  }

  ProposalDto _proposalFromCache(CachedProposal row) {
    final itens = (jsonDecode(row.itensJson) as List<dynamic>)
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();

    return ProposalDto(
      id: row.id,
      providerId: row.providerId,
      clientId: row.clientId,
      status: row.status,
      validade: row.validade,
      itensJson: itens,
      total: row.total,
      desconto: row.desconto,
      observacoes: row.observacoes,
      archivedAt: row.archivedAt,
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
    );
  }

  CachedProposalsCompanion _proposalToCache(ProposalDto proposal) {
    return CachedProposalsCompanion.insert(
      id: proposal.id ?? '',
      providerId: proposal.providerId ?? '',
      clientId: proposal.clientId ?? '',
      status: drift.Value(proposal.status ?? 'rascunho'),
      itensJson: drift.Value(jsonEncode(proposal.itensJson)),
      total: drift.Value(proposal.total),
      desconto: drift.Value(proposal.desconto),
      observacoes: drift.Value(proposal.observacoes),
      validade: drift.Value(proposal.validade),
      archivedAt: drift.Value(proposal.archivedAt),
      updatedAt: proposal.updatedAt,
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ProposalRepository proposalRepository(Ref ref) {
  return ProposalRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
