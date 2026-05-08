import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../domain/signature_notifier.dart';
import '../domain/signature_state.dart';

class SignaturePublicScreen extends ConsumerStatefulWidget {
  final String shareToken;

  const SignaturePublicScreen({super.key, required this.shareToken});

  @override
  ConsumerState<SignaturePublicScreen> createState() => _SignaturePublicScreenState();
}

class _SignaturePublicScreenState extends ConsumerState<SignaturePublicScreen> {
  final _nameController = TextEditingController();
  final _signatureKey = GlobalKey<SfSignaturePadState>();
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(signatureProvider(widget.shareToken));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assinatura de Contrato'),
        centerTitle: true,
      ),
      body: switch (state) {
        SignatureLoading() => const Center(child: CircularProgressIndicator()),
        SignatureInvalidLink(:final message) => _SignatureMessageState(
            icon: Icons.link_off_outlined,
            title: 'Link inválido',
            message: message,
            color: theme.colorScheme.error,
          ),
        SignatureAlreadySigned(:final contract, :final message) => _SignatureMessageState(
            icon: Icons.verified_outlined,
            title: 'Contrato já assinado',
            message: '${contract.clienteNome ?? 'Este contrato'} já possui assinatura registrada.\n\n$message',
            color: Colors.green,
          ),
        SignatureError(:final message) => _SignatureMessageState(
            icon: Icons.error_outline,
            title: 'Não foi possível continuar',
            message: message,
            color: theme.colorScheme.error,
          ),
        SignatureSuccess(:final certificateUrl) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified, color: Colors.green, size: 80),
                  const SizedBox(height: 24),
                  Text('Documento Assinado!', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  const Text(
                    'Sua assinatura foi registrada com sucesso e possui validade jurídica.',
                    textAlign: TextAlign.center,
                  ),
                  if (certificateUrl.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    SelectableText(
                      certificateUrl,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        SignatureLoaded(:final contract, :final isSigning) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Contrato de ${contract.clienteNome ?? 'Desconhecido'}',
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            (contract.textoFinal ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Nome completo do signatário',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        value: _acceptedTerms,
                        onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text('Li e concordo com o contrato'),
                      ),
                      const SizedBox(height: 16),
                      Text('Assinatura', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colorScheme.outlineVariant),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SfSignaturePad(
                            key: _signatureKey,
                            backgroundColor: Colors.white,
                            minimumStrokeWidth: 1.5,
                            maximumStrokeWidth: 3,
                            strokeColor: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: isSigning
                              ? null
                              : () => _signatureKey.currentState?.clear(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Limpar assinatura'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ao assinar, seu nome e o momento da assinatura serão registrados neste contrato.',
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: isSigning ? null : () => _handleSign(context),
                        child: isSigning
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Assinar Eletronicamente'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      },
    );
  }

  Future<void> _handleSign(BuildContext context) async {
    final signerName = _nameController.text.trim();
    if (signerName.isEmpty) {
      _showSnackBar('Informe o nome completo do signatário.');
      return;
    }

    if (!_acceptedTerms) {
      _showSnackBar('Você precisa concordar com o contrato antes de assinar.');
      return;
    }

    final image = await _signatureKey.currentState?.toImage(pixelRatio: 3);
    final imageBytes = await image?.toByteData(format: ui.ImageByteFormat.png);
    final bytes = imageBytes?.buffer.asUint8List();

    if (!context.mounted) return;

    if (bytes == null || bytes.isEmpty) {
      _showSnackBar('Faça sua assinatura no campo indicado antes de continuar.');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar assinatura'),
        content: Text('Confirma a assinatura eletrônica deste contrato como $signerName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    await ref.read(signatureProvider(widget.shareToken).notifier).signContract(
          signatarioNome: signerName,
          userAgent: 'Flutter App',
          signatureImageBytes: bytes,
        );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _SignatureMessageState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Color color;

  const _SignatureMessageState({
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: color),
            const SizedBox(height: 16),
            Text(title, style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
