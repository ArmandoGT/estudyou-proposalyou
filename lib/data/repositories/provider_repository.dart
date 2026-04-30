// lib/data/repositories/provider_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/provider_dto.dart';
import '../supabase/supabase_provider.dart';

part 'provider_repository.g.dart';

class ProviderRepository {
  final SupabaseClient _client;
  const ProviderRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('providers');

  Future<List<ProviderDto>> getAll() async {
    try {
      final data = await _table.select().order('empresa');
      return data.map(ProviderDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProviderDto> getById(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      return ProviderDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProviderDto> getBySlug(String slug) async {
    try {
      final data = await _table.select().eq('empresa', slug).single();
      return ProviderDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProviderDto> update(ProviderDto dto) async {
    try {
      final data = await _table
          .update(dto.toJson())
          .eq('id', dto.id)
          .select()
          .single();
      return ProviderDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Atualiza apenas a URL do logo após upload no Storage.
  Future<void> updateLogoUrl(String id, String logoUrl) async {
    try {
      await _table.update({'logo_url': logoUrl}).eq('id', id);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
ProviderRepository providerRepository(Ref ref) {
  return ProviderRepository(ref.watch(supabaseClientProvider));
}
