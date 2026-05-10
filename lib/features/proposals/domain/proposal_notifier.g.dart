// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProposalListNotifier)
final proposalListProvider = ProposalListNotifierProvider._();

final class ProposalListNotifierProvider
    extends $NotifierProvider<ProposalListNotifier, ProposalListState> {
  ProposalListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalListNotifierHash();

  @$internal
  @override
  ProposalListNotifier create() => ProposalListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalListState>(value),
    );
  }
}

String _$proposalListNotifierHash() =>
    r'4267e5bab357d996b0b20a73bd68219ab1d9824b';

abstract class _$ProposalListNotifier extends $Notifier<ProposalListState> {
  ProposalListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProposalListState, ProposalListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProposalListState, ProposalListState>,
              ProposalListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ArchivedProposalListNotifier)
final archivedProposalListProvider = ArchivedProposalListNotifierProvider._();

final class ArchivedProposalListNotifierProvider
    extends $NotifierProvider<ArchivedProposalListNotifier, ProposalListState> {
  ArchivedProposalListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archivedProposalListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archivedProposalListNotifierHash();

  @$internal
  @override
  ArchivedProposalListNotifier create() => ArchivedProposalListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalListState>(value),
    );
  }
}

String _$archivedProposalListNotifierHash() =>
    r'c1823d6951ee80c716894ae3c0e1f1a0f7dc02f9';

abstract class _$ArchivedProposalListNotifier
    extends $Notifier<ProposalListState> {
  ProposalListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProposalListState, ProposalListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProposalListState, ProposalListState>,
              ProposalListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProposalDetailNotifier)
final proposalDetailProvider = ProposalDetailNotifierFamily._();

final class ProposalDetailNotifierProvider
    extends $NotifierProvider<ProposalDetailNotifier, ProposalDetailState> {
  ProposalDetailNotifierProvider._({
    required ProposalDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'proposalDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$proposalDetailNotifierHash();

  @override
  String toString() {
    return r'proposalDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProposalDetailNotifier create() => ProposalDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProposalDetailNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$proposalDetailNotifierHash() =>
    r'fe1ce8bed43f74b63f5ed79792fc4b1a0ebb54ae';

final class ProposalDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ProposalDetailNotifier,
          ProposalDetailState,
          ProposalDetailState,
          ProposalDetailState,
          String
        > {
  ProposalDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'proposalDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProposalDetailNotifierProvider call(String proposalId) =>
      ProposalDetailNotifierProvider._(argument: proposalId, from: this);

  @override
  String toString() => r'proposalDetailProvider';
}

abstract class _$ProposalDetailNotifier extends $Notifier<ProposalDetailState> {
  late final _$args = ref.$arg as String;
  String get proposalId => _$args;

  ProposalDetailState build(String proposalId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProposalDetailState, ProposalDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProposalDetailState, ProposalDetailState>,
              ProposalDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(ProposalWizardNotifier)
final proposalWizardProvider = ProposalWizardNotifierProvider._();

final class ProposalWizardNotifierProvider
    extends $NotifierProvider<ProposalWizardNotifier, ProposalWizardState> {
  ProposalWizardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalWizardProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalWizardNotifierHash();

  @$internal
  @override
  ProposalWizardNotifier create() => ProposalWizardNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalWizardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalWizardState>(value),
    );
  }
}

String _$proposalWizardNotifierHash() =>
    r'3062b5aadb24da347202a701d8b2c49a0252b24d';

abstract class _$ProposalWizardNotifier extends $Notifier<ProposalWizardState> {
  ProposalWizardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProposalWizardState, ProposalWizardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProposalWizardState, ProposalWizardState>,
              ProposalWizardState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
