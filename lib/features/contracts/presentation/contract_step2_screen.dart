// lib/features/contracts/presentation/contract_step2_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

class ContractStep2Screen extends ConsumerStatefulWidget {
  const ContractStep2Screen({super.key});

  @override
  ConsumerState<ContractStep2Screen> createState() => _ContractStep2ScreenState();
}

class _ContractStep2ScreenState extends ConsumerState<ContractStep2Screen> {
  final _htmlCtrl = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _htmlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(contractWizardProvider);

    if (state is! ContractWizardStep2) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final draft = state.draft;

    if (!_initialized) {
      _initialized = true;
      _htmlCtrl.text = draft.textoFinal ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cláusulas (2/2)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Conteúdo do Contrato', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: TextFormField(
                controller: _htmlCtrl,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Escreva as cláusulas do contrato aqui ou utilize um template (HTML).',
                  border: OutlineInputBorder(),
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
                onPressed: () {
                  final newDraft = draft.copyWith(textoFinal: _htmlCtrl.text);
                  ref.read(contractWizardProvider.notifier).goToStep(1, newDraft, proposal: state.selectedProposal);
                  context.pop();
                },
                child: const Text('Voltar'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: () {
                  final newDraft = draft.copyWith(textoFinal: _htmlCtrl.text);
                  ref.read(contractWizardProvider.notifier).goToStep(3, newDraft, proposal: state.selectedProposal);
                  context.push('/contracts/new/step3');
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Próximo: Resumo'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
