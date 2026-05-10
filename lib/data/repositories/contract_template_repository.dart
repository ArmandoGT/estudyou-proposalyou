// lib/data/repositories/contract_template_repository.dart

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/contract_template_dto.dart';
import '../supabase/supabase_provider.dart';

part 'contract_template_repository.g.dart';

class ContractTemplateRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ContractTemplateRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('contract_templates');

  Future<List<ContractTemplateDto>> getAll({
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
      final remote = data.map(ContractTemplateDto.fromJson).toList();
      await _upsertTemplatesCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ContractTemplateDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedContractTemplates)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshTemplateByIdInBackground(id);
      return _templateFromCache(cached);
    }

    try {
      final data = await _table.select().eq('id', id).single();
      final remote = ContractTemplateDto.fromJson(data);
      await _upsertTemplateCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractTemplateDto> create(ContractTemplateDto dto) async {
    try {
      final json = dto.toJson();
      if ((json['id'] as String?)?.trim().isEmpty == true) {
        json.remove('id');
      }
      final data = await _table.insert(json).select().single();
      final saved = ContractTemplateDto.fromJson(data);
      await _upsertTemplateCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractTemplateDto> update(ContractTemplateDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id).select().single();
      final saved = ContractTemplateDto.fromJson(data);
      await _upsertTemplateCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Cria nova versão do template, incrementando o campo versao.
  Future<ContractTemplateDto> createNewVersion(String id) async {
    try {
      final original = await getById(id);
      final json = original.toJson()
        ..remove('id')
        ..['versao'] = original.versao + 1;
      final data = await _table.insert(json).select().single();
      final saved = ContractTemplateDto.fromJson(data);
      await _upsertTemplateCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ContractTemplateDto>> _getCachedTemplates({String? providerId}) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final rows = await ((_database.select(_database.cachedContractTemplates)
          ..where((tbl) => tbl.providerId.equals(providerId))
          ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)]))
        .get());
    return rows.map(_templateFromCache).toList();
  }

  Future<void> _upsertTemplatesCache(List<ContractTemplateDto> templates) async {
    for (final template in templates) {
      await _upsertTemplateCache(template);
    }
  }

  Future<void> _upsertTemplateCache(ContractTemplateDto template) async {
    final existing = await (_database.select(_database.cachedContractTemplates)
          ..where((tbl) => tbl.id.equals(template.id)))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, template.updatedAt)) {
      await _database.into(_database.cachedContractTemplates).insertOnConflictUpdate(
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
      await _upsertTemplatesCache(data.map(ContractTemplateDto.fromJson).toList());
    } catch (_) {}
  }

  Future<void> _refreshTemplateByIdInBackground(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      await _upsertTemplateCache(ContractTemplateDto.fromJson(data));
    } catch (_) {}
  }

  ContractTemplateDto _templateFromCache(CachedContractTemplate row) {
    return ContractTemplateDto(
      id: row.id,
      providerId: row.providerId,
      nome: row.nome,
      corpoJson: Map<String, dynamic>.from(jsonDecode(row.corpoJson)),
      versao: row.versao,
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
    );
  }

  CachedContractTemplatesCompanion _templateToCache(ContractTemplateDto template) {
    return CachedContractTemplatesCompanion.insert(
      id: template.id,
      providerId: template.providerId,
      nome: template.nome,
      corpoJson: jsonEncode(template.corpoJson),
      versao: drift.Value(template.versao),
      updatedAt: template.updatedAt,
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ContractTemplateRepository contractTemplateRepository(Ref ref) {
  return ContractTemplateRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
