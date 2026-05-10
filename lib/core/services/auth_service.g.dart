// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Serviço de autenticação como AsyncNotifier keepAlive.
///
/// Gerencia o ciclo de vida de autenticação:
/// - Login com email/senha + seleção de empresa
/// - Logout com limpeza de sessão
/// - Troca de empresa ativa sem relogin
/// - Biometria após primeiro login

@ProviderFor(AuthService)
final authServiceProvider = AuthServiceProvider._();

/// Serviço de autenticação como AsyncNotifier keepAlive.
///
/// Gerencia o ciclo de vida de autenticação:
/// - Login com email/senha + seleção de empresa
/// - Logout com limpeza de sessão
/// - Troca de empresa ativa sem relogin
/// - Biometria após primeiro login
final class AuthServiceProvider
    extends $AsyncNotifierProvider<AuthService, User?> {
  /// Serviço de autenticação como AsyncNotifier keepAlive.
  ///
  /// Gerencia o ciclo de vida de autenticação:
  /// - Login com email/senha + seleção de empresa
  /// - Logout com limpeza de sessão
  /// - Troca de empresa ativa sem relogin
  /// - Biometria após primeiro login
  AuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  AuthService create() => AuthService();
}

String _$authServiceHash() => r'6c740b268c22b9de53d0b62d79d2379c577434ed';

/// Serviço de autenticação como AsyncNotifier keepAlive.
///
/// Gerencia o ciclo de vida de autenticação:
/// - Login com email/senha + seleção de empresa
/// - Logout com limpeza de sessão
/// - Troca de empresa ativa sem relogin
/// - Biometria após primeiro login

abstract class _$AuthService extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
