// lib/data/repositories/proposal_template_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/proposal_template_dto.dart';
import '../supabase/supabase_provider.dart';

part 'proposal_template_repository.g.dart';

class ProposalTemplateRepository {
  final SupabaseClient _client;
  const ProposalTemplateRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('proposal_templates');

  Future<List<ProposalTemplateDto>> getAll() async {
    try {
      final data = await _table.select().order('nome');
      return data.map(ProposalTemplateDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalTemplateDto> getById(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      return ProposalTemplateDto.fromJson(data);
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
      return ProposalTemplateDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ProposalTemplateDto> update(ProposalTemplateDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id).select().single();
      return ProposalTemplateDto.fromJson(data);
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
      return ProposalTemplateDto.fromJson(data);
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
}

@riverpod
ProposalTemplateRepository proposalTemplateRepository(Ref ref) {
  return ProposalTemplateRepository(ref.watch(supabaseClientProvider));
}
