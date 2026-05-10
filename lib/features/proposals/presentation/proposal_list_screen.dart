// lib/features/proposals/presentation/proposal_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/services/active_provider_context.dart';
import '../../../data/dtos/proposal_dto.dart';
import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

final _brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _dateFormat = DateFormat('dd/MM/yyyy');

class ProposalListScreen extends ConsumerWidget {
  final bool archivedOnly;

  const ProposalListScreen({super.key, this.archivedOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = archivedOnly
        ? ref.watch(archivedProposalListProvider)
        : ref.watch(proposalListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(archivedOnly ? 'Propostas arquivadas' : 'Propostas'),
        actions: [
          if (!archivedOnly)
            IconButton(
              tooltip: 'Arquivadas',
              onPressed: () => context.push('/proposals/archived'),
              icon: const Icon(Icons.archive_outlined),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              hintText: 'Buscar proposta...',
              leading: const Icon(Icons.search),
              onChanged: (q) => archivedOnly
                  ? ref.read(archivedProposalListProvider.notifier).search(q)
                  : ref.read(proposalListProvider.notifier).search(q),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(children: [
              _FilterChip(
                label: 'Todas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == null,
                onSelected: () => archivedOnly
                    ? ref.read(archivedProposalListProvider.notifier).filterByStatus(null)
                    : ref.read(proposalListProvider.notifier).filterByStatus(null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Rascunho',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'rascunho',
                onSelected: () => archivedOnly
                    ? ref.read(archivedProposalListProvider.notifier).filterByStatus('rascunho')
                    : ref.read(proposalListProvider.notifier).filterByStatus('rascunho'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Enviadas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'enviada',
                onSelected: () => archivedOnly
                    ? ref.read(archivedProposalListProvider.notifier).filterByStatus('enviada')
                    : ref.read(proposalListProvider.notifier).filterByStatus('enviada'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Aprovadas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'aprovada',
                onSelected: () => archivedOnly
                    ? ref.read(archivedProposalListProvider.notifier).filterByStatus('aprovada')
                    : ref.read(proposalListProvider.notifier).filterByStatus('aprovada'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Recusadas',
                selected: state is ProposalListLoaded && state.activeStatusFilter == 'recusada',
                onSelected: () => archivedOnly
                    ? ref.read(archivedProposalListProvider.notifier).filterByStatus('recusada')
                    : ref.read(proposalListProvider.notifier).filterByStatus('recusada'),
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
                  Text(archivedOnly ? 'Nenhuma proposta arquivada' : 'Nenhuma proposta encontrada', style: theme.textTheme.bodyLarge),
                ],
              )),
            ProposalListLoaded(:final proposals) => RefreshIndicator(
              onRefresh: () => archivedOnly
                  ? ref.read(archivedProposalListProvider.notifier).refresh()
                  : ref.read(proposalListProvider.notifier).refresh(),
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
                    subtitle: Text('ID: ${p.id?.substring(0,8) ?? 'Novo'} • ${_dateFormat.format(p.updatedAt)}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) => _handleProposalAction(context, ref, p, value),
                      itemBuilder: (context) => [
                        if (!archivedOnly)
                          const PopupMenuItem(value: 'archive', child: Text('Arquivar')),
                        if (archivedOnly)
                          const PopupMenuItem(value: 'restore', child: Text('Restaurar')),
                        const PopupMenuItem(value: 'delete', child: Text('Excluir permanentemente')),
                      ],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(_brlFormat.format(p.total), style: theme.textTheme.titleSmall),
                          const SizedBox(height: 4),
                          _StatusBadge(status: p.status ?? 'rascunho'),
                        ],
                      ),
                    ),
                    onTap: archivedOnly ? null : () => context.push('/proposals/${p.id}'),
                  );
                },
              ),
            ),
          }),
        ],
      ),
      floatingActionButton: archivedOnly
          ? null
          : FutureBuilder<bool>(
              future: ref.read(isAllProvidersScopeProvider.future),
              builder: (context, snapshot) {
                final isGlobalScope = snapshot.data ?? false;
                return FloatingActionButton(
                  onPressed: () {
                    if (isGlobalScope) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selecione uma empresa específica para criar este item.')),
                      );
                      return;
                    }
                    ref.read(proposalWizardProvider.notifier).startWizard();
                    context.push('/proposals/new/step1');
                  },
                  child: const Icon(Icons.add),
                );
              },
            ),
    );
  }

  Future<void> _handleProposalAction(BuildContext context, WidgetRef ref, ProposalDto proposal, String action) async {
    if (proposal.id == null) return;

    if (action == 'archive') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Arquivar proposta?'),
          content: const Text('A proposta sairá da lista principal e ficará disponível em Propostas arquivadas.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Arquivar')),
          ],
        ),
      );
      if (confirm == true) {
        await ref.read(proposalListProvider.notifier).archive(proposal.id!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proposta arquivada com sucesso.')),
          );
        }
      }
      return;
    }

    if (action == 'restore') {
      await ref.read(archivedProposalListProvider.notifier).restore(proposal.id!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proposta restaurada com sucesso.')),
        );
      }
      return;
    }

    if (action == 'delete') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Excluir proposta permanentemente?'),
          content: const Text('Essa ação não pode ser desfeita.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Excluir')),
          ],
        ),
      );
      if (confirm == true) {
        if (archivedOnly) {
          await ref.read(archivedProposalListProvider.notifier).deletePermanently(proposal.id!);
        } else {
          await ref.read(proposalListProvider.notifier).deletePermanently(proposal.id!);
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proposta excluída permanentemente.')),
          );
        }
      }
    }
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
