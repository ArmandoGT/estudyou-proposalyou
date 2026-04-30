// lib/features/proposals/presentation/proposal_step3_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

final _brl = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _date = DateFormat('dd/MM/yyyy');

class ProposalStep3Screen extends ConsumerWidget {
  const ProposalStep3Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalWizardProvider);

    ref.listen(proposalWizardProvider, (_, s) {
      if (s is ProposalWizardSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Proposta salva!')));
        context.go('/proposals/${s.proposal.id}');
        ref.read(proposalWizardProvider.notifier).reset();
      } else if (s is ProposalWizardError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.message), backgroundColor: theme.colorScheme.error));
      }
    });

    if (state is! ProposalWizardStep3 && state is! ProposalWizardSaving && state is! ProposalWizardError) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final draft = (state is ProposalWizardStep3)
        ? state.draft
        : (state is ProposalWizardError) ? state.draft : null;

    if (draft == null) return const SizedBox(); // Fallback durante salvamento

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo (3/3)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dados Gerais', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
                    const Divider(),
                    _InfoRow('Observações:', draft.observacoes ?? 'Nenhuma'),
                    _InfoRow('Validade:', draft.validade != null ? _date.format(draft.validade!) : 'Sem validade'),
                    _InfoRow('Status Inicial:', draft.status.toUpperCase()),
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
                    ...draft.itensJson.map((i) {
                      final qtd = (i['quantidade'] as num).toDouble();
                      final preco = (i['preco_unitario'] as num).toDouble();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text('${qtd}x ${i['nome']}')),
                            Text(_brl.format(qtd * preco)),
                          ],
                        ),
                      );
                    }),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_brl.format(draft.total), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
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
          child: Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: state is ProposalWizardSaving ? null : () {
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
                onPressed: state is ProposalWizardSaving ? null : () {
                  ref.read(proposalWizardProvider.notifier).save(draft, isNew: draft.id.isEmpty);
                },
                icon: state is ProposalWizardSaving 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.save),
                label: Text(state is ProposalWizardSaving ? 'Salvando...' : 'Salvar Proposta'),
              ),
            ),
          ]),
        ),
      ),
    );
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
