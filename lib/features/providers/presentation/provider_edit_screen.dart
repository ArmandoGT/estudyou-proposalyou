// lib/features/providers/presentation/provider_edit_screen.dart

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/auth_service.dart';
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
  final _empresaCtrl = TextEditingController();
  final _razaoCtrl = TextEditingController();
  final _cnpjCtrl = TextEditingController();
  final _enderecoCtrl = TextEditingController();
  final _responsavelCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _assinaturaCtrl = TextEditingController();

  final _imagePicker = ImagePicker();

  String? _selectedColor;
  bool _initialized = false;
  bool _isUploadingLogo = false;
  Uint8List? _localLogoBytes;

  static const _brandColors = [
    '#1A73E8', '#E65100', '#2E7D32', '#6A1B9A',
    '#C62828', '#00838F', '#4E342E', '#37474F',
    '#F57F17', '#283593',
  ];

  @override
  void dispose() {
    _empresaCtrl.dispose(); _razaoCtrl.dispose(); _cnpjCtrl.dispose(); _enderecoCtrl.dispose();
    _responsavelCtrl.dispose(); _emailCtrl.dispose(); _assinaturaCtrl.dispose();
    super.dispose();
  }

  void _initForm(ProviderDto p) {
    if (_initialized) return;
    _initialized = true;
    _empresaCtrl.text = p.empresa;
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
    final isNew = widget.providerId == 'new';
    final asyncProvider = ref.watch(providerEditProvider(widget.providerId));

    return Scaffold(
      appBar: AppBar(title: Text(isNew ? 'Nova empresa' : 'Editar empresa')),
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
                Center(
                  child: GestureDetector(
                    onTap: isNew || _isUploadingLogo ? null : () => _pickAndUploadLogo(provider),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: theme.colorScheme.primaryContainer,
                          backgroundImage: _buildLogoImage(provider),
                          child: _buildLogoImage(provider) == null
                              ? Icon(Icons.camera_alt, size: 32, color: theme.colorScheme.onPrimaryContainer)
                              : null,
                        ),
                        if (_isUploadingLogo)
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.35),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _empresaCtrl.text.trim().isEmpty ? 'NOVA EMPRESA' : _empresaCtrl.text.trim().toUpperCase(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge,
                ),
                if (isNew) ...[
                  const SizedBox(height: 8),
                  Text(
                    'A logo poderá ser enviada depois que a empresa for criada.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 24),

                TextFormField(
                  controller: _empresaCtrl,
                  decoration: const InputDecoration(labelText: 'Slug da empresa'),
                  readOnly: !isNew,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o slug da empresa';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _razaoCtrl,
                  decoration: const InputDecoration(labelText: 'Razão Social'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe a razão social';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cnpjCtrl,
                  decoration: const InputDecoration(labelText: 'CNPJ'),
                  readOnly: !isNew,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o CNPJ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(controller: _enderecoCtrl, decoration: const InputDecoration(labelText: 'Endereço')),
                const SizedBox(height: 12),
                TextFormField(controller: _responsavelCtrl, decoration: const InputDecoration(labelText: 'Responsável')),
                const SizedBox(height: 12),
                TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'E-mail')),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _assinaturaCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Assinatura padrão'),
                  onChanged: (_) => setState(() {}),
                ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
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
                      if (_assinaturaCtrl.text.trim().isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Divider(),
                        Text(
                          _assinaturaCtrl.text.trim(),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                FilledButton(onPressed: _save, child: Text(isNew ? 'Criar empresa' : 'Salvar')),
              ]),
            ),
          );
        },
      ),
    );
  }

  ImageProvider<Object>? _buildLogoImage(ProviderDto provider) {
    if (_localLogoBytes != null) {
      return MemoryImage(_localLogoBytes!);
    }
    if (provider.logoUrl != null && provider.logoUrl!.trim().isNotEmpty) {
      return NetworkImage(provider.logoUrl!);
    }
    return null;
  }

  Future<void> _pickAndUploadLogo(ProviderDto provider) async {
    final file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
    );
    if (file == null || !mounted) return;

    final bytes = await file.readAsBytes();
    setState(() {
      _isUploadingLogo = true;
      _localLogoBytes = bytes;
    });

    try {
      await ref.read(providerEditProvider(widget.providerId).notifier).uploadLogo(
        providerId: provider.id,
        imageBytes: bytes,
        fileName: file.name,
        contentType: file.mimeType ?? 'image/jpeg',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logo atualizada com sucesso!')),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _localLogoBytes = null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toUserMessage())),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _localLogoBytes = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível enviar a logo.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploadingLogo = false);
      }
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final isNew = widget.providerId == 'new';
    final asyncState = ref.read(providerEditProvider(widget.providerId));
    final provider = asyncState.value;
    if (provider == null) return;

    final updated = provider.copyWith(
      empresa: _empresaCtrl.text.trim().toLowerCase(),
      razaoSocial: _razaoCtrl.text.trim(),
      cnpj: _cnpjCtrl.text.trim(),
      endereco: _enderecoCtrl.text.trim().isEmpty ? null : _enderecoCtrl.text.trim(),
      responsavel: _responsavelCtrl.text.trim().isEmpty ? null : _responsavelCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      assinaturaPadrao: _assinaturaCtrl.text.trim().isEmpty ? null : _assinaturaCtrl.text.trim(),
      corMarca: _selectedColor,
    );

    try {
      final saved = await ref.read(providerEditProvider(widget.providerId).notifier).save(
            updated,
            isNew: isNew,
          );
      ref.invalidate(providerListProvider);
      if (isNew) {
        await ref.read(authServiceProvider.notifier).switchActiveProvider(saved.empresa);
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isNew ? 'Empresa criada com sucesso!' : 'Empresa salva com sucesso!')),
      );
      context.pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível salvar a empresa: $error')),
      );
    }
  }
}
