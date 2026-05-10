// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClientListNotifier)
final clientListProvider = ClientListNotifierProvider._();

final class ClientListNotifierProvider
    extends $NotifierProvider<ClientListNotifier, ClientListState> {
  ClientListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientListNotifierHash();

  @$internal
  @override
  ClientListNotifier create() => ClientListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientListState>(value),
    );
  }
}

String _$clientListNotifierHash() =>
    r'11d42e9b7db8bed0d1227cd28e348b8b043ad181';

abstract class _$ClientListNotifier extends $Notifier<ClientListState> {
  ClientListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ClientListState, ClientListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientListState, ClientListState>,
              ClientListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ArchivedClientListNotifier)
final archivedClientListProvider = ArchivedClientListNotifierProvider._();

final class ArchivedClientListNotifierProvider
    extends $NotifierProvider<ArchivedClientListNotifier, ClientListState> {
  ArchivedClientListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archivedClientListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archivedClientListNotifierHash();

  @$internal
  @override
  ArchivedClientListNotifier create() => ArchivedClientListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientListState>(value),
    );
  }
}

String _$archivedClientListNotifierHash() =>
    r'bc5670195d460bf01cc648a684a0b81a928029c9';

abstract class _$ArchivedClientListNotifier extends $Notifier<ClientListState> {
  ClientListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ClientListState, ClientListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientListState, ClientListState>,
              ClientListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(clientDeletionPreview)
final clientDeletionPreviewProvider = ClientDeletionPreviewFamily._();

final class ClientDeletionPreviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<ClientDeletionPreview>,
          ClientDeletionPreview,
          FutureOr<ClientDeletionPreview>
        >
    with
        $FutureModifier<ClientDeletionPreview>,
        $FutureProvider<ClientDeletionPreview> {
  ClientDeletionPreviewProvider._({
    required ClientDeletionPreviewFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'clientDeletionPreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clientDeletionPreviewHash();

  @override
  String toString() {
    return r'clientDeletionPreviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ClientDeletionPreview> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ClientDeletionPreview> create(Ref ref) {
    final argument = this.argument as String;
    return clientDeletionPreview(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientDeletionPreviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clientDeletionPreviewHash() =>
    r'ce2b3daee247ff5344b0a793379a1bdc069ea0bd';

final class ClientDeletionPreviewFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ClientDeletionPreview>, String> {
  ClientDeletionPreviewFamily._()
    : super(
        retry: null,
        name: r'clientDeletionPreviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClientDeletionPreviewProvider call(String clientId) =>
      ClientDeletionPreviewProvider._(argument: clientId, from: this);

  @override
  String toString() => r'clientDeletionPreviewProvider';
}

@ProviderFor(ClientDetailNotifier)
final clientDetailProvider = ClientDetailNotifierFamily._();

final class ClientDetailNotifierProvider
    extends $NotifierProvider<ClientDetailNotifier, ClientDetailState> {
  ClientDetailNotifierProvider._({
    required ClientDetailNotifierFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'clientDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clientDetailNotifierHash();

  @override
  String toString() {
    return r'clientDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ClientDetailNotifier create() => ClientDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ClientDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clientDetailNotifierHash() =>
    r'249a87212eaf312cb987427de436d483965e6ae6';

final class ClientDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ClientDetailNotifier,
          ClientDetailState,
          ClientDetailState,
          ClientDetailState,
          String?
        > {
  ClientDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'clientDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClientDetailNotifierProvider call(String? clientId) =>
      ClientDetailNotifierProvider._(argument: clientId, from: this);

  @override
  String toString() => r'clientDetailProvider';
}

abstract class _$ClientDetailNotifier extends $Notifier<ClientDetailState> {
  late final _$args = ref.$arg as String?;
  String? get clientId => _$args;

  ClientDetailState build(String? clientId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ClientDetailState, ClientDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClientDetailState, ClientDetailState>,
              ClientDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
