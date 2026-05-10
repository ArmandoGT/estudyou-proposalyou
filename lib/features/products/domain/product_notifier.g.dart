// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductListNotifier)
final productListProvider = ProductListNotifierProvider._();

final class ProductListNotifierProvider
    extends $NotifierProvider<ProductListNotifier, ProductListState> {
  ProductListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productListNotifierHash();

  @$internal
  @override
  ProductListNotifier create() => ProductListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductListState>(value),
    );
  }
}

String _$productListNotifierHash() =>
    r'bfafddba28a4cd4b12e35709c926df3a27f9d543';

abstract class _$ProductListNotifier extends $Notifier<ProductListState> {
  ProductListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProductListState, ProductListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProductListState, ProductListState>,
              ProductListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProductDetailNotifier)
final productDetailProvider = ProductDetailNotifierFamily._();

final class ProductDetailNotifierProvider
    extends $NotifierProvider<ProductDetailNotifier, ProductDetailState> {
  ProductDetailNotifierProvider._({
    required ProductDetailNotifierFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'productDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailNotifierHash();

  @override
  String toString() {
    return r'productDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductDetailNotifier create() => ProductDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailNotifierHash() =>
    r'7ae36501e7697524404830f4edbb76a1042ab5ea';

final class ProductDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductDetailNotifier,
          ProductDetailState,
          ProductDetailState,
          ProductDetailState,
          String?
        > {
  ProductDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'productDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailNotifierProvider call(String? productId) =>
      ProductDetailNotifierProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailProvider';
}

abstract class _$ProductDetailNotifier extends $Notifier<ProductDetailState> {
  late final _$args = ref.$arg as String?;
  String? get productId => _$args;

  ProductDetailState build(String? productId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProductDetailState, ProductDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProductDetailState, ProductDetailState>,
              ProductDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
