// lib/features/proposals/presentation/proposal_step1_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/client_dto.dart';
import '../../../data/dtos/proposal_dto.dart';
import '../../clients/domain/client_notifier.dart';
import '../../clients/domain/client_state.dart';
import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

class ProposalStep1Screen extends ConsumerStatefulWidget {
  final ClientDto? initialClient;
  const ProposalStep1Screen({super.key, this.initialClient});

  @override
  ConsumerState<ProposalStep1Screen> createState() => _ProposalStep1ScreenState();
}

class _ProposalStep1ScreenState extends ConsumerState<ProposalStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _observacoesCtrl = TextEditingController();
  final _validadeCtrl = TextEditingController();
  
  ClientDto? _selectedClient;
  DateTime? _validadeDate;
  bool _initialized = false;

  @override
  void dispose() {
    _observacoesCtrl.dispose();
    _validadeCtrl.dispose();
    super.dispose();
  }

  void _init(ProposalDto draft) {
    if (_initialized) return;
    _initialized = true;
    _observacoesCtrl.text = draft.observacoes ?? '';
    if (draft.validade != null) {
      _validadeDate = draft.validade;
      _validadeCtrl.text = DateFormat('dd/MM/yyyy').format(draft.validade!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalWizardProvider);
    final clientsState = ref.watch(clientListProvider);

    if (state is! ProposalWizardStep1) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    _init(state.draft);
    if (_selectedClient == null && widget.initialClient != null) {
      _selectedClient = widget.initialClient;
    } else if (_selectedClient == null && state.draft.clientId?.isNotEmpty == true && clientsState is ClientListLoaded) {
      try {
        _selectedClient = clientsState.clients.firstWhere((c) => c.id == state.draft.clientId);
      } catch (_) {}
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Proposta (1/3)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Informações Básicas', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _observacoesCtrl,
                decoration: const InputDecoration(labelText: 'Observações (Opcional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _validadeCtrl,
                decoration: const InputDecoration(labelText: 'Validade (opcional)', suffixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _validadeDate ?? DateTime.now().add(const Duration(days: 15)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _validadeDate = date;
                      _validadeCtrl.text = DateFormat('dd/MM/yyyy').format(date);
                    });
                  }
                },
              ),
              const SizedBox(height: 24),

              Text('Cliente', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),
              
              if (clientsState is ClientListLoading)
                const Center(child: CircularProgressIndicator())
              else if (clientsState is ClientListLoaded)
                DropdownButtonFormField<ClientDto>(
                  initialValue: _selectedClient,
                  decoration: const InputDecoration(labelText: 'Selecione o Cliente'),
                  items: clientsState.clients.map((c) => DropdownMenuItem(
                    value: c,
                    child: Text('${c.nome} (${c.cpfCnpj})'),
                  )).toList(),
                  onChanged: (v) => setState(() => _selectedClient = v),
                  validator: (v) => v == null ? 'Selecione um cliente' : null,
                ),
              
              const SizedBox(height: 32),
              
              FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate() || _selectedClient == null) return;
                  
                  final draft = state.draft.copyWith(
                    observacoes: _observacoesCtrl.text.trim(),
                    clientId: _selectedClient!.id,
                    validade: _validadeDate,
                  );
                  ref.read(proposalWizardProvider.notifier).goToStep(2, draft);
                  context.push('/proposals/new/step2');
                },
                child: const Text('Próximo: Itens'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
