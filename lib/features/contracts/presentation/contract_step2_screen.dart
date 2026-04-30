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

    ref.listen(contractWizardProvider, (_, s) {
      if (s is ContractWizardSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contrato salvo!')));
        context.go('/contracts/${s.contract.id}');
        ref.read(contractWizardProvider.notifier).reset();
      } else if (s is ContractWizardError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.message), backgroundColor: theme.colorScheme.error));
      }
    });

    if (state is! ContractWizardStep2 && state is! ContractWizardSaving && state is! ContractWizardError) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final draft = (state is ContractWizardStep2)
        ? state.draft
        : (state is ContractWizardError) ? state.draft : null;

    if (draft == null) return const SizedBox();

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
                onPressed: state is ContractWizardSaving ? null : () {
                  final newDraft = draft.copyWith(textoFinal: _htmlCtrl.text);
                  ref.read(contractWizardProvider.notifier).goToStep(1, newDraft, proposal: (state as dynamic).selectedProposal);
                  context.pop();
                },
                child: const Text('Voltar'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: state is ContractWizardSaving ? null : () {
                  final newDraft = draft.copyWith(textoFinal: _htmlCtrl.text);
                  ref.read(contractWizardProvider.notifier).save(newDraft, isNew: newDraft.id.isEmpty);
                },
                icon: state is ContractWizardSaving 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.save),
                label: Text(state is ContractWizardSaving ? 'Salvando...' : 'Salvar Contrato'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
