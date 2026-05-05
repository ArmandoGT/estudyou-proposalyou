// lib/features/contracts/presentation/contract_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

final _date = DateFormat('dd/MM/yyyy HH:mm');

class ContractDetailScreen extends ConsumerWidget {
  final String contractId;
  const ContractDetailScreen({super.key, required this.contractId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(contractDetailProvider(contractId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Contrato'),
        actions: [
          if (state is ContractDetailLoaded)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // ⚠️ DECISÃO PENDENTE: integração com ShareService/PDF
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Compartilhamento em breve.')));
              },
            ),
        ],
      ),
      body: switch (state) {
        ContractDetailLoading() => const Center(child: CircularProgressIndicator()),
        ContractDetailError(:final message) => Center(child: Text(message)),
        ContractDetailLoaded(:final contract) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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

              // Info Adicional
              Text('Informações de Assinatura', style: theme.textTheme.titleMedium),
              Card(
                margin: const EdgeInsets.only(top: 8, bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
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
                            onPressed: () {
                              final url = contract.shareToken?.isNotEmpty == true 
                                  ? 'https://app.estudyou.com.br/s/${contract.shareToken}' 
                                  : 'https://app.estudyou.com.br/s/${contract.id}'; // Fallback / Fake
                              Clipboard.setData(ClipboardData(text: url));
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copiado!')));
                            },
                          ),
                        ],
                      ),
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
              
              // Botões de Ação
              if (contract.status == 'minuta')
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text('Enviar para Assinatura'),
                ),
            ],
          ),
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
