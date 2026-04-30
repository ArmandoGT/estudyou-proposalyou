// lib/features/clients/presentation/client_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../data/dtos/client_dto.dart';
import '../domain/client_notifier.dart';
import '../domain/client_state.dart';

class ClientDetailScreen extends ConsumerStatefulWidget {
  final String clientId;
  const ClientDetailScreen({super.key, required this.clientId});

  @override
  ConsumerState<ClientDetailScreen> createState() => _ClientDetailScreenState();
}

class _ClientDetailScreenState extends ConsumerState<ClientDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _docCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _logradouroCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _ufCtrl = TextEditingController();
  final _numeroCtrl = TextEditingController();

  bool _isPF = true;
  bool _formInitialized = false;

  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
  final _cnpjFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});
  final _telFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});

  @override
  void dispose() {
    _nomeCtrl.dispose(); _docCtrl.dispose(); _emailCtrl.dispose();
    _telefoneCtrl.dispose(); _cepCtrl.dispose(); _logradouroCtrl.dispose();
    _bairroCtrl.dispose(); _cidadeCtrl.dispose(); _ufCtrl.dispose();
    _numeroCtrl.dispose();
    super.dispose();
  }

  void _initForm(ClientDto client, bool isNew) {
    if (_formInitialized) return;
    _formInitialized = true;
    _nomeCtrl.text = client.nome;
    _docCtrl.text = client.cpfCnpj;
    _emailCtrl.text = client.email ?? '';
    _telefoneCtrl.text = client.telefone ?? '';
    _isPF = isNew || client.isPessoaFisica;

    final addr = client.endereco;
    if (addr != null) {
      _cepCtrl.text = addr['cep']?.toString() ?? '';
      _logradouroCtrl.text = addr['logradouro']?.toString() ?? '';
      _bairroCtrl.text = addr['bairro']?.toString() ?? '';
      _cidadeCtrl.text = addr['cidade']?.toString() ?? '';
      _ufCtrl.text = addr['uf']?.toString() ?? '';
      _numeroCtrl.text = addr['numero']?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = widget.clientId == 'new';
    final state = ref.watch(clientDetailProvider(isNew ? null : widget.clientId));

    ref.listen(clientDetailProvider(isNew ? null : widget.clientId), (_, s) {
      if (s is ClientDetailSaved) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente salvo com sucesso!')),
        );
        context.pop();
      } else if (s is ClientDetailError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.message), backgroundColor: theme.colorScheme.error),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(isNew ? 'Novo Cliente' : 'Editar Cliente')),
      body: switch (state) {
        ClientDetailLoading() => const Center(child: CircularProgressIndicator()),
        ClientDetailError(:final message) => Center(child: Text(message)),
        ClientDetailSaved() => const Center(child: Icon(Icons.check_circle, size: 64)),
        ClientDetailLoaded(:final client, :final isSaving) => _buildForm(client, isNew, isSaving, theme),
      },
    );
  }

  Widget _buildForm(ClientDto client, bool isNew, bool isSaving, ThemeData theme) {
    _initForm(client, isNew);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Toggle PF/PJ
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Pessoa Física'), icon: Icon(Icons.person)),
                ButtonSegment(value: false, label: Text('Pessoa Jurídica'), icon: Icon(Icons.business)),
              ],
              selected: {_isPF},
              onSelectionChanged: (v) => setState(() {
                _isPF = v.first;
                _docCtrl.clear();
              }),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _nomeCtrl,
              decoration: InputDecoration(
                labelText: _isPF ? 'Nome completo' : 'Razão Social',
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (v) => v?.isEmpty ?? true ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _docCtrl,
              decoration: InputDecoration(
                labelText: _isPF ? 'CPF' : 'CNPJ',
                prefixIcon: const Icon(Icons.badge_outlined),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [_isPF ? _cpfFormatter : _cnpjFormatter],
              validator: (v) => v?.isEmpty ?? true ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _telefoneCtrl,
              decoration: const InputDecoration(labelText: 'Telefone', prefixIcon: Icon(Icons.phone_outlined)),
              keyboardType: TextInputType.phone,
              inputFormatters: [_telFormatter],
            ),
            const SizedBox(height: 24),

            Text('Endereço', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),

            Row(children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _cepCtrl,
                  decoration: const InputDecoration(labelText: 'CEP'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: () async {
                  final notifier = ref.read(clientDetailProvider(isNew ? null : widget.clientId).notifier);
                  final addr = await notifier.fetchAddressByCep(_cepCtrl.text);
                  if (addr != null) {
                    setState(() {
                      _logradouroCtrl.text = addr['logradouro'] ?? '';
                      _bairroCtrl.text = addr['bairro'] ?? '';
                      _cidadeCtrl.text = addr['cidade'] ?? '';
                      _ufCtrl.text = addr['uf'] ?? '';
                    });
                  }
                },
                icon: const Icon(Icons.search),
              ),
            ]),
            const SizedBox(height: 12),

            TextFormField(controller: _logradouroCtrl, decoration: const InputDecoration(labelText: 'Logradouro')),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(flex: 1, child: TextFormField(controller: _numeroCtrl, decoration: const InputDecoration(labelText: 'Número'))),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: TextFormField(controller: _bairroCtrl, decoration: const InputDecoration(labelText: 'Bairro'))),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(flex: 3, child: TextFormField(controller: _cidadeCtrl, decoration: const InputDecoration(labelText: 'Cidade'))),
              const SizedBox(width: 12),
              Expanded(flex: 1, child: TextFormField(controller: _ufCtrl, decoration: const InputDecoration(labelText: 'UF'))),
            ]),
            const SizedBox(height: 24),

            FilledButton(
              onPressed: isSaving ? null : _save,
              child: isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Salvar'),
            ),

            if (!isNew) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push('/proposals/new/step1', extra: client),
                icon: const Icon(Icons.article_outlined),
                label: const Text('Criar proposta para este cliente'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final isNew = widget.clientId == 'new';
    final state = ref.read(clientDetailProvider(isNew ? null : widget.clientId));
    if (state is! ClientDetailLoaded) return;

    final updated = state.client.copyWith(
      nome: _nomeCtrl.text.trim(),
      cpfCnpj: _docCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      telefone: _telefoneCtrl.text.trim().isEmpty ? null : _telefoneCtrl.text.trim(),
      endereco: {
        'cep': _cepCtrl.text.trim(),
        'logradouro': _logradouroCtrl.text.trim(),
        'numero': _numeroCtrl.text.trim(),
        'bairro': _bairroCtrl.text.trim(),
        'cidade': _cidadeCtrl.text.trim(),
        'uf': _ufCtrl.text.trim(),
      },
    );

    ref.read(clientDetailProvider(isNew ? null : widget.clientId).notifier).saveClient(updated);
  }
}
