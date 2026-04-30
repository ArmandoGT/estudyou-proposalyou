// lib/features/products/domain/product_state.dart

import '../../../data/dtos/product_dto.dart';

/// Estado da lista de produtos.
sealed class ProductListState {
  const ProductListState();
}

final class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

final class ProductListLoaded extends ProductListState {
  final List<ProductDto> products;
  final String? activeTypeFilter; // null | 'produto' | 'servico'
  final String searchQuery;

  const ProductListLoaded({
    required this.products,
    this.activeTypeFilter,
    this.searchQuery = '',
  });
}

final class ProductListError extends ProductListState {
  final String message;
  const ProductListError(this.message);
}

/// Estado do detalhe/edição de produto.
sealed class ProductDetailState {
  const ProductDetailState();
}

final class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

final class ProductDetailLoaded extends ProductDetailState {
  final ProductDto product;
  final bool isNew;
  final bool isSaving;

  const ProductDetailLoaded({
    required this.product,
    this.isNew = false,
    this.isSaving = false,
  });
}

final class ProductDetailSaved extends ProductDetailState {
  final ProductDto product;
  const ProductDetailSaved(this.product);
}

final class ProductDetailError extends ProductDetailState {
  final String message;
  const ProductDetailError(this.message);
}
