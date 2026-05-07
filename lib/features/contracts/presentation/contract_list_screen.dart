// lib/features/contracts/presentation/contract_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../domain/contract_notifier.dart';
import '../domain/contract_state.dart';

final _dateFormat = DateFormat('dd/MM/yyyy');

class ContractListScreen extends ConsumerWidget {
  const ContractListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(contractListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contratos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              hintText: 'Buscar contrato...',
              leading: const Icon(Icons.search),
              onChanged: (q) => ref.read(contractListProvider.notifier).search(q),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(children: [
              _FilterChip(
                label: 'Todos',
                selected: state is ContractListLoaded && state.activeStatusFilter == null,
                onSelected: () => ref.read(contractListProvider.notifier).filterByStatus(null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Minuta',
                selected: state is ContractListLoaded && state.activeStatusFilter == 'minuta',
                onSelected: () => ref.read(contractListProvider.notifier).filterByStatus('minuta'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Aguardando',
                selected: state is ContractListLoaded && state.activeStatusFilter == 'aguardando_assinatura',
                onSelected: () => ref.read(contractListProvider.notifier).filterByStatus('aguardando_assinatura'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Assinado',
                selected: state is ContractListLoaded && state.activeStatusFilter == 'assinado',
                onSelected: () => ref.read(contractListProvider.notifier).filterByStatus('assinado'),
              ),
            ]),
          ),
          const Divider(height: 1),
          Expanded(child: switch (state) {
            ContractListLoading() => const Center(child: CircularProgressIndicator()),
            ContractListError(:final message) => Center(child: Text(message)),
            ContractListLoaded(:final contracts) when contracts.isEmpty =>
              Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.handshake_outlined, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('Nenhum contrato encontrado', style: theme.textTheme.bodyLarge),
                ],
              )),
            ContractListLoaded(:final contracts) => RefreshIndicator(
              onRefresh: () => ref.read(contractListProvider.notifier).refresh(),
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                itemCount: contracts.length,
                itemBuilder: (ctx, i) {
                  final c = contracts[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      child: Icon(Icons.handshake, color: theme.colorScheme.onSecondaryContainer),
                    ),
                    title: Text('Contrato de ${c.clienteNome ?? 'Desconhecido'}'),
                    subtitle: Text('Atualizado em ${_dateFormat.format(c.updatedAt)}\nProgresso: ${c.progressoAssinaturas}'),
                    isThreeLine: true,
                    trailing: _StatusBadge(status: c.status),
                    onTap: () => context.push('/contracts/${c.id}'),
                  );
                },
              ),
            ),
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(contractWizardProvider.notifier).startWizard();
          context.push('/contracts/new/step1');
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
    String label = status.toUpperCase();
    switch (status) {
      case 'minuta': color = theme.colorScheme.outline; break;
      case 'aguardando_assinatura': 
        color = theme.colorScheme.error; 
        label = 'AGUARDANDO';
        break;
      case 'assinado': color = Colors.green; break;
      case 'cancelado': color = theme.colorScheme.error; break;
      default: color = theme.colorScheme.outline;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color)),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
