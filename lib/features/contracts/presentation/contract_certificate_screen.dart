import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/services/share_service.dart';
import '../../../data/repositories/signature_repository.dart';
import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

final _certificateDate = DateFormat('dd/MM/yyyy HH:mm');

final _certificateSignaturesProvider = FutureProvider.autoDispose.family((ref, String contractId) {
  return ref.read(signatureRepositoryProvider).getByContractId(contractId);
});

class ContractCertificateScreen extends ConsumerWidget {
  final String contractId;

  const ContractCertificateScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final contractState = ref.watch(contractDetailProvider(contractId));
    final signaturesAsync = ref.watch(_certificateSignaturesProvider(contractId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificado do Contrato'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () async {
              final url = ref.read(shareServiceProvider).contractCertificateLink(contractId);
              await ref.read(shareServiceProvider).copyLinkToClipboard(url);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link de verificação copiado!')),
              );
            },
          ),
        ],
      ),
      body: switch (contractState) {
        ContractDetailLoading() => const Center(child: CircularProgressIndicator()),
        ContractDetailError(:final message) => Center(child: Text(message)),
        ContractDetailLoaded(:final contract) => signaturesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Center(
              child: Text(
                'Não foi possível carregar as assinaturas do certificado.',
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ),
            data: (signatures) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Resumo do documento', style: theme.textTheme.titleMedium),
                        const Divider(),
                        _CertificateInfoRow('Contrato', contract.id),
                        _CertificateInfoRow('Cliente', contract.clienteNome ?? contract.clientId),
                        _CertificateInfoRow('Status', contract.status.toUpperCase()),
                        _CertificateInfoRow('Hash', contract.hashDocumento ?? 'Não gerado'),
                        _CertificateInfoRow('Verificação', ref.read(shareServiceProvider).contractCertificateLink(contract.id)),
                        _CertificateInfoRow('Assinatura', contract.shareToken?.isNotEmpty == true ? ref.read(shareServiceProvider).contractSignLink(contract) : 'Link indisponível'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PDF final', style: theme.textTheme.titleMedium),
                        const Divider(),
                        Text(
                          contract.pdfUrl?.isNotEmpty == true
                              ? contract.pdfUrl!
                              : 'PDF final ainda não disponível.',
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (contract.pdfUrl?.isNotEmpty != true)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'O certificado pode existir antes da consolidação do PDF final.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Signatários', style: theme.textTheme.titleMedium),
                        const Divider(),
                        if (signatures.isEmpty)
                          Text(
                            'Nenhuma assinatura encontrada para este contrato.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        else
                          ...signatures.map(
                            (signature) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.verified, color: Colors.green),
                              title: Text(signature.signatarioNome),
                              subtitle: Text(
                                'Assinado em ${_certificateDate.format(signature.signedAt)}'
                                '${signature.ip?.isNotEmpty == true ? '\nIP: ${signature.ip}' : ''}'
                                '${signature.geolocalizacao?.isNotEmpty == true ? '\nGeo: ${signature.geolocalizacao}' : ''}',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: contract.pdfUrl?.isNotEmpty == true
                      ? () async {
                          await ref.read(shareServiceProvider).copyLinkToClipboard(contract.pdfUrl!);
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Link do PDF copiado!')),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Baixar / copiar link do PDF'),
                ),
              ],
            ),
          ),
      },
    );
  }
}

class _CertificateInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _CertificateInfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }
}
