// lib/features/clients/presentation/client_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/active_provider_context.dart';
import '../../../data/dtos/client_dto.dart';
import '../../../data/repositories/client_repository.dart';
import '../domain/client_notifier.dart';
import '../domain/client_state.dart';

class ClientListScreen extends ConsumerStatefulWidget {
  final bool archivedOnly;

  const ClientListScreen({super.key, this.archivedOnly = false});

  @override
  ConsumerState<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends ConsumerState<ClientListScreen> {
  Future<void> _handleClientAction(BuildContext context, ClientDto client, String action) async {
    if (client.id == null) return;

    if (action == 'edit') {
      context.push('/clients/${client.id}');
      return;
    }

    if (action == 'archive') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Arquivar cliente?'),
          content: const Text('O cliente sairá da lista principal e ficará disponível em Clientes arquivados.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Arquivar')),
          ],
        ),
      );
      if (confirm == true) {
        await ref.read(clientListProvider.notifier).archive(client.id!);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente arquivado com sucesso.')),
        );
      }
      return;
    }

    if (action == 'restore') {
      await ref.read(archivedClientListProvider.notifier).restore(client.id!);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente restaurado com sucesso.')),
      );
      return;
    }

    if (action == 'delete') {
      await _showDeleteClientDialog(context, client.id!);
    }
  }

  Future<void> _showDeleteClientDialog(BuildContext context, String clientId) async {
    final preview = await ref.read(clientDeletionPreviewProvider(clientId).future);
    if (!context.mounted) return;

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir cliente permanentemente?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Este cliente possui ${preview.contractsCount} contrato(s) e ${preview.proposalsCount} proposta(s) vinculada(s).'),
            const SizedBox(height: 12),
            const Text('Escolha o que deseja excluir junto com o cliente:'),
            const SizedBox(height: 12),
            ...preview.options.map((option) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(option.title),
                  subtitle: Text(option.description),
                  onTap: () => Navigator.pop(dialogContext, option.key),
                )),
            const SizedBox(height: 8),
            if (preview.options.isEmpty)
              const Text('Este cliente possui vínculos que exigem tratamento antes da exclusão definitiva.'),
            if (preview.options.isNotEmpty)
              const Text('Essa ação não pode ser desfeita.'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
        ],
      ),
    );

    if (preview.options.isEmpty || selected == null) return;

    final mode = switch (selected) {
      'clientWithContracts' => ClientDeletionMode.clientWithContracts,
      'clientWithContractsAndProposals' => ClientDeletionMode.clientWithContractsAndProposals,
      _ => ClientDeletionMode.clientOnly,
    };

    await ref.read(clientRepositoryProvider).deletePermanently(clientId, mode);
    if (widget.archivedOnly) {
      await ref.read(archivedClientListProvider.notifier).refresh();
    } else {
      await ref.read(clientListProvider.notifier).refresh();
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente excluído permanentemente.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = widget.archivedOnly
        ? ref.watch(archivedClientListProvider)
        : ref.watch(clientListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.archivedOnly ? 'Clientes arquivados' : 'Clientes'),
        actions: [
          if (!widget.archivedOnly)
            IconButton(
              tooltip: 'Arquivados',
              onPressed: () => context.push('/clients/archived'),
              icon: const Icon(Icons.archive_outlined),
            ),
        ],
      ),
      body: Column(
        children: [
          // Barra de busca
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              hintText: 'Buscar por nome ou CPF/CNPJ...',
              leading: const Icon(Icons.search),
              onChanged: (q) => widget.archivedOnly
                  ? ref.read(archivedClientListProvider.notifier).search(q)
                  : ref.read(clientListProvider.notifier).search(q),
            ),
          ),
          if (!widget.archivedOnly)
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
          Expanded(child: switch (state) {
            ClientListLoading() => const Center(child: CircularProgressIndicator()),
            ClientListError(:final message) => Center(child: Text(message)),
            ClientListLoaded(:final clients) when clients.isEmpty =>
              Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(widget.archivedOnly ? 'Nenhum cliente arquivado' : 'Nenhum cliente encontrado', style: theme.textTheme.bodyLarge),
                  if (widget.archivedOnly) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Clientes arquivados aparecem aqui até serem restaurados ou excluídos.',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              )),
            ClientListLoaded(:final clients) => RefreshIndicator(
              onRefresh: () => widget.archivedOnly
                  ? ref.read(archivedClientListProvider.notifier).refresh()
                  : ref.read(clientListProvider.notifier).refresh(),
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (ctx, i) {
                  final c = clients[i];
                  return ListTile(
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
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) => _handleClientAction(context, c, value),
                      itemBuilder: (context) => [
                        if (!widget.archivedOnly)
                          const PopupMenuItem(value: 'edit', child: Text('Editar')),
                        if (!widget.archivedOnly)
                          const PopupMenuItem(value: 'archive', child: Text('Arquivar')),
                        if (widget.archivedOnly)
                          const PopupMenuItem(value: 'restore', child: Text('Restaurar')),
                        const PopupMenuItem(value: 'delete', child: Text('Excluir permanentemente')),
                      ],
                    ),
                    onTap: widget.archivedOnly ? null : () => context.push('/clients/${c.id}'),
                  );
                },
              ),
            ),
          }),
        ],
      ),
      floatingActionButton: widget.archivedOnly
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
                    context.push('/clients/new');
                  },
                  child: const Icon(Icons.person_add),
                );
              },
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
