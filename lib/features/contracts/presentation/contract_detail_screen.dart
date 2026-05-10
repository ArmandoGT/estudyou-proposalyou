// lib/features/contracts/presentation/contract_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/services/active_provider_context.dart';
import '../../../core/services/share_service.dart';
import '../../../data/repositories/signature_repository.dart';
import '../../../shared/widgets/tenant_brand_card.dart';
import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

final _date = DateFormat('dd/MM/yyyy HH:mm');

final _contractSignaturesProvider = FutureProvider.autoDispose.family((ref, String contractId) {
  return ref.read(signatureRepositoryProvider).getByContractId(contractId);
});

class ContractDetailScreen extends ConsumerWidget {
  final String contractId;
  const ContractDetailScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(contractDetailProvider(contractId));
    final activeProviderAsync = ref.watch(activeProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Contrato'),
        actions: [
          if (state is ContractDetailLoaded)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                await ref.read(shareServiceProvider).shareContract(state.contract);
              },
            ),
        ],
      ),
      body: switch (state) {
        ContractDetailLoading() => const Center(child: CircularProgressIndicator()),
        ContractDetailError(:final message) => Center(child: Text(message)),
        ContractDetailLoaded(:final contract) => Builder(
          builder: (context) {
            final signaturesAsync = ref.watch(_contractSignaturesProvider(contract.id));
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              activeProviderAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (provider) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TenantBrandCard(
                    provider: provider,
                    title: 'Marca da empresa',
                    subtitle: contract.providerId,
                  ),
                ),
              ),
              // Header
              Text('Contrato de ${contract.clienteNome ?? 'Desconhecido'}', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Row(children: [
                _StatusBadge(status: contract.status),
                const Spacer(),
                Text('Atualizado em ${_date.format(contract.updatedAt)}', style: theme.textTheme.bodySmall),
              ]),
              const SizedBox(height: 24),

              // Vínculos
              if (contract.proposalId != null) ...[
                Text('Vínculos', style: theme.textTheme.titleMedium),
                Card(
                  margin: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ListTile(
                    leading: const Icon(Icons.article),
                    title: const Text('Gerado a partir de proposta'),
                    subtitle: Text('ID da Proposta: ${contract.proposalId}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // context.push('/proposals/${contract.proposalId}');
                    },
                  ),
                ),
              ],

              Text('Assinaturas', style: theme.textTheme.titleMedium),
              Card(
                margin: const EdgeInsets.only(top: 8, bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Progresso:'),
                          Text(
                            contract.progressoAssinaturas,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      signaturesAsync.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (_, _) => Text(
                          'Não foi possível carregar os signatários.',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                        ),
                        data: (signatures) {
                          if (signatures.isEmpty) {
                            return Text(
                              'Nenhuma assinatura registrada até o momento.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            );
                          }

                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: signatures
                                .map(
                                  (signature) => Chip(
                                    avatar: const Icon(Icons.verified, size: 18, color: Colors.green),
                                    label: Text(signature.signatarioNome),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Hash do Documento:'),
                          Text(contract.hashDocumento?.isNotEmpty == true ? '${contract.hashDocumento!.substring(0, 8)}...' : 'Ainda não assinado', 
                               style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Link para Assinatura:'),
                          TextButton.icon(
                            icon: const Icon(Icons.copy, size: 16),
                            label: const Text('Copiar Link'),
                            onPressed: contract.shareToken?.isNotEmpty == true
                                ? () async {
                                    final url = ref.read(shareServiceProvider).contractSignLink(contract);
                                    await ref.read(shareServiceProvider).copyLinkToClipboard(url);
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copiado!')));
                                  }
                                : null,
                          ),
                        ],
                      ),
                      if (contract.pdfUrl?.isNotEmpty == true) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('PDF Final:'),
                            TextButton.icon(
                              icon: const Icon(Icons.picture_as_pdf_outlined, size: 16),
                              label: const Text('Copiar Link'),
                              onPressed: () async {
                                await ref.read(shareServiceProvider).copyLinkToClipboard(contract.pdfUrl!);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link do PDF copiado!')));
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Visualização do Conteúdo
              Text('Cláusulas', style: theme.textTheme.titleMedium),
              Card(
                margin: const EdgeInsets.only(top: 8, bottom: 24),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    child: Text(
                      // Em um app real usaríamos flutter_html
                      (contract.textoFinal ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              
              if (contract.status == 'minuta')
                FilledButton.icon(
                  onPressed: () async {
                    await ref.read(contractDetailProvider(contractId).notifier).sendForSignature();
                    ref.invalidate(_contractSignaturesProvider(contract.id));
                    ref.invalidate(contractDetailProvider(contractId));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contrato enviado para assinatura.')),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Enviar para Assinatura'),
                ),
              if (contract.status == 'assinado') ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => context.push('/contracts/${contract.id}/certificate'),
                  icon: const Icon(Icons.verified_outlined),
                  label: const Text('Ver certificado'),
                ),
                if (contract.pdfUrl?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await ref.read(shareServiceProvider).copyLinkToClipboard(contract.pdfUrl!);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link do PDF copiado!')));
                    },
                    icon: const Icon(Icons.picture_as_pdf_outlined),
                    label: const Text('Copiar link do PDF final'),
                  ),
                ],
              ],
            ],
          ),
        );
          },
        ),
      },
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color color;
    String label = status.toUpperCase();
    switch (status) {
      case 'minuta': color = theme.colorScheme.outline; break;
      case 'aguardando_assinatura': color = theme.colorScheme.error; label = 'AGUARDANDO'; break;
      case 'assinado': color = Colors.green; break;
      case 'cancelado': color = theme.colorScheme.error; break;
      default: color = theme.colorScheme.outline;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
