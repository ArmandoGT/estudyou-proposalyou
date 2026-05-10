import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/services/active_provider_context.dart';
import '../../../core/services/share_service.dart';
import '../../../shared/widgets/tenant_brand_card.dart';
import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

final _date = DateFormat('dd/MM/yyyy');

class ContractStep3Screen extends ConsumerStatefulWidget {
  const ContractStep3Screen({super.key});

  @override
  ConsumerState<ContractStep3Screen> createState() => _ContractStep3ScreenState();
}

class _ContractStep3ScreenState extends ConsumerState<ContractStep3Screen> {
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(contractWizardProvider);
    final activeProviderAsync = ref.watch(activeProviderProvider);

    if (state is! ContractWizardStep3 && state is! ContractWizardSaving && state is! ContractWizardError) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final draft = switch (state) {
      ContractWizardStep3(:final draft) => draft,
      ContractWizardError(:final draft) => draft,
      _ => null,
    };

    final selectedProposal = switch (state) {
      ContractWizardStep3(:final selectedProposal) => selectedProposal,
      _ => null,
    };

    if (draft == null) return const SizedBox();

    final shareService = ref.read(shareServiceProvider);
    final hasLink = draft.shareToken?.isNotEmpty == true;

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do Contrato (3/3)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            activeProviderAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (provider) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TenantBrandCard(
                  provider: provider,
                  title: 'Identidade da empresa',
                  subtitle: draft.providerId,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dados Gerais', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                    const Divider(),
                    _InfoRow('Cliente:', draft.clienteNome ?? draft.clientId),
                    _InfoRow('Status:', draft.status.toUpperCase()),
                    _InfoRow('Assinaturas:', draft.progressoAssinaturas),
                    if (draft.vigenciaInicio != null)
                      _InfoRow(
                        'Vigência:',
                        draft.vigenciaFim != null
                            ? '${_date.format(draft.vigenciaInicio!)} até ${_date.format(draft.vigenciaFim!)}'
                            : _date.format(draft.vigenciaInicio!),
                      ),
                    if (draft.proposalId != null) _InfoRow('Proposta:', draft.proposalId!),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Preview do Contrato', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                    const Divider(),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 220),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.colorScheme.outlineVariant),
                      ),
                      child: Text(
                        (draft.textoFinal ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ').trim().isEmpty
                            ? 'Nenhuma cláusula informada.'
                            : (draft.textoFinal ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ações finais', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                    const Divider(),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FilledButton.icon(
                          onPressed: _isSaving ? null : () => _saveAndOpenDetail(context),
                          icon: _isSaving
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.save),
                          label: Text(_isSaving ? 'Salvando...' : 'Salvar contrato'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isSaving || !hasLink ? null : () async {
                            final url = shareService.contractSignLink(draft);
                            await shareService.copyLinkToClipboard(url);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copiado!')));
                          },
                          icon: const Icon(Icons.copy_all_outlined),
                          label: const Text('Copiar link'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isSaving || !hasLink ? null : () async {
                            await shareService.shareContract(draft);
                          },
                          icon: const Icon(Icons.share_outlined),
                          label: const Text('Compartilhar'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final message = hasLink
                                ? 'O PDF final ficará disponível após todas as assinaturas serem concluídas.'
                                : 'Salve o contrato primeiro para habilitar o link público e depois finalize as assinaturas para gerar o PDF final.';
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)),
                            );
                          },
                          icon: const Icon(Icons.picture_as_pdf_outlined),
                          label: const Text('PDF final após assinaturas'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      hasLink
                          ? 'Após a última assinatura, o sistema gera, envia e vincula automaticamente o PDF final do contrato.'
                          : 'O link público ficará disponível após o contrato ser salvo com share token válido.',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSaving
                      ? null
                      : () {
                          ref.read(contractWizardProvider.notifier).goToStep(2, draft, proposal: selectedProposal);
                          context.pop();
                        },
                  child: const Text('Voltar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _isSaving ? null : () => _saveAndOpenDetail(context),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Concluir contrato'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndOpenDetail(BuildContext context) async {
    final state = ref.read(contractWizardProvider);
    if (state is! ContractWizardStep3) return;

    setState(() => _isSaving = true);
    try {
      await ref.read(contractWizardProvider.notifier).save(
            state.draft,
            isNew: state.draft.id.isEmpty,
            proposal: state.selectedProposal,
          );

      if (!context.mounted) return;
      final currentState = ref.read(contractWizardProvider);
      if (currentState is ContractWizardSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contrato salvo com sucesso!')));
        context.go('/contracts/${currentState.contract.id}');
        ref.read(contractWizardProvider.notifier).reset();
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
