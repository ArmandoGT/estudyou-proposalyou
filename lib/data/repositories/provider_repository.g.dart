// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(providerRepository)
final providerRepositoryProvider = ProviderRepositoryProvider._();

final class ProviderRepositoryProvider
    extends
        $FunctionalProvider<
          ProviderRepository,
          ProviderRepository,
          ProviderRepository
        >
    with $Provider<ProviderRepository> {
  ProviderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProviderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProviderRepository create(Ref ref) {
    return providerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProviderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProviderRepository>(value),
    );
  }
}

String _$providerRepositoryHash() =>
    r'7c438b1e9fd13b183602a9e06b7be6faeb5f9160';
