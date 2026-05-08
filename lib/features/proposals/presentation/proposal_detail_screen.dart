// lib/features/proposals/presentation/proposal_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/services/share_service.dart';
import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

final _brl = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _date = DateFormat('dd/MM/yyyy HH:mm');

class ProposalDetailScreen extends ConsumerWidget {
  final String proposalId;
  const ProposalDetailScreen({super.key, required this.proposalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalDetailProvider(proposalId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Proposta'),
        actions: [
          if (state is ProposalDetailLoaded)
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
        ProposalDetailLoading() => const Center(child: CircularProgressIndicator()),
        ProposalDetailError(:final message) => Center(child: Text(message)),
        ProposalDetailLoaded(:final proposal) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text('Proposta de ${proposal.clienteNome ?? 'Desconhecido'}', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Row(children: [
                _StatusBadge(status: proposal.status ?? 'rascunho'),
                const Spacer(),
                Text('Criada em ${_date.format(proposal.createdAt)}', style: theme.textTheme.bodySmall),
              ]),
              const SizedBox(height: 24),

              // Cliente
              Text('Cliente', style: theme.textTheme.titleMedium),
              Card(
                margin: const EdgeInsets.only(top: 8, bottom: 24),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(proposal.clienteNome ?? 'Cliente não informado'),
                  subtitle: Text('ID: ${proposal.clientId}'), // Na prática, puxar os dados completos do cliente
                ),
              ),

              // Itens
              Text('Itens (${proposal.itensJson.length})', style: theme.textTheme.titleMedium),
              Card(
                margin: const EdgeInsets.only(top: 8, bottom: 24),
                child: Column(
                  children: [
                    ...proposal.itensJson.map((i) {
                      final qtd = (i['quantidade'] as num).toDouble();
                      final preco = (i['preco_unitario'] as num).toDouble();
                      return ListTile(
                        title: Text(i['nome'] as String),
                        subtitle: Text('${qtd}x ${_brl.format(preco)}'),
                        trailing: Text(_brl.format(qtd * preco), style: const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    }),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Geral', style: theme.textTheme.titleMedium),
                          Text(_brl.format(proposal.total), style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Info Adicional
              Text('Informações Adicionais', style: theme.textTheme.titleMedium),
              Card(
                margin: const EdgeInsets.only(top: 8, bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Validade:'),
                          Text(proposal.validade != null ? _date.format(proposal.validade!) : 'Sem prazo de validade', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Link Público:'),
                          TextButton.icon(
                            icon: const Icon(Icons.copy, size: 16),
                            label: const Text('Copiar Link'),
                            onPressed: proposal.shareToken?.isNotEmpty == true
                                ? () async {
                                    final url = ref.read(shareServiceProvider).proposalLink(proposal);
                                    await ref.read(shareServiceProvider).copyLinkToClipboard(url);
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copiado!')));
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Botões de Ação dependendo do status
              if (proposal.status == 'rascunho')
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text('Marcar como Enviada'),
                ),
              if (proposal.status == 'enviada')
                Row(children: [
                  Expanded(child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(foregroundColor: theme.colorScheme.error),
                    child: const Text('Recusar'),
                  )),
                  const SizedBox(width: 16),
                  Expanded(child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Aprovar'),
                  )),
                ]),
              if (proposal.status == 'aprovada')
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.handshake),
                  label: const Text('Gerar Contrato'),
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
    switch (status) {
      case 'rascunho': color = theme.colorScheme.outline; break;
      case 'enviada': color = theme.colorScheme.primary; break;
      case 'aprovada': color = Colors.green; break;
      case 'recusada': color = theme.colorScheme.error; break;
      default: color = theme.colorScheme.outline;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(status.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
