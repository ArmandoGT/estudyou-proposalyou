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
  final _searchCtrl = TextEditingController();
  final _descontoCtrl = TextEditingController();
  List<Map<String, dynamic>> _items = [];
  bool _initialized = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    _descontoCtrl.dispose();
    super.dispose();
  }

  void _init(ProposalDto draft) {
    if (_initialized) return;
    _initialized = true;
    _items = List<Map<String, dynamic>>.from(draft.itensJson);
    _descontoCtrl.text = draft.desconto == 0 ? '' : draft.desconto.toStringAsFixed(2);
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

  void _updateItem(int index, {double? quantidade, double? preco}) {
    setState(() {
      final item = Map<String, dynamic>.from(_items[index]);
      if (quantidade != null && quantidade > 0) item['quantidade'] = quantidade;
      if (preco != null && preco >= 0) item['preco_unitario'] = preco;
      _items[index] = item;
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  double get _subtotal => _items.fold(0.0, (sum, item) => sum + ((item['quantidade'] as num).toDouble() * (item['preco_unitario'] as num).toDouble()));
  double get _desconto => double.tryParse(_descontoCtrl.text.replaceAll(',', '.')) ?? 0.0;
  double get _total => (_subtotal - _desconto).clamp(0, double.infinity);

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
            child: Column(
              children: [
                TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Buscar item do catálogo',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => ref.read(productListProvider.notifier).search(value),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<ProductDto>(
                        decoration: const InputDecoration(labelText: 'Adicionar Produto/Serviço'),
                        items: productsState is ProductListLoaded
                            ? productsState.products
                                .where((product) => product.ativo)
                                .map((product) => DropdownMenuItem(
                                      value: product,
                                      child: Text('${product.nome} - ${_brl.format(product.preco)}'),
                                    ))
                                .toList()
                            : [],
                        onChanged: (product) {
                          if (product != null) _addItem(product);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: () => context.push('/products/new'),
                      icon: const Icon(Icons.add),
                      tooltip: 'Novo Produto',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? Center(child: Text('Nenhum item adicionado', style: theme.textTheme.bodyLarge))
                : ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      final quantidade = (item['quantidade'] as num).toDouble();
                      final preco = (item['preco_unitario'] as num).toDouble();
                      final qtyCtrl = TextEditingController(text: quantidade.toStringAsFixed(quantidade % 1 == 0 ? 0 : 2));
                      final priceCtrl = TextEditingController(text: preco.toStringAsFixed(2));

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['nome'] as String, style: theme.textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: qtyCtrl,
                                    decoration: const InputDecoration(labelText: 'Quantidade'),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (value) => _updateItem(index, quantidade: double.tryParse(value.replaceAll(',', '.'))),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: priceCtrl,
                                    decoration: const InputDecoration(labelText: 'Preço unitário'),
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (value) => _updateItem(index, preco: double.tryParse(value.replaceAll(',', '.'))),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _removeItem(index),
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Subtotal: ${_brl.format(quantidade * preco)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
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
                  TextField(
                    controller: _descontoCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Desconto',
                      prefixText: 'R\$ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal'),
                      Text(_brl.format(_subtotal)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total final', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        _brl.format(_total),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(proposalWizardProvider.notifier).goToStep(
                                1,
                                state.draft.copyWith(itensJson: _items, total: _total, desconto: _desconto),
                              );
                          context.pop();
                        },
                        child: const Text('Voltar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _items.isEmpty
                            ? null
                            : () {
                                ref.read(proposalWizardProvider.notifier).goToStep(
                                      3,
                                      state.draft.copyWith(itensJson: _items, total: _total, desconto: _desconto),
                                    );
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
