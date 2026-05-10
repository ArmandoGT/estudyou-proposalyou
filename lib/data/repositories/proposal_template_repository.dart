// lib/data/repositories/proposal_template_repository.dart

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/proposal_template_dto.dart';
import '../supabase/supabase_provider.dart';

part 'proposal_template_repository.g.dart';

class ProposalTemplateRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ProposalTemplateRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('proposal_templates');

  Future<List<ProposalTemplateDto>> getAll({
    String? providerId,
    bool refreshRemote = false,
  }) async {
    final cached = await _getCachedTemplates(providerId: providerId);
    if (cached.isNotEmpty && !refreshRemote) {
      _refreshTemplatesInBackground(providerId);
      return cached;
    }

    try {
      var query = _table.select();
      if (providerId != null && providerId.isNotEmpty) {
        query = query.eq('provider_id', providerId);
      }
      final data = await query.order('nome');
      final remote = data.map(ProposalTemplateDto.fromJson).toList();
      await _upsertTemplatesCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ProposalTemplateDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedProposalTemplates)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshTemplateByIdInBackground(id);
      return _templateFromCache(cached);
    }

    try {
      final data = await _table.select().eq('id', id).single();
      final remote = ProposalTemplateDto.fromJson(data);
      await _upsertTemplateCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalTemplateDto> create(ProposalTemplateDto dto) async {
    try {
      final json = dto.toJson();
      if ((json['id'] as String?)?.trim().isEmpty == true) {
        json.remove('id');
      }
      final data = await _table.insert(json).select().single();
      final saved = ProposalTemplateDto.fromJson(data);
      await _upsertTemplateCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalTemplateDto> update(ProposalTemplateDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id).select().single();
      final saved = ProposalTemplateDto.fromJson(data);
      await _upsertTemplateCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Duplica um template existente com novo ID e nome.
  Future<ProposalTemplateDto> duplicate(String id) async {
    try {
      final original = await getById(id);
      final copy = original.copyWith(nome: '${original.nome} (cópia)');
      final json = copy.toJson()..remove('id');
      final data = await _table.insert(json).select().single();
      final saved = ProposalTemplateDto.fromJson(data);
      await _upsertTemplateCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Conta propostas vinculadas a este template.
  Future<int> countProposals(String templateId) async {
    try {
      final data = await _client
          .from('proposals')
          .select('id')
          .eq('template_id', templateId);
      return (data as List).length;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ProposalTemplateDto>> _getCachedTemplates({String? providerId}) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final rows = await ((_database.select(_database.cachedProposalTemplates)
          ..where((tbl) => tbl.providerId.equals(providerId))
          ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)]))
        .get());
    return rows.map(_templateFromCache).toList();
  }

  Future<void> _upsertTemplatesCache(List<ProposalTemplateDto> templates) async {
    for (final template in templates) {
      await _upsertTemplateCache(template);
    }
  }

  Future<void> _upsertTemplateCache(ProposalTemplateDto template) async {
    final existing = await (_database.select(_database.cachedProposalTemplates)
          ..where((tbl) => tbl.id.equals(template.id)))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, template.updatedAt)) {
      await _database.into(_database.cachedProposalTemplates).insertOnConflictUpdate(
            _templateToCache(template),
          );
    }
  }

  Future<void> _refreshTemplatesInBackground(String? providerId) async {
    try {
      var query = _table.select();
      if (providerId != null && providerId.isNotEmpty) {
        query = query.eq('provider_id', providerId);
      }
      final data = await query.order('nome');
      await _upsertTemplatesCache(data.map(ProposalTemplateDto.fromJson).toList());
    } catch (_) {}
  }

  Future<void> _refreshTemplateByIdInBackground(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      await _upsertTemplateCache(ProposalTemplateDto.fromJson(data));
    } catch (_) {}
  }

  ProposalTemplateDto _templateFromCache(CachedProposalTemplate row) {
    return ProposalTemplateDto(
      id: row.id,
      providerId: row.providerId,
      nome: row.nome,
      corpoJson: Map<String, dynamic>.from(jsonDecode(row.corpoJson)),
      ativo: row.ativo,
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
    );
  }

  CachedProposalTemplatesCompanion _templateToCache(ProposalTemplateDto template) {
    return CachedProposalTemplatesCompanion.insert(
      id: template.id,
      providerId: template.providerId,
      nome: template.nome,
      corpoJson: jsonEncode(template.corpoJson),
      ativo: drift.Value(template.ativo),
      updatedAt: template.updatedAt,
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ProposalTemplateRepository proposalTemplateRepository(Ref ref) {
  return ProposalTemplateRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
