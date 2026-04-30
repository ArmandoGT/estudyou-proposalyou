// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signatureRepository)
final signatureRepositoryProvider = SignatureRepositoryProvider._();

final class SignatureRepositoryProvider
    extends
        $FunctionalProvider<
          SignatureRepository,
          SignatureRepository,
          SignatureRepository
        >
    with $Provider<SignatureRepository> {
  SignatureRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signatureRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signatureRepositoryHash();

  @$internal
  @override
  $ProviderElement<SignatureRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SignatureRepository create(Ref ref) {
    return signatureRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignatureRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignatureRepository>(value),
    );
  }
}

String _$signatureRepositoryHash() =>
    r'c4c0635778d9950d87c26f91b820be321076c2c3';
