// lib/data/repositories/proposal_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/proposal_dto.dart';
import '../supabase/supabase_provider.dart';

part 'proposal_repository.g.dart';

class ProposalRepository {
  final SupabaseClient _client;
  const ProposalRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('proposals');

  Future<List<ProposalDto>> getAll({
    int offset = 0, int limit = 20,
    String? status, String? providerId,
  }) async {
    try {
      var query = _table.select('*, client:clients(nome)');
      if (status != null) query = query.eq('status', status);
      if (providerId != null) query = query.eq('provider_id', providerId);
      final data = await query.order('updated_at', ascending: false)
          .range(offset, offset + limit - 1);
      return data.map(ProposalDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalDto> getById(String id) async {
    try {
      final data = await _table.select('*, client:clients(nome)')
          .eq('id', id).single();
      return ProposalDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalDto> create(ProposalDto dto) async {
    try {
      final data = await _table.insert(dto.toJson()).select().single();
      return ProposalDto.fromJson(data);
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
      return ProposalDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<void> updateStatus(String id, String status) async {
    try {
      await _table.update({'status': status}).eq('id', id);
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
      return ProposalDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalDto?> getByShareToken(String token) async {
    try {
      final data = await _table.select('*, client:clients(nome)')
          .eq('share_token', token).maybeSingle();
      return data != null ? ProposalDto.fromJson(data) : null;
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Itens recentes para o Dashboard (propostas + updated_at desc).
  Future<List<ProposalDto>> getRecentItems({int limit = 5}) async {
    try {
      final data = await _table
          .select('id, status, client:clients(nome), total, updated_at, provider_id, client_id, created_at')
          .order('updated_at', ascending: false)
          .limit(limit);
      return data.map(ProposalDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  /// Contagem de propostas por status para métricas do Dashboard.
  Future<Map<String, int>> getCountByStatus() async {
    try {
      final data = await _table.select('status');
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
  Future<List<ProposalDto>> search(String query) async {
    try {
      final data = await _table.select('*, client:clients(nome)')
          .ilike('id', '%$query%')
          .order('updated_at', ascending: false)
          .limit(20);
      return data.map(ProposalDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
ProposalRepository proposalRepository(Ref ref) {
  return ProposalRepository(ref.watch(supabaseClientProvider));
}
