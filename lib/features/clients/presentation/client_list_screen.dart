// lib/features/clients/presentation/client_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/client_notifier.dart';
import '../domain/client_state.dart';

class ClientListScreen extends ConsumerWidget {
  const ClientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(clientListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: Column(
        children: [
          // Barra de busca
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              hintText: 'Buscar por nome ou CPF/CNPJ...',
              leading: const Icon(Icons.search),
              onChanged: (q) => ref.read(clientListProvider.notifier).search(q),
            ),
          ),
          // Filtros PF/PJ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(children: [
              _FilterChip(
                label: 'Todos',
                selected: state is ClientListLoaded && state.activeFilter == null,
                onSelected: () => ref.read(clientListProvider.notifier).filterByType(null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'PF',
                selected: state is ClientListLoaded && state.activeFilter == 'pf',
                onSelected: () => ref.read(clientListProvider.notifier).filterByType('pf'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'PJ',
                selected: state is ClientListLoaded && state.activeFilter == 'pj',
                onSelected: () => ref.read(clientListProvider.notifier).filterByType('pj'),
              ),
            ]),
          ),
          const Divider(height: 1),
          // Lista
          Expanded(child: switch (state) {
            ClientListLoading() => const Center(child: CircularProgressIndicator()),
            ClientListError(:final message) => Center(child: Text(message)),
            ClientListLoaded(:final clients) when clients.isEmpty =>
              Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('Nenhum cliente encontrado', style: theme.textTheme.bodyLarge),
                ],
              )),
            ClientListLoaded(:final clients) => RefreshIndicator(
              onRefresh: () => ref.read(clientListProvider.notifier).refresh(),
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (ctx, i) {
                  final c = clients[i];
                  return Dismissible(
                    key: Key(c.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: theme.colorScheme.error,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(Icons.archive, color: Colors.white),
                    ),
                    confirmDismiss: (_) async {
                      return await showDialog<bool>(
                        context: ctx,
                        builder: (c) => AlertDialog(
                          title: const Text('Arquivar cliente?'),
                          content: const Text('O cliente será arquivado e não aparecerá na lista.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
                            FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Arquivar')),
                          ],
                        ),
                      );
                    },
                    onDismissed: (_) => ref.read(clientListProvider.notifier).archive(c.id),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: c.isPessoaFisica
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.tertiaryContainer,
                        child: Icon(
                          c.isPessoaFisica ? Icons.person : Icons.business,
                          color: c.isPessoaFisica
                              ? theme.colorScheme.onPrimaryContainer
                              : theme.colorScheme.onTertiaryContainer,
                        ),
                      ),
                      title: Text(c.nome),
                      subtitle: Text(c.cpfCnpj),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/clients/${c.id}'),
                    ),
                  );
                },
              ),
            ),
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/clients/new'),
        child: const Icon(Icons.person_add),
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
