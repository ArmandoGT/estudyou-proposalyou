// lib/features/products/presentation/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/services/active_provider_context.dart';
import '../domain/product_notifier.dart';
import '../domain/product_state.dart';

final _brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Produtos & Serviços')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              hintText: 'Buscar produto ou serviço...',
              leading: const Icon(Icons.search),
              onChanged: (q) => ref.read(productListProvider.notifier).search(q),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(children: [
              _FilterChip(
                label: 'Todos',
                selected: state is ProductListLoaded && state.activeTypeFilter == null,
                onSelected: () => ref.read(productListProvider.notifier).filterByType(null),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Produtos',
                selected: state is ProductListLoaded && state.activeTypeFilter == 'produto',
                onSelected: () => ref.read(productListProvider.notifier).filterByType('produto'),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Serviços',
                selected: state is ProductListLoaded && state.activeTypeFilter == 'servico',
                onSelected: () => ref.read(productListProvider.notifier).filterByType('servico'),
              ),
            ]),
          ),
          const Divider(height: 1),
          Expanded(child: switch (state) {
            ProductListLoading() => const Center(child: CircularProgressIndicator()),
            ProductListError(:final message) => Center(child: Text(message)),
            ProductListLoaded(:final products) when products.isEmpty =>
              Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('Nenhum item encontrado', style: theme.textTheme.bodyLarge),
                ],
              )),
            ProductListLoaded(:final products) => RefreshIndicator(
              onRefresh: () => ref.read(productListProvider.notifier).refresh(),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  final p = products[i];
                  final isProduct = p.tipo == 'produto';
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isProduct
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.secondaryContainer,
                      child: Icon(
                        isProduct ? Icons.inventory_2 : Icons.handyman,
                        color: isProduct
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            p.nome,
                            style: p.ativo
                                ? null
                                : theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                          ),
                        ),
                        if (!p.ativo)
                          Chip(
                            label: const Text('Inativo'),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            labelStyle: theme.textTheme.labelSmall,
                          ),
                      ],
                    ),
                    subtitle: Text(
                      '${isProduct ? "Produto" : "Serviço"}${p.unidade != null ? ' • ${p.unidade}' : ''}${p.descricao != null && p.descricao!.trim().isNotEmpty ? ' • ${p.descricao!.trim()}' : ''}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _brlFormat.format(p.preco),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: p.ativo ? null : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () => context.push('/products/${p.id}'),
                  );
                },
              ),
            ),
          }),
        ],
      ),
      floatingActionButton: FutureBuilder<bool>(
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
              context.push('/products/new');
            },
            child: const Icon(Icons.add),
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
