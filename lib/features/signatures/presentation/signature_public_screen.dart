// lib/features/signatures/presentation/signature_public_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/signature_notifier.dart';
import '../domain/signature_state.dart';

class SignaturePublicScreen extends ConsumerWidget {
  final String contractId;
  const SignaturePublicScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(signatureProvider(contractId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assinatura de Contrato'),
        centerTitle: true,
      ),
      body: switch (state) {
        SignatureLoading() => const Center(child: CircularProgressIndicator()),
        SignatureError(:final message) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(message, textAlign: TextAlign.center, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
            ),
          ),
        SignatureSuccess() => Center( // Ignorando certificateUrl não usado no UI mockup
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified, color: Colors.green, size: 80),
                  const SizedBox(height: 24),
                  Text('Documento Assinado!', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  const Text('Sua assinatura foi registrada com sucesso e possui validade jurídica.'),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Baixar Certificado de Assinatura'),
                  ),
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
                      Text('Contrato de ${contract.clienteNome ?? 'Desconhecido'}', style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(side: BorderSide(color: theme.colorScheme.outlineVariant)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            (contract.textoFinal ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '), // Mock render
                            style: theme.textTheme.bodyMedium,
                          ),
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
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5)),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Ao clicar em assinar, você concorda com os termos acima. Seu IP será registrado.',
                          style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: isSigning ? null : () {
                          ref.read(signatureProvider(contractId).notifier).signContract(
                            ip: '192.168.0.1', // Mock
                            userAgent: 'Mobile App',
                            signatureImageBytes: [0], // Mock
                          );
                        },
                        child: isSigning
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
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
}
