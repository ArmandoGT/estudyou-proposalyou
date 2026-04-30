// lib/data/repositories/client_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/client_dto.dart';
import '../supabase/supabase_provider.dart';

part 'client_repository.g.dart';

class ClientRepository {
  final SupabaseClient _client;
  const ClientRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('clients');

  /// Lista clientes com paginação. Exclui arquivados por padrão.
  Future<List<ClientDto>> getAll({int offset = 0, int limit = 20}) async {
    try {
      final data = await _table
          .select()
          .isFilter('archived_at', null)
          .order('nome')
          .range(offset, offset + limit - 1);
      return data.map(ClientDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ClientDto> getById(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      return ClientDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ClientDto> create(ClientDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      return ClientDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ClientDto> update(ClientDto dto) async {
    try {
      final data = await _table
          .update(dto.toJson())
          .eq('id', dto.id)
          .select()
          .single();
      return ClientDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Busca Full Text Search via trigrams (pg_trgm).
  Future<List<ClientDto>> search(String query) async {
    try {
      final data = await _table
          .select()
          .isFilter('archived_at', null)
          .or('nome.ilike.%$query%,cpf_cnpj.ilike.%$query%')
          .order('nome')
          .limit(50);
      return data.map(ClientDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Soft-delete: seta archived_at com timestamp atual.
  Future<void> archive(String id) async {
    try {
      await _table.update({
        'archived_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
ClientRepository clientRepository(Ref ref) {
  return ClientRepository(ref.watch(supabaseClientProvider));
}
