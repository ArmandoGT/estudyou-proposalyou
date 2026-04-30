// lib/features/proposals/presentation/proposal_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

final _brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _dateFormat = DateFormat('dd/MM/yyyy');

class ProposalListScreen extends ConsumerWidget {
  const ProposalListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Propostas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              hintText: 'Buscar proposta...',
              leading: const Icon(Icons.search),
              onChanged: (q) => ref.read(proposalListProvider.notifier).search(q),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(children: [
              _FilterChip(
                label: 'Todas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == null,
                onSelected: () => ref.read(proposalListProvider.notifier).filterByStatus(null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Rascunho',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'rascunho',
                onSelected: () => ref.read(proposalListProvider.notifier).filterByStatus('rascunho'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Enviadas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'enviada',
                onSelected: () => ref.read(proposalListProvider.notifier).filterByStatus('enviada'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Aprovadas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'aprovada',
                onSelected: () => ref.read(proposalListProvider.notifier).filterByStatus('aprovada'),
              ),
            ]),
          ),
          const Divider(height: 1),
          Expanded(child: switch (state) {
            ProposalListLoading() => const Center(child: CircularProgressIndicator()),
            ProposalListError(:final message) => Center(child: Text(message)),
            ProposalListLoaded(:final proposals) when proposals.isEmpty =>
              Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.article_outlined, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('Nenhuma proposta encontrada', style: theme.textTheme.bodyLarge),
                ],
              )),
            ProposalListLoaded(:final proposals) => RefreshIndicator(
              onRefresh: () => ref.read(proposalListProvider.notifier).refresh(),
              child: ListView.builder(
                itemCount: proposals.length,
                itemBuilder: (ctx, i) {
                  final p = proposals[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(Icons.article, color: theme.colorScheme.onPrimaryContainer),
                    ),
                    title: Text('Proposta de ${p.clienteNome ?? 'Desconhecido'}'),
                    subtitle: Text('ID: ${p.id.substring(0,8)} • ${_dateFormat.format(p.updatedAt)}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(_brlFormat.format(p.total), style: theme.textTheme.titleSmall),
                        const SizedBox(height: 4),
                        _StatusBadge(status: p.status),
                      ],
                    ),
                    onTap: () => context.push('/proposals/${p.id}'),
                  );
                },
              ),
            ),
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(proposalWizardProvider.notifier).startWizard();
          context.push('/proposals/new/step1');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(label: Text(label), selected: selected, onSelected: (_) => onSelected());
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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(status.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
