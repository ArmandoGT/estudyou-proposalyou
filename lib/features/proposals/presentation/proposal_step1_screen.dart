import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/services/active_provider_context.dart';
import '../../../data/dtos/client_dto.dart';
import '../../../data/dtos/proposal_dto.dart';
import '../../../data/dtos/proposal_template_dto.dart';
import '../../../data/repositories/proposal_template_repository.dart';
import '../../clients/domain/client_notifier.dart';
import '../../clients/domain/client_state.dart';
import '../../providers/domain/provider_notifier.dart';
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
  String? _selectedProviderId;
  String? _selectedTemplateId;
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
    _selectedProviderId = _normalizeSelection(draft.providerId);
    _selectedTemplateId = _normalizeSelection(draft.templateId);
    if (draft.validade != null) {
      _validadeDate = draft.validade;
      _validadeCtrl.text = DateFormat('dd/MM/yyyy').format(draft.validade!);
    }
  }

  String? _normalizeSelection(String? value) {
    if (value == null) return null;
    final normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalWizardProvider);
    final clientsState = ref.watch(clientListProvider);
    final providersAsync = ref.watch(providerListProvider);
    final activeProviderAsync = ref.watch(activeProviderIdProvider);
    final templatesAsync = activeProviderAsync.when(
      data: (providerId) => ref.watch(proposalTemplateRepositoryProvider).getAll(providerId: providerId),
      loading: () async => const [],
      error: (_, _) async => const [],
    );

    if (state is! ProposalWizardStep1) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _init(state.draft);
    activeProviderAsync.whenData((providerId) {
      if ((_selectedProviderId == null || _selectedProviderId!.isEmpty) && providerId != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && (_selectedProviderId == null || _selectedProviderId!.isEmpty)) {
            setState(() => _selectedProviderId = providerId);
          }
        });
      }
    });
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
              providersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => const SizedBox.shrink(),
                data: (providers) {
                  final providerItems = providers
                      .map((provider) => DropdownMenuItem<String>(
                            value: provider.id,
                            child: Text(provider.razaoSocial),
                          ))
                      .toList();
                  final validProviderIds = providers.map((provider) => provider.id).toSet();
                  final selectedProviderId = validProviderIds.contains(_selectedProviderId)
                      ? _selectedProviderId
                      : null;

                  if (selectedProviderId != _selectedProviderId) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() => _selectedProviderId = selectedProviderId);
                      }
                    });
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: selectedProviderId,
                    decoration: const InputDecoration(labelText: 'Empresa'),
                    items: providerItems,
                    onChanged: (value) => setState(() => _selectedProviderId = value),
                    validator: (value) => value == null || value.isEmpty ? 'Selecione uma empresa' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: templatesAsync,
                builder: (context, snapshot) {
                  final templates = snapshot.data ?? const <ProposalTemplateDto>[];
                  final activeTemplates = templates.where((template) => template.ativo).toList();
                  final validTemplateIds = activeTemplates.map((template) => template.id).toSet();
                  final selectedTemplateId = validTemplateIds.contains(_selectedTemplateId)
                      ? _selectedTemplateId
                      : null;

                  if (selectedTemplateId != _selectedTemplateId) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() => _selectedTemplateId = selectedTemplateId);
                      }
                    });
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: selectedTemplateId,
                    decoration: const InputDecoration(labelText: 'Modelo de proposta'),
                    items: activeTemplates
                        .map((template) => DropdownMenuItem<String>(
                              value: template.id,
                              child: Text(template.nome),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedTemplateId = value),
                  );
                },
              ),
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
              else if (clientsState is ClientListLoaded) ...[
                DropdownButtonFormField<ClientDto>(
                  initialValue: _selectedClient,
                  decoration: const InputDecoration(labelText: 'Selecione o Cliente'),
                  items: clientsState.clients
                      .map((client) => DropdownMenuItem(
                            value: client,
                            child: Text('${client.nome} (${client.cpfCnpj})'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedClient = value),
                  validator: (value) => value == null ? 'Selecione um cliente' : null,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/clients/new'),
                    icon: const Icon(Icons.person_add_alt_1),
                    label: const Text('Criar novo cliente'),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate() || _selectedClient == null) return;

                  final draft = state.draft.copyWith(
                    observacoes: _observacoesCtrl.text.trim(),
                    clientId: _selectedClient!.id,
                    providerId: _selectedProviderId,
                    templateId: _selectedTemplateId,
                    validade: _validadeDate,
                    clienteNome: _selectedClient!.nome,
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
