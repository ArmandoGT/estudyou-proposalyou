// lib/features/products/presentation/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/dtos/product_dto.dart';
import '../domain/product_notifier.dart';
import '../domain/product_state.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();
  final _unidadeCtrl = TextEditingController();

  String _tipo = 'produto';
  bool _ativo = true;
  bool _initialized = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nomeCtrl.dispose(); _descricaoCtrl.dispose(); _precoCtrl.dispose(); _unidadeCtrl.dispose();
    super.dispose();
  }

  void _initForm(ProductDto p) {
    if (_initialized) return;
    _initialized = true;
    _nomeCtrl.text = p.nome;
    _descricaoCtrl.text = p.descricao ?? '';
    _precoCtrl.text = p.preco.toStringAsFixed(2);
    _unidadeCtrl.text = p.unidade ?? '';
    _tipo = p.tipo;
    _ativo = p.ativo;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = widget.productId == 'new';
    final state = ref.watch(productDetailProvider(isNew ? null : widget.productId));

    // Listener removido para tratamento direto no _save com bloco finally

    return Scaffold(
      appBar: AppBar(title: Text(isNew ? 'Novo Item' : 'Editar Item')),
      body: switch (state) {
        ProductDetailLoading() => const Center(child: CircularProgressIndicator()),
        ProductDetailError(:final message) => Center(child: Text(message)),
        ProductDetailSaved() => const Center(child: Icon(Icons.check_circle, size: 64)),
        ProductDetailLoaded(:final product, :final isSaving) => _buildForm(product, isNew, isSaving, theme),
      },
    );
  }

  Widget _buildForm(ProductDto product, bool isNew, bool isSaving, ThemeData theme) {
    _initForm(product);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'produto', label: Text('Produto'), icon: Icon(Icons.inventory_2)),
                ButtonSegment(value: 'servico', label: Text('Serviço'), icon: Icon(Icons.handyman)),
              ],
              selected: {_tipo},
              onSelectionChanged: (v) => setState(() => _tipo = v.first),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _nomeCtrl,
              decoration: const InputDecoration(labelText: 'Nome do Item'),
              validator: (v) => v?.isEmpty ?? true ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _descricaoCtrl,
              decoration: const InputDecoration(labelText: 'Descrição (opcional)'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),

            Row(children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _precoCtrl,
                  decoration: const InputDecoration(labelText: 'Preço', prefixText: 'R\$ '),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => v?.isEmpty ?? true ? 'Obrigatório' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _unidadeCtrl,
                  decoration: const InputDecoration(labelText: 'Und.', hintText: 'ex: un, hr, kg'),
                ),
              ),
            ]),
            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text('Item Ativo'),
              subtitle: const Text('Exibir na listagem para novas propostas'),
              value: _ativo,
              onChanged: (v) => setState(() => _ativo = v),
            ),
            const SizedBox(height: 24),

            FilledButton(
              onPressed: (_isLoading || isSaving) ? null : _save,
              child: (_isLoading || isSaving)
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    
    FocusScope.of(context).unfocus();
    
    final isNew = widget.productId == 'new';
    final state = ref.read(productDetailProvider(isNew ? null : widget.productId));
    if (state is! ProductDetailLoaded) return;

    setState(() => _isLoading = true);

    final updated = state.product.copyWith(
      nome: _nomeCtrl.text.trim(),
      descricao: _descricaoCtrl.text.trim().isEmpty ? null : _descricaoCtrl.text.trim(),
      preco: double.tryParse(_precoCtrl.text.replaceAll(',', '.')) ?? 0.0,
      tipo: _tipo,
      unidade: _unidadeCtrl.text.trim().isEmpty ? null : _unidadeCtrl.text.trim(),
      ativo: _ativo,
    );

    try {
      await ref.read(productDetailProvider(isNew ? null : widget.productId).notifier).saveProduct(updated);

      if (!mounted) return;

      ref.invalidate(productListProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto salvo com sucesso!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      context.pop();

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha ao salvar: ${e.toString().replaceAll("Exception: ", "")}'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
