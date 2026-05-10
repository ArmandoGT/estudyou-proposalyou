// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contractRepository)
final contractRepositoryProvider = ContractRepositoryProvider._();

final class ContractRepositoryProvider
    extends
        $FunctionalProvider<
          ContractRepository,
          ContractRepository,
          ContractRepository
        >
    with $Provider<ContractRepository> {
  ContractRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contractRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contractRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContractRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContractRepository create(Ref ref) {
    return contractRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContractRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContractRepository>(value),
    );
  }
}

String _$contractRepositoryHash() =>
    r'93d2f939ac7344f061a4c004cb512e9f4bd6ae15';
