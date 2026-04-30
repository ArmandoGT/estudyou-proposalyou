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
    r'2f6ca6e4444daa3b70e469b020c25b0df89f6da2';

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
    r'1259e5366758d1ae611ad9a2e5136ec10ec9dd66';

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
