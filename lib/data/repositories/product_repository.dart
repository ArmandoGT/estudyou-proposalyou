// lib/data/repositories/product_repository.dart

import 'package:drift/drift.dart' as drift;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../drift/app_database.dart';
import '../dtos/product_dto.dart';
import '../supabase/supabase_provider.dart';

part 'product_repository.g.dart';

class ProductRepository {
  final SupabaseClient _client;
  final AppDatabase _database;

  const ProductRepository(this._client, this._database);

  SupabaseQueryBuilder get _table => _client.from('products');

  Future<List<ProductDto>> getAll({
    int offset = 0,
    int limit = 20,
    String? tipo,
    String? providerId,
    bool refreshRemote = false,
  }) async {
    final cached = await _getCachedProducts(
      providerId: providerId,
      tipo: tipo,
      offset: offset,
      limit: limit,
    );

    if (cached.isNotEmpty && !refreshRemote) {
      _refreshProductsInBackground(
        offset: offset,
        limit: limit,
        tipo: tipo,
        providerId: providerId,
      );
      return cached;
    }

    try {
      final remote = await _fetchRemoteProducts(
        offset: offset,
        limit: limit,
        tipo: tipo,
        providerId: providerId,
      );
      await _upsertProductsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      if (cached.isNotEmpty) return cached;
      throw e.toAppException();
    }
  }

  Future<ProductDto> getById(String id) async {
    final cached = await (_database.select(_database.cachedProducts)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (cached != null) {
      _refreshProductByIdInBackground(id);
      return _productFromCache(cached);
    }

    try {
      final data = await _table.select().eq('id', id).single();
      final remote = ProductDto.fromJson(data);
      await _upsertProductCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProductDto> create(ProductDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      final saved = ProductDto.fromJson(data);
      await _upsertProductCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProductDto> update(ProductDto dto) async {
    if (dto.id == null || dto.id!.trim().isEmpty) {
      throw const ValidationException('ID do produto é obrigatório para atualização', code: 'missing_id');
    }
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id!).select().single();
      final saved = ProductDto.fromJson(data);
      await _upsertProductCache(saved);
      return saved;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ProductDto>> searchByName(
    String query, {
    String? providerId,
  }) async {
    final cached = await _searchCachedProducts(query, providerId: providerId);
    if (cached.isNotEmpty) {
      return cached;
    }

    try {
      var builder = _table
          .select()
          .isFilter('archived_at', null)
          .ilike('nome', '%$query%');
      if (providerId != null && providerId.isNotEmpty) {
        builder = builder.eq('provider_id', providerId);
      }
      final data = await builder.order('nome').limit(30);
      final remote = data.map(ProductDto.fromJson).toList();
      await _upsertProductsCache(remote);
      return remote;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ProductDto>> _fetchRemoteProducts({
    required int offset,
    required int limit,
    String? tipo,
    String? providerId,
  }) async {
    var query = _table.select().isFilter('archived_at', null);
    if (tipo != null) query = query.eq('tipo', tipo);
    if (providerId != null && providerId.isNotEmpty) {
      query = query.eq('provider_id', providerId);
    }
    final data = await query.order('nome').range(offset, offset + limit - 1);
    return data.map(ProductDto.fromJson).toList();
  }

  Future<List<ProductDto>> _getCachedProducts({
    required int offset,
    required int limit,
    String? tipo,
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final query = _database.select(_database.cachedProducts)
      ..where((tbl) => tbl.providerId.equals(providerId));

    if (tipo != null) {
      query.where((tbl) => tbl.tipo.equals(tipo));
    }

    query
      ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)])
      ..limit(limit, offset: offset);

    final rows = await query.get();
    return rows.map(_productFromCache).toList();
  }

  Future<List<ProductDto>> _searchCachedProducts(
    String query, {
    String? providerId,
  }) async {
    if (providerId == null || providerId.isEmpty) return const [];

    final normalized = query.trim().toLowerCase();
    final rows = await ((_database.select(_database.cachedProducts)
          ..where((tbl) => tbl.providerId.equals(providerId))
          ..orderBy([(tbl) => drift.OrderingTerm.asc(tbl.nome)]))
        .get());

    return rows
        .map(_productFromCache)
        .where((product) => product.nome.toLowerCase().contains(normalized))
        .take(30)
        .toList();
  }

  Future<void> _upsertProductsCache(List<ProductDto> products) async {
    for (final product in products) {
      await _upsertProductCache(product);
    }
  }

  Future<void> _upsertProductCache(ProductDto product) async {
    final companion = _productToCache(product);
    final existing = await (_database.select(_database.cachedProducts)
          ..where((tbl) => tbl.id.equals(product.id ?? '')))
        .getSingleOrNull();

    if (existing == null || _database.shouldSync(existing.updatedAt, product.updatedAt)) {
      await _database.into(_database.cachedProducts).insertOnConflictUpdate(companion);
    }
  }

  Future<void> _refreshProductsInBackground({
    required int offset,
    required int limit,
    String? tipo,
    String? providerId,
  }) async {
    try {
      final remote = await _fetchRemoteProducts(
        offset: offset,
        limit: limit,
        tipo: tipo,
        providerId: providerId,
      );
      await _upsertProductsCache(remote);
    } catch (_) {}
  }

  Future<void> _refreshProductByIdInBackground(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      await _upsertProductCache(ProductDto.fromJson(data));
    } catch (_) {}
  }

  ProductDto _productFromCache(CachedProduct row) {
    return ProductDto(
      id: row.id,
      providerId: row.providerId,
      nome: row.nome,
      descricao: row.descricao,
      preco: row.preco,
      tipo: row.tipo,
      unidade: row.unidade,
      ativo: row.ativo,
      createdAt: row.updatedAt,
      updatedAt: row.updatedAt,
      archivedAt: null,
    );
  }

  CachedProductsCompanion _productToCache(ProductDto product) {
    return CachedProductsCompanion.insert(
      id: product.id ?? '',
      providerId: product.providerId ?? '',
      nome: product.nome,
      descricao: drift.Value(product.descricao),
      preco: drift.Value(product.preco),
      tipo: drift.Value(product.tipo),
      unidade: drift.Value(product.unidade),
      ativo: drift.Value(product.ativo),
      updatedAt: product.updatedAt,
      syncedAt: drift.Value(DateTime.now()),
    );
  }
}

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository(
    ref.watch(supabaseClientProvider),
    ref.watch(appDatabaseProvider),
  );
}
