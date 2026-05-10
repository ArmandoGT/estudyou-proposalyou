// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SignatureNotifier)
final signatureProvider = SignatureNotifierFamily._();

final class SignatureNotifierProvider
    extends $NotifierProvider<SignatureNotifier, SignatureState> {
  SignatureNotifierProvider._({
    required SignatureNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'signatureProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$signatureNotifierHash();

  @override
  String toString() {
    return r'signatureProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SignatureNotifier create() => SignatureNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignatureState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignatureState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SignatureNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$signatureNotifierHash() => r'a07044abd565d3a962492259de4c5403625713e9';

final class SignatureNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SignatureNotifier,
          SignatureState,
          SignatureState,
          SignatureState,
          String
        > {
  SignatureNotifierFamily._()
    : super(
        retry: null,
        name: r'signatureProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SignatureNotifierProvider call(String shareToken) =>
      SignatureNotifierProvider._(argument: shareToken, from: this);

  @override
  String toString() => r'signatureProvider';
}

abstract class _$SignatureNotifier extends $Notifier<SignatureState> {
  late final _$args = ref.$arg as String;
  String get shareToken => _$args;

  SignatureState build(String shareToken);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SignatureState, SignatureState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SignatureState, SignatureState>,
              SignatureState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
