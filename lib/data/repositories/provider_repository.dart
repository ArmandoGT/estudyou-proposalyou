// lib/data/repositories/provider_repository.dart

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/provider_dto.dart';
import '../supabase/supabase_provider.dart';

part 'provider_repository.g.dart';

class ProviderRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ProviderRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('providers');

  Future<List<ProviderDto>> getAll({bool refreshRemote = false}) async {
    final cached = await _getCachedProviders();
    if (cached.isNotEmpty && !refreshRemote) {
      _refreshProvidersInBackground();
      return cached;
    }

    try {
      final data = await _table.select().order('empresa');
      final remote = data.map(ProviderDto.fromJson).toList();
      await _upsertProvidersCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ProviderDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedProviders)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshProviderByIdInBackground(id);
      return _providerFromCache(cached);
    }

    try {
      final data = await _table.select().eq('id', id).single();
      final remote = ProviderDto.fromJson(data);
      await _upsertProviderCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProviderDto> getBySlug(String slug) async {
    final cached = await (_database.select(_database.cachedProviders)
          ..where((tbl) => tbl.empresa.equals(slug)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshProviderBySlugInBackground(slug);
      return _providerFromCache(cached);
    }

    try {
      final data = await _table.select().eq('empresa', slug).single();
      final remote = ProviderDto.fromJson(data);
      await _upsertProviderCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProviderDto> create(ProviderDto dto) async {
    try {
      final data = await _table.insert(dto.toInsertJson()).select().single();
      final saved = ProviderDto.fromJson(data);
      await _upsertProviderCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProviderDto> update(ProviderDto dto) async {
    try {
      final data = await _table
          .update(dto.toUpdateJson())
          .eq('id', dto.id)
          .select()
          .single();
      final saved = ProviderDto.fromJson(data);
      await _upsertProviderCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Atualiza apenas a URL do logo após upload no Storage.
  Future<void> updateLogoUrl(String id, String logoUrl) async {
    try {
      await _table.update({'logo_url': logoUrl}).eq('id', id);
      final data = await _table.select().eq('id', id).single();
      await _upsertProviderCache(ProviderDto.fromJson(data));
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ProviderDto>> _getCachedProviders() async {
    final rows = await ((_database.select(_database.cachedProviders)
          ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.empresa)]))
        .get());
    return rows.map(_providerFromCache).toList();
  }

  Future<void> _upsertProvidersCache(List<ProviderDto> providers) async {
    for (final provider in providers) {
      await _upsertProviderCache(provider);
    }
  }

  Future<void> _upsertProviderCache(ProviderDto provider) async {
    final existing = await (_database.select(_database.cachedProviders)
          ..where((tbl) => tbl.id.equals(provider.id)))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, provider.updatedAt)) {
      await _database.into(_database.cachedProviders).insertOnConflictUpdate(
            _providerToCache(provider),
          );
    }
  }

  Future<void> _refreshProvidersInBackground() async {
    try {
      final data = await _table.select().order('empresa');
      await _upsertProvidersCache(data.map(ProviderDto.fromJson).toList());
    } catch (_) {}
  }

  Future<void> _refreshProviderByIdInBackground(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      await _upsertProviderCache(ProviderDto.fromJson(data));
    } catch (_) {}
  }

  Future<void> _refreshProviderBySlugInBackground(String slug) async {
    try {
      final data = await _table.select().eq('empresa', slug).single();
      await _upsertProviderCache(ProviderDto.fromJson(data));
    } catch (_) {}
  }

  ProviderDto _providerFromCache(CachedProvider row) {
    final json = row.dataJson == null
        ? <String, dynamic>{}
        : Map<String, dynamic>.from(jsonDecode(row.dataJson!));

    return ProviderDto(
      id: row.id,
      empresa: row.empresa,
      razaoSocial: row.razaoSocial,
      cnpj: row.cnpj,
      logoUrl: row.logoUrl,
      endereco: json['endereco'] as String?,
      responsavel: json['responsavel'] as String?,
      email: json['email'] as String?,
      corMarca: row.corMarca,
      assinaturaPadrao: json['assinatura_padrao'] as String?,
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
    );
  }

  CachedProvidersCompanion _providerToCache(ProviderDto provider) {
    return CachedProvidersCompanion.insert(
      id: provider.id,
      empresa: provider.empresa,
      razaoSocial: provider.razaoSocial,
      cnpj: provider.cnpj,
      logoUrl: drift.Value(provider.logoUrl),
      corMarca: drift.Value(provider.corMarca),
      dataJson: drift.Value(jsonEncode({
        'endereco': provider.endereco,
        'responsavel': provider.responsavel,
        'email': provider.email,
        'assinatura_padrao': provider.assinaturaPadrao,
      })),
      updatedAt: provider.updatedAt,
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ProviderRepository providerRepository(Ref ref) {
  return ProviderRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
