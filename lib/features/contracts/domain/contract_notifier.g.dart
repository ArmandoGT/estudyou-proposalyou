// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ContractListNotifier)
final contractListProvider = ContractListNotifierProvider._();

final class ContractListNotifierProvider
    extends $NotifierProvider<ContractListNotifier, ContractListState> {
  ContractListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contractListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contractListNotifierHash();

  @$internal
  @override
  ContractListNotifier create() => ContractListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContractListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContractListState>(value),
    );
  }
}

String _$contractListNotifierHash() =>
    r'4ba6c970c85c20c0581c4e7d29081c53638732df';

abstract class _$ContractListNotifier extends $Notifier<ContractListState> {
  ContractListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ContractListState, ContractListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ContractListState, ContractListState>,
              ContractListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ContractDetailNotifier)
final contractDetailProvider = ContractDetailNotifierFamily._();

final class ContractDetailNotifierProvider
    extends $NotifierProvider<ContractDetailNotifier, ContractDetailState> {
  ContractDetailNotifierProvider._({
    required ContractDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'contractDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contractDetailNotifierHash();

  @override
  String toString() {
    return r'contractDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ContractDetailNotifier create() => ContractDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContractDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContractDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ContractDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contractDetailNotifierHash() =>
    r'a935737a45774293719372a1985ed9ec993f5ad5';

final class ContractDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ContractDetailNotifier,
          ContractDetailState,
          ContractDetailState,
          ContractDetailState,
          String
        > {
  ContractDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'contractDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContractDetailNotifierProvider call(String contractId) =>
      ContractDetailNotifierProvider._(argument: contractId, from: this);

  @override
  String toString() => r'contractDetailProvider';
}

abstract class _$ContractDetailNotifier extends $Notifier<ContractDetailState> {
  late final _$args = ref.$arg as String;
  String get contractId => _$args;

  ContractDetailState build(String contractId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ContractDetailState, ContractDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ContractDetailState, ContractDetailState>,
              ContractDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ContractWizardNotifier)
final contractWizardProvider = ContractWizardNotifierProvider._();

final class ContractWizardNotifierProvider
    extends $NotifierProvider<ContractWizardNotifier, ContractWizardState> {
  ContractWizardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contractWizardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contractWizardNotifierHash();

  @$internal
  @override
  ContractWizardNotifier create() => ContractWizardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContractWizardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContractWizardState>(value),
    );
  }
}

String _$contractWizardNotifierHash() =>
    r'c478a978c52a047d18bb036f081fec5ad47a7357';

abstract class _$ContractWizardNotifier extends $Notifier<ContractWizardState> {
  ContractWizardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ContractWizardState, ContractWizardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ContractWizardState, ContractWizardState>,
              ContractWizardState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
