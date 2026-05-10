import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/auth_service.dart';
import '../../../data/dtos/proposal_template_dto.dart';
import '../../../data/repositories/proposal_template_repository.dart';

final proposalTemplateDetailProvider = FutureProvider.autoDispose.family((ref, String templateId) async {
  if (templateId == 'new') {
    final providerId = await ref.read(authServiceProvider.notifier).getActiveProviderId() ?? '';
    return ProposalTemplateDto(
      id: '',
      providerId: providerId,
      nome: '',
      corpoJson: const {'conteudo': ''},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  return ref.read(proposalTemplateRepositoryProvider).getById(templateId);
});

class ProposalTemplateEditScreen extends ConsumerStatefulWidget {
  final String templateId;
  const ProposalTemplateEditScreen({super.key, required this.templateId});

  @override
  ConsumerState<ProposalTemplateEditScreen> createState() => _ProposalTemplateEditScreenState();
}

class _ProposalTemplateEditScreenState extends ConsumerState<ProposalTemplateEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _conteudoCtrl = TextEditingController();
  bool _ativo = true;
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _conteudoCtrl.dispose();
    super.dispose();
  }

  void _init(ProposalTemplateDto template) {
    if (_initialized) return;
    _initialized = true;
    _nomeCtrl.text = template.nome;
    _conteudoCtrl.text = template.corpoJson['conteudo']?.toString() ?? '';
    _ativo = template.ativo;
  }

  @override
  Widget build(BuildContext context) {
    final asyncTemplate = ref.watch(proposalTemplateDetailProvider(widget.templateId));
    final isNew = widget.templateId == 'new';

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? 'Novo Modelo de Proposta' : 'Editar Modelo de Proposta'),
        actions: [
          if (!isNew)
            IconButton(
              icon: const Icon(Icons.copy_all_outlined),
              onPressed: () async {
                await ref.read(proposalTemplateRepositoryProvider).duplicate(widget.templateId);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Modelo duplicado com sucesso.')));
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
                  SwitchListTile(
                    value: _ativo,
                    onChanged: (value) => setState(() => _ativo = value),
                    title: const Text('Modelo ativo'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _conteudoCtrl,
                    maxLines: 12,
                    decoration: const InputDecoration(
                      labelText: 'Conteúdo do modelo',
                      hintText: 'Use variáveis como {{cliente_nome}} e {{total}}',
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
                          const Text('Preview'),
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

  Future<void> _saveTemplate(ProposalTemplateDto original, bool isNew) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      final updated = original.copyWith(
        nome: _nomeCtrl.text.trim(),
        corpoJson: {'conteudo': _conteudoCtrl.text.trim()},
        ativo: _ativo,
      );

      if (isNew) {
        await ref.read(proposalTemplateRepositoryProvider).create(updated.copyWith(id: ''));
      } else {
        await ref.read(proposalTemplateRepositoryProvider).update(updated);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Modelo salvo com sucesso.')));
      context.pop();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
