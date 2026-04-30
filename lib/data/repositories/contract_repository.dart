// lib/data/repositories/contract_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/contract_dto.dart';
import '../supabase/supabase_provider.dart';

part 'contract_repository.g.dart';

class ContractRepository {
  final SupabaseClient _client;
  const ContractRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('contracts');

  Future<List<ContractDto>> getAll({
    int offset = 0, int limit = 20, String? status,
  }) async {
    try {
      var query = _table.select('*, client:clients(nome), signatures(id)');
      if (status != null) query = query.eq('status', status);
      final data = await query.order('updated_at', ascending: false)
          .range(offset, offset + limit - 1);
      return data.map(ContractDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractDto> getById(String id) async {
    try {
      final data = await _table
          .select('*, client:clients(nome), signatures(id)')
          .eq('id', id).single();
      return ContractDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractDto> create(ContractDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      return ContractDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractDto> update(ContractDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id)
          .select().single();
      return ContractDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Busca contrato por share_token (acesso público para assinatura).
  Future<ContractDto?> getByShareToken(String token) async {
    try {
      final data = await _table
          .select('*, client:clients(nome), signatures(id)')
          .eq('share_token', token).maybeSingle();
      return data != null ? ContractDto.fromJson(data) : null;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Atualiza status. Usado após todas as assinaturas serem coletadas.
  Future<void> updateStatus(String id, String status) async {
    try {
      await _table.update({'status': status}).eq('id', id);
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
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Contagem de contratos aguardando assinatura (Dashboard).
  Future<int> countAguardandoAssinatura() async {
    try {
      final data = await _table.select('id')
          .eq('status', 'aguardando_assinatura');
      return (data as List).length;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
  Future<List<ContractDto>> search(String query) async {
    try {
      final data = await _table.select('*, client:clients(nome), signatures(id)')
          .ilike('id', '%$query%')
          .order('updated_at', ascending: false)
          .limit(20);
      return data.map(ContractDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
ContractRepository contractRepository(Ref ref) {
  return ContractRepository(ref.watch(supabaseClientProvider));
}
