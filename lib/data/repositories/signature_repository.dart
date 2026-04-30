// lib/data/repositories/signature_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/signature_dto.dart';
import '../supabase/supabase_provider.dart';

part 'signature_repository.g.dart';

class SignatureRepository {
  final SupabaseClient _client;
  const SignatureRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('signatures');

  /// Lista todas as assinaturas de um contrato.
  Future<List<SignatureDto>> getByContractId(String contractId) async {
    try {
      final data = await _table.select()
          .eq('contract_id', contractId)
          .order('signed_at');
      return data.map(SignatureDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Registra assinatura com IP, geolocalização e timestamp.
  Future<SignatureDto> signContract({required SignatureDto dto}) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      return SignatureDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Verifica se um signatário já assinou o contrato (por email ou nome).
  Future<bool> hasAlreadySigned({
    required String contractId,
    required String signatarioNome,
  }) async {
    try {
      final data = await _table.select('id')
          .eq('contract_id', contractId)
          .eq('signatario_nome', signatarioNome)
          .maybeSingle();
      return data != null;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Conta assinaturas realizadas em um contrato.
  Future<int> countByContract(String contractId) async {
    try {
      final data = await _table.select('id').eq('contract_id', contractId);
      return (data as List).length;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
SignatureRepository signatureRepository(Ref ref) {
  return SignatureRepository(ref.watch(supabaseClientProvider));
}
