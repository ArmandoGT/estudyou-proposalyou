// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider global do SupabaseClient — keepAlive para manter a conexão.

@ProviderFor(supabaseClient)
final supabaseClientProvider = SupabaseClientProvider._();

/// Provider global do SupabaseClient — keepAlive para manter a conexão.

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// Provider global do SupabaseClient — keepAlive para manter a conexão.
  SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'2df5a38617329a3bb0a7e149189bea875722d7b8';

/// Provider do GoTrueClient para operações de autenticação.

@ProviderFor(authClient)
final authClientProvider = AuthClientProvider._();

/// Provider do GoTrueClient para operações de autenticação.

final class AuthClientProvider
    extends $FunctionalProvider<GoTrueClient, GoTrueClient, GoTrueClient>
    with $Provider<GoTrueClient> {
  /// Provider do GoTrueClient para operações de autenticação.
  AuthClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authClientHash();

  @$internal
  @override
  $ProviderElement<GoTrueClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoTrueClient create(Ref ref) {
    return authClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoTrueClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoTrueClient>(value),
    );
  }
}

String _$authClientHash() => r'6c2f6004e8366c3b3a2b5c1d675b6d45ff88637a';

/// Stream reativa do estado de autenticação.
/// Emite eventos a cada login, logout ou refresh de token.
/// Usado pelo GoRouter para rebuild automático do redirect.

@ProviderFor(authStateStream)
final authStateStreamProvider = AuthStateStreamProvider._();

/// Stream reativa do estado de autenticação.
/// Emite eventos a cada login, logout ou refresh de token.
/// Usado pelo GoRouter para rebuild automático do redirect.

final class AuthStateStreamProvider
    extends
        $FunctionalProvider<AsyncValue<AuthState>, AuthState, Stream<AuthState>>
    with $FutureModifier<AuthState>, $StreamProvider<AuthState> {
  /// Stream reativa do estado de autenticação.
  /// Emite eventos a cada login, logout ou refresh de token.
  /// Usado pelo GoRouter para rebuild automático do redirect.
  AuthStateStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateStreamHash();

  @$internal
  @override
  $StreamProviderElement<AuthState> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AuthState> create(Ref ref) {
    return authStateStream(ref);
  }
}

String _$authStateStreamHash() => r'00f6e68182cadfc294efb7f8f5b0ee741438cbf8';

/// Provider do usuário atualmente logado (nullable).

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// Provider do usuário atualmente logado (nullable).

final class CurrentUserProvider extends $FunctionalProvider<User?, User?, User?>
    with $Provider<User?> {
  /// Provider do usuário atualmente logado (nullable).
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  User? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User?>(value),
    );
  }
}

String _$currentUserHash() => r'2e30fbe4173c55a4708061f46e2228a678c49fa0';
