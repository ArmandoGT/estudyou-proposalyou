import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/error/app_exception.dart';
import '../../../data/repositories/proposal_repository.dart';

final _brl = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _date = DateFormat('dd/MM/yyyy');

final proposalPublicProvider = FutureProvider.autoDispose.family((ref, String shareToken) {
  return ref.read(proposalRepositoryProvider).getByShareToken(shareToken);
});

class ProposalPublicScreen extends ConsumerWidget {
  final String shareToken;

  const ProposalPublicScreen({super.key, required this.shareToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final proposalAsync = ref.watch(proposalPublicProvider(shareToken));

    return Scaffold(
      appBar: AppBar(title: const Text('Proposta Comercial')),
      body: proposalAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          final message = error is AppException
              ? error.toUserMessage()
              : 'Não foi possível carregar a proposta.';
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          );
        },
        data: (proposal) {
          if (proposal == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Link de proposta inválido ou expirado.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Proposta para ${proposal.clienteNome ?? 'Cliente'}',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _PublicInfoChip(label: 'Status', value: (proposal.status ?? 'rascunho').toUpperCase()),
                    if (proposal.validade != null)
                      _PublicInfoChip(label: 'Validade', value: _date.format(proposal.validade!)),
                    _PublicInfoChip(label: 'Versão', value: 'v${proposal.versao}'),
                  ],
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Itens', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        if (proposal.itensJson.isEmpty)
                          Text(
                            'Nenhum item informado.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        else
                          ...proposal.itensJson.map((item) {
                            final qtd = (item['quantidade'] as num?)?.toDouble() ?? 1;
                            final preco = ((item['preco_unitario'] ?? item['preco']) as num?)?.toDouble() ?? 0;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item['nome'] as String? ?? 'Item', style: theme.textTheme.titleSmall),
                                        const SizedBox(height: 2),
                                        Text('${qtd.toStringAsFixed(qtd.truncateToDouble() == qtd ? 0 : 2)} x ${_brl.format(preco)}', style: theme.textTheme.bodySmall),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _brl.format(qtd * preco),
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: theme.textTheme.titleMedium),
                            Text(
                              _brl.format(proposal.total),
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (proposal.observacoes?.isNotEmpty == true) ...[
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Observações', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(proposal.observacoes!, style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PublicInfoChip extends StatelessWidget {
  final String label;
  final String value;

  const _PublicInfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodySmall,
          children: [
            TextSpan(
              text: '$label: ',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            TextSpan(
              text: value,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
