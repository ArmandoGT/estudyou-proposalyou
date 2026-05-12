import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/active_provider_context.dart';
import '../../../data/dtos/contract_template_dto.dart';
import '../../../data/repositories/contract_template_repository.dart';

final contractTemplateDetailProvider = FutureProvider.autoDispose.family((ref, String templateId) async {
  if (templateId == 'new') {
    final providerId = await ref.read(activeProviderIdProvider.future);
    if (providerId == null || providerId.isEmpty) {
      throw const ValidationException(
        'Selecione uma empresa específica para criar este item.',
        code: 'provider_required',
      );
    }
    return ContractTemplateDto(
      id: '',
      providerId: providerId,
      nome: '',
      corpoJson: const {'conteudo': ''},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  return ref.read(contractTemplateRepositoryProvider).getById(templateId);
});

class ContractTemplateEditScreen extends ConsumerStatefulWidget {
  final String templateId;
  const ContractTemplateEditScreen({super.key, required this.templateId});

  @override
  ConsumerState<ContractTemplateEditScreen> createState() => _ContractTemplateEditScreenState();
}

class _ContractTemplateEditScreenState extends ConsumerState<ContractTemplateEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _conteudoCtrl = TextEditingController();
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _conteudoCtrl.dispose();
    super.dispose();
  }

  void _init(ContractTemplateDto template) {
    if (_initialized) return;
    _initialized = true;
    _nomeCtrl.text = template.nome;
    _conteudoCtrl.text = template.corpoJson['conteudo']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final asyncTemplate = ref.watch(contractTemplateDetailProvider(widget.templateId));
    final isNew = widget.templateId == 'new';

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Novo Modelo de Contrato' : 'Editar Modelo de Contrato'),
        actions: [
          if (!isNew)
            IconButton(
              icon: const Icon(Icons.copy_all_outlined),
              onPressed: () async {
                await ref.read(contractTemplateRepositoryProvider).createNewVersion(widget.templateId);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nova versão criada com sucesso.')));
              },
            ),
        ],
      ),
      body: asyncTemplate.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (template) {
          _init(template);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nomeCtrl,
                    decoration: const InputDecoration(labelText: 'Nome do modelo'),
                    validator: (value) => value == null || value.trim().isEmpty ? 'Informe um nome' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _conteudoCtrl,
                    maxLines: 14,
                    decoration: const InputDecoration(
                      labelText: 'Conteúdo do contrato',
                      hintText: 'Use variáveis como {{cliente_nome}}, {{data_assinatura}} e {{hash_documento}}',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty ? 'Informe o conteúdo do modelo' : null,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Preview', style: Theme.of(context).textTheme.titleMedium),
                          const Divider(),
                          Text(_conteudoCtrl.text.isEmpty ? 'Nenhum conteúdo para pré-visualizar.' : _conteudoCtrl.text),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _isSaving ? null : () => _saveTemplate(template, isNew),
                    icon: _isSaving
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.save),
                    label: Text(_isSaving ? 'Salvando...' : 'Salvar modelo'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveTemplate(ContractTemplateDto original, bool isNew) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final updated = original.copyWith(
        nome: _nomeCtrl.text.trim(),
        corpoJson: {'conteudo': _conteudoCtrl.text.trim()},
      );

      if (isNew) {
        await ref.read(contractTemplateRepositoryProvider).create(updated.copyWith(id: ''));
      } else {
        await ref.read(contractTemplateRepositoryProvider).update(updated);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Modelo salvo com sucesso.')));
      context.pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
