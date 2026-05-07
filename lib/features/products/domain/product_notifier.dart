// lib/features/products/domain/product_notifier.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/dtos/product_dto.dart';
import '../../../data/repositories/product_repository.dart';
import 'product_state.dart';

part 'product_notifier.g.dart';

// ─────────────────────────────────────────────────────────────
// Lista de Produtos
// ─────────────────────────────────────────────────────────────

@riverpod
class ProductListNotifier extends _$ProductListNotifier {
  Timer? _debounce;

  @override
  ProductListState build() {
    ref.onDispose(() => _debounce?.cancel());
    _loadProducts();
    return const ProductListLoading();
  }

  Future<void> _loadProducts() async {
    try {
      final repo = ref.read(productRepositoryProvider);
      final products = await repo.getAll();
      state = ProductListLoaded(products: products);
    } on AppException catch (e) {
      state = ProductListError(e.toUserMessage());
    }
  }

  /// Busca com debounce de 300ms.
  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(productRepositoryProvider);
        final currentState = state;
        final filter = currentState is ProductListLoaded ? currentState.activeTypeFilter : null;

        List<ProductDto> results;
        if (query.isEmpty) {
          results = await repo.getAll();
        } else {
          results = await repo.searchByName(query);
        }

        // Aplica filtro local
        if (filter != null) {
          results = _applyFilter(results, filter);
        }

        state = ProductListLoaded(products: results, activeTypeFilter: filter, searchQuery: query);
      } on AppException catch (e) {
        state = ProductListError(e.toUserMessage());
      }
    });
  }

  /// Filtra por tipo (produto ou servico).
  void filterByType(String? type) {
    final currentState = state;
    if (currentState is! ProductListLoaded) return;

    var products = currentState.products;
    if (type != null) {
      products = _applyFilter(products, type);
    }
    state = ProductListLoaded(
      products: products, activeTypeFilter: type, searchQuery: currentState.searchQuery,
    );

    if (currentState.searchQuery.isNotEmpty) {
      search(currentState.searchQuery);
    } else {
      _loadProducts();
    }
  }

  List<ProductDto> _applyFilter(List<ProductDto> products, String type) {
    return products.where((p) => p.tipo == type).toList();
  }

  Future<void> refresh() => _loadProducts();
}

// ─────────────────────────────────────────────────────────────
// Detalhe / Edição de Produto
// ─────────────────────────────────────────────────────────────

@riverpod
class ProductDetailNotifier extends _$ProductDetailNotifier {
  @override
  ProductDetailState build(String? productId) {
    if (productId == null || productId == 'new') {
      return ProductDetailLoaded(
        product: ProductDto(
          id: '', providerId: '', nome: '', preco: 0.0, tipo: 'produto',
          createdAt: DateTime.now(), updatedAt: DateTime.now(),
        ),
        isNew: true,
      );
    }
    _loadProduct(productId);
    return const ProductDetailLoading();
  }

  Future<void> _loadProduct(String id) async {
    try {
      final repo = ref.read(productRepositoryProvider);
      final product = await repo.getById(id);
      state = ProductDetailLoaded(product: product);
    } on AppException catch (e) {
      state = ProductDetailError(e.toUserMessage());
    }
  }

  Future<void> saveProduct(ProductDto dto) async {
    final currentState = state;
    if (currentState is! ProductDetailLoaded) return;

    state = ProductDetailLoaded(product: dto, isNew: currentState.isNew, isSaving: true);

    try {
      final repo = ref.read(productRepositoryProvider);
      
      final authService = ref.read(authServiceProvider.notifier);
      final activeProviderId = await authService.getActiveProviderId();
      
      final dtoToSave = dto.copyWith(providerId: activeProviderId);

      ProductDto saved;
      if (currentState.isNew) {
        final json = dtoToSave.toJson()..remove('id');
        saved = await repo.create(ProductDto.fromJson({
          ...json,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }));
      } else {
        saved = await repo.update(dtoToSave);
      }
      state = ProductDetailSaved(saved);
    } catch (e) {
      // ignore: avoid_print
      print('Erro crítico ao salvar produto no Supabase: $e');
      
      state = ProductDetailLoaded(product: dto, isNew: currentState.isNew, isSaving: false);
      
      throw Exception('Não foi possível salvar o produto. Detalhes: $e');
    }
  }
}
