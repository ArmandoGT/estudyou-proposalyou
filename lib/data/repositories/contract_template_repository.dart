// lib/data/repositories/contract_template_repository.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/error/app_exception.dart';
import '../dtos/contract_template_dto.dart';
import '../supabase/supabase_provider.dart';

part 'contract_template_repository.g.dart';

class ContractTemplateRepository {
  final SupabaseClient _client;
  const ContractTemplateRepository(this._client);

  SupabaseQueryBuilder get _table => _client.from('contract_templates');

  Future<List<ContractTemplateDto>> getAll() async {
    try {
      final data = await _table.select().order('nome');
      return data.map(ContractTemplateDto.fromJson).toList();
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractTemplateDto> getById(String id) async {
    try {
      final data = await _table.select().eq('id', id).single();
      return ContractTemplateDto.fromJson(data);
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
      return ContractTemplateDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }

  Future<ContractTemplateDto> update(ContractTemplateDto dto) async {
    try {
      final data = await _table.update(dto.toJson()).eq('id', dto.id).select().single();
      return ContractTemplateDto.fromJson(data);
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
      return ContractTemplateDto.fromJson(data);
    } on PostgrestException catch (e) {
      throw e.toAppException();
    }
  }
}

@riverpod
ContractTemplateRepository contractTemplateRepository(Ref ref) {
  return ContractTemplateRepository(ref.watch(supabaseClientProvider));
}
