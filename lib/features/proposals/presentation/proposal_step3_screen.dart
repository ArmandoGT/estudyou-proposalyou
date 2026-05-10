import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/services/active_provider_context.dart';
import '../../../core/services/pdf_service.dart';
import '../../../core/services/share_service.dart';
import '../../../data/repositories/proposal_repository.dart';
import '../../../shared/widgets/tenant_brand_card.dart';
import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

final _brl = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _date = DateFormat('dd/MM/yyyy');

class ProposalStep3Screen extends ConsumerStatefulWidget {
  const ProposalStep3Screen({super.key});

  @override
  ConsumerState<ProposalStep3Screen> createState() => _ProposalStep3ScreenState();
}

class _ProposalStep3ScreenState extends ConsumerState<ProposalStep3Screen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalWizardProvider);
    final activeProviderAsync = ref.watch(activeProviderProvider);

    if (state is! ProposalWizardStep3 && state is! ProposalWizardSaving && state is! ProposalWizardError) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final draft = switch (state) {
      ProposalWizardStep3(:final draft) => draft,
      ProposalWizardError(:final draft) => draft,
      _ => null,
    };

    if (draft == null) return const SizedBox();

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo da Proposta (3/3)')),
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
                  title: 'Identidade da proposta',
                  subtitle: draft.providerId ?? provider?.empresa,
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
                    _InfoRow('Cliente:', draft.clienteNome ?? draft.clientId ?? 'Não informado'),
                    _InfoRow('Status:', (draft.status ?? 'rascunho').toUpperCase()),
                    _InfoRow('Validade:', draft.validade != null ? _date.format(draft.validade!) : 'Sem validade'),
                    _InfoRow('Modelo:', draft.templateId ?? 'Sem modelo'),
                    _InfoRow('Empresa:', draft.providerId ?? 'Sem empresa'),
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
                    Text('Itens (${draft.itensJson.length})', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                    const Divider(),
                    ...draft.itensJson.map((item) {
                      final qty = (item['quantidade'] as num).toDouble();
                      final price = (item['preco_unitario'] as num).toDouble();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('${qty.toStringAsFixed(qty % 1 == 0 ? 0 : 2)}x ${item['nome']}')),
                            Text(_brl.format(qty * price)),
                          ],
                        ),
                      );
                    }),
                    const Divider(),
                    _InfoRow('Desconto:', _brl.format(draft.desconto)),
                    _InfoRow('Total:', _brl.format(draft.total)),
                  ],
                ),
              ),
            ),
            if (draft.observacoes?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Observações', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                      const Divider(),
                      Text(draft.observacoes!),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              ref.read(proposalWizardProvider.notifier).goToStep(2, draft);
                              context.pop();
                            },
                      child: const Text('Voltar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: _isLoading ? null : () => _saveProposal(context),
                      icon: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Icon(Icons.save),
                      label: Text(_isLoading ? 'Salvando...' : 'Salvar Proposta'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  OutlinedButton.icon(
                    onPressed: draft.id != null && draft.id!.isNotEmpty && draft.shareToken?.isNotEmpty == true
                        ? () async {
                            final url = ref.read(shareServiceProvider).proposalLink(draft);
                            await ref.read(shareServiceProvider).copyLinkToClipboard(url);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copiado!')));
                          }
                        : null,
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar link'),
                  ),
                  OutlinedButton.icon(
                    onPressed: draft.id != null && draft.id!.isNotEmpty
                        ? () async {
                            await ref.read(shareServiceProvider).shareProposal(draft);
                          }
                        : null,
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Compartilhar'),
                  ),
                  OutlinedButton.icon(
                    onPressed: draft.id != null && draft.id!.isNotEmpty
                        ? () async {
                            final pdfBytes = await ref.read(pdfServiceProvider).generateProposalPdf(draft);
                            final path = await ref.read(shareServiceProvider).downloadPdf(
                                  pdfBytes,
                                  'proposta_${draft.id}.pdf',
                                );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Prévia local salva em $path')));
                          }
                        : null,
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: const Text('Salvar prévia local'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Ao salvar, a proposta também gera e envia um PDF final para o Storage. O botão acima mantém a prévia local para conferência rápida.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProposal(BuildContext context) async {
    final state = ref.read(proposalWizardProvider);
    if (state is! ProposalWizardStep3) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(proposalWizardProvider.notifier).save(
            state.draft,
            isNew: state.draft.id == null || state.draft.id!.isEmpty,
          );

      if (!context.mounted) return;

      final currentState = ref.read(proposalWizardProvider);
      if (currentState is ProposalWizardSuccess) {
        final savedProposal = currentState.proposal;
        final pdfBytes = await ref.read(pdfServiceProvider).generateProposalPdf(savedProposal);
        final pdfUrl = await ref.read(pdfServiceProvider).uploadPdf(
              bytes: pdfBytes,
              providerId: savedProposal.providerId ?? '',
              fileName: 'proposal_v${savedProposal.versao}.pdf',
              objectPath: '${savedProposal.providerId}/proposals/${savedProposal.id}/proposal_v${savedProposal.versao}.pdf',
            );
        await ref.read(proposalRepositoryProvider).updatePdfUrl(savedProposal.id!, pdfUrl);
        ref.invalidate(proposalDetailProvider(savedProposal.id!));

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proposta salva com sucesso! PDF final enviado ao Storage.')),
        );
        context.go('/proposals/${savedProposal.id}');
        ref.read(proposalWizardProvider.notifier).reset();
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
