// lib/features/proposals/presentation/proposal_step2_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/product_dto.dart';
import '../../../data/dtos/proposal_dto.dart';
import '../../products/domain/product_notifier.dart';
import '../../products/domain/product_state.dart';
import '../domain/proposal_notifier.dart';
import '../domain/proposal_state.dart';

final _brl = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

class ProposalStep2Screen extends ConsumerStatefulWidget {
  const ProposalStep2Screen({super.key});

  @override
  ConsumerState<ProposalStep2Screen> createState() => _ProposalStep2ScreenState();
}

class _ProposalStep2ScreenState extends ConsumerState<ProposalStep2Screen> {
  List<Map<String, dynamic>> _items = [];
  bool _initialized = false;

  void _init(ProposalDto draft) {
    if (_initialized) return;
    _initialized = true;
    _items = List.from(draft.itensJson);
  }

  void _addItem(ProductDto product) {
    setState(() {
      _items.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'product_id': product.id,
        'nome': product.nome,
        'quantidade': 1.0,
        'preco_unitario': product.preco,
      });
    });
  }

  void _updateItemQty(int index, double qty) {
    if (qty <= 0) return;
    setState(() {
      final item = Map<String, dynamic>.from(_items[index]);
      item['quantidade'] = qty;
      _items[index] = item;
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  double get _total => _items.fold(0.0, (sum, i) => sum + ((i['quantidade'] as num).toDouble() * (i['preco_unitario'] as num).toDouble()));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(proposalWizardProvider);
    final productsState = ref.watch(productListProvider);

    if (state is! ProposalWizardStep2) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    _init(state.draft);

    return Scaffold(
      appBar: AppBar(title: const Text('Itens da Proposta (2/3)')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(
                child: DropdownButtonFormField<ProductDto>(
                  decoration: const InputDecoration(labelText: 'Adicionar Produto/Serviço'),
                  items: productsState is ProductListLoaded
                      ? (productsState as ProductListLoaded).products.where((p) => p.ativo).map((p) => DropdownMenuItem(
                          value: p, child: Text('${p.nome} - ${_brl.format(p.preco)}'),
                        )).toList()
                      : [],
                  onChanged: (p) {
                    if (p != null) _addItem(p);
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: () => context.push('/products/new'),
                icon: const Icon(Icons.add),
                tooltip: 'Novo Produto',
              ),
            ]),
          ),
          
          Expanded(
            child: _items.isEmpty
                ? Center(child: Text('Nenhum item adicionado', style: theme.textTheme.bodyLarge))
                : ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final item = _items[i];
                      final qtd = (item['quantidade'] as num).toDouble();
                      final preco = (item['preco_unitario'] as num).toDouble();
                      return ListTile(
                        title: Text(item['nome'] as String),
                        subtitle: Text('${_brl.format(preco)} unitário'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _updateItemQty(i, qtd - 1),
                            ),
                            Text(qtd.toStringAsFixed(qtd % 1 == 0 ? 0 : 2)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => _updateItemQty(i, qtd + 1),
                            ),
                            const SizedBox(width: 8),
                            Text(_brl.format(qtd * preco),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeItem(i),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: theme.textTheme.titleMedium),
                      Text(_brl.format(_total),
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(proposalWizardProvider.notifier).goToStep(1, state.draft.copyWith(itensJson: _items, total: _total));
                          context.pop();
                        },
                        child: const Text('Voltar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _items.isEmpty ? null : () {
                          ref.read(proposalWizardProvider.notifier).goToStep(3, state.draft.copyWith(itensJson: _items, total: _total));
                          context.push('/proposals/new/step3');
                        },
                        child: const Text('Próximo: Resumo'),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
