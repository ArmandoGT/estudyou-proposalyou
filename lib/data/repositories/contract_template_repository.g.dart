// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_template_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contractTemplateRepository)
final contractTemplateRepositoryProvider =
    ContractTemplateRepositoryProvider._();

final class ContractTemplateRepositoryProvider
    extends
        $FunctionalProvider<
          ContractTemplateRepository,
          ContractTemplateRepository,
          ContractTemplateRepository
        >
    with $Provider<ContractTemplateRepository> {
  ContractTemplateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contractTemplateRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contractTemplateRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContractTemplateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContractTemplateRepository create(Ref ref) {
    return contractTemplateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContractTemplateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContractTemplateRepository>(value),
    );
  }
}

String _$contractTemplateRepositoryHash() =>
    r'cbd0e30a8809497e5a329e6836ee00bb6f150a9e';
