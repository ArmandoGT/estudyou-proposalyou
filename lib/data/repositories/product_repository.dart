// lib/data/repositories/product_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/product_dto.dart';
import '../supabase/supabase_provider.dart';

part 'product_repository.g.dart';

class ProductRepository {
  final SupabaseClient _client;
  const ProductRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('products');

  Future<List<ProductDto>> getAll({int offset = 0, int limit = 20, String? tipo}) async {
    try {
      var query = _table.select().isFilter('archived_at', null);
      if (tipo != null) query = query.eq('tipo', tipo);
      final data = await query.order('nome').range(offset, offset + limit - 1);
      return data.map(ProductDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProductDto> getById(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      return ProductDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProductDto> create(ProductDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      return ProductDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProductDto> update(ProductDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id).select().single();
      return ProductDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<List<ProductDto>> searchByName(String query) async {
    try {
      final data = await _table
          .select()
          .isFilter('archived_at', null)
          .ilike('nome', '%$query%')
          .order('nome')
          .limit(30);
      return data.map(ProductDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository(ref.watch(supabaseClientProvider));
}
