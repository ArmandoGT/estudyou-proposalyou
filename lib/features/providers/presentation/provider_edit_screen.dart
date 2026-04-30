// lib/features/providers/presentation/provider_edit_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/dtos/provider_dto.dart';
import '../domain/provider_notifier.dart';

class ProviderEditScreen extends ConsumerStatefulWidget {
  final String providerId;
  const ProviderEditScreen({super.key, required this.providerId});

  @override
  ConsumerState<ProviderEditScreen> createState() => _ProviderEditScreenState();
}

class _ProviderEditScreenState extends ConsumerState<ProviderEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _razaoCtrl = TextEditingController();
  final _cnpjCtrl = TextEditingController();
  final _enderecoCtrl = TextEditingController();
  final _responsavelCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _assinaturaCtrl = TextEditingController();

  String? _selectedColor;
  bool _initialized = false;

  static const _brandColors = [
    '#1A73E8', '#E65100', '#2E7D32', '#6A1B9A',
    '#C62828', '#00838F', '#4E342E', '#37474F',
    '#F57F17', '#283593',
  ];

  @override
  void dispose() {
    _razaoCtrl.dispose(); _cnpjCtrl.dispose(); _enderecoCtrl.dispose();
    _responsavelCtrl.dispose(); _emailCtrl.dispose(); _assinaturaCtrl.dispose();
    super.dispose();
  }

  void _initForm(ProviderDto p) {
    if (_initialized) return;
    _initialized = true;
    _razaoCtrl.text = p.razaoSocial;
    _cnpjCtrl.text = p.cnpj;
    _enderecoCtrl.text = p.endereco ?? '';
    _responsavelCtrl.text = p.responsavel ?? '';
    _emailCtrl.text = p.email ?? '';
    _assinaturaCtrl.text = p.assinaturaPadrao ?? '';
    _selectedColor = p.corMarca ?? '#1A73E8';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final asyncProvider = ref.watch(providerEditProvider(widget.providerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Prestador')),
      body: asyncProvider.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (provider) {
          _initForm(provider);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                // Logo placeholder
                Center(child: GestureDetector(
                  onTap: () {
                    // ⚠️ DECISÃO PENDENTE: image_picker integration
                  },
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    backgroundImage: provider.logoUrl != null ? NetworkImage(provider.logoUrl!) : null,
                    child: provider.logoUrl == null
                        ? Icon(Icons.camera_alt, size: 32, color: theme.colorScheme.onPrimaryContainer)
                        : null,
                  ),
                )),
                const SizedBox(height: 24),

                TextFormField(controller: _razaoCtrl, decoration: const InputDecoration(labelText: 'Razão Social')),
                const SizedBox(height: 12),
                TextFormField(controller: _cnpjCtrl, decoration: const InputDecoration(labelText: 'CNPJ'), readOnly: true),
                const SizedBox(height: 12),
                TextFormField(controller: _enderecoCtrl, decoration: const InputDecoration(labelText: 'Endereço')),
                const SizedBox(height: 12),
                TextFormField(controller: _responsavelCtrl, decoration: const InputDecoration(labelText: 'Responsável')),
                const SizedBox(height: 12),
                TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'E-mail')),
                const SizedBox(height: 12),
                TextFormField(controller: _assinaturaCtrl, decoration: const InputDecoration(labelText: 'Assinatura padrão')),
                const SizedBox(height: 24),

                // ColorPicker simples
                Text('Cor da marca', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: _brandColors.map((hex) {
                  final color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = hex),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: color, shape: BoxShape.circle,
                        border: _selectedColor == hex
                            ? Border.all(color: theme.colorScheme.onSurface, width: 3)
                            : null,
                      ),
                      child: _selectedColor == hex ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
                    ),
                  );
                }).toList()),
                const SizedBox(height: 24),

                // Preview do rodapé
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(int.parse((_selectedColor ?? '#1A73E8').replaceFirst('#', '0xFF')))),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(children: [
                    Icon(Icons.business, color: Color(int.parse((_selectedColor ?? '#1A73E8').replaceFirst('#', '0xFF')))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_razaoCtrl.text, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                        Text('CNPJ: ${_cnpjCtrl.text}', style: theme.textTheme.bodySmall),
                      ],
                    )),
                  ]),
                ),
                const SizedBox(height: 24),

                FilledButton(onPressed: _save, child: const Text('Salvar')),
              ]),
            ),
          );
        },
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final asyncState = ref.read(providerEditProvider(widget.providerId));
    final provider = asyncState.value;
    if (provider == null) return;

    ref.read(providerEditProvider(widget.providerId).notifier).save(
      provider.copyWith(
        razaoSocial: _razaoCtrl.text.trim(),
        endereco: _enderecoCtrl.text.trim(),
        responsavel: _responsavelCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        assinaturaPadrao: _assinaturaCtrl.text.trim(),
        corMarca: _selectedColor,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Salvo com sucesso!')));
    context.pop();
  }
}
