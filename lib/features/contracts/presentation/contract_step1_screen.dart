// lib/features/contracts/presentation/contract_step1_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/dtos/proposal_dto.dart';
import '../../proposals/domain/proposal_notifier.dart';
import '../../proposals/domain/proposal_state.dart';
import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

class ContractStep1Screen extends ConsumerStatefulWidget {
  const ContractStep1Screen({super.key});

  @override
  ConsumerState<ContractStep1Screen> createState() => _ContractStep1ScreenState();
}

class _ContractStep1ScreenState extends ConsumerState<ContractStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  ProposalDto? _selectedProposal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(contractWizardProvider);
    final proposalsState = ref.watch(proposalListProvider);

    if (state is! ContractWizardStep1) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _selectedProposal ??= state.selectedProposal;

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Contrato (1/2)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Importar de Proposta', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              const Text('Selecione uma proposta aprovada para gerar o contrato automaticamente, ou deixe em branco para um contrato avulso.'),
              const SizedBox(height: 16),
              
              if (proposalsState is ProposalListLoading)
                const Center(child: CircularProgressIndicator())
              else if (proposalsState is ProposalListLoaded)
                DropdownButtonFormField<ProposalDto>(
                  value: _selectedProposal,
                  decoration: const InputDecoration(labelText: 'Selecione a Proposta'),
                  items: proposalsState.proposals
                      .where((p) => p.status == 'aprovada')
                      .map((p) => DropdownMenuItem(
                        value: p,
                        child: Text('Proposta de ${p.clienteNome}'),
                      )).toList(),
                  onChanged: (v) {
                    setState(() => _selectedProposal = v);
                    if (v != null) {
                      ref.read(contractWizardProvider.notifier).selectProposal(v, state.draft);
                    }
                  },
                ),
              
              const SizedBox(height: 32),
              
              FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  
                  final draft = state.draft;
                  ref.read(contractWizardProvider.notifier).goToStep(2, draft, proposal: _selectedProposal);
                  context.push('/contracts/new/step2');
                },
                child: const Text('Próximo: Cláusulas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
