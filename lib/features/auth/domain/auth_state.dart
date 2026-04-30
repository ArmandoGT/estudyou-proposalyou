// lib/features/auth/domain/auth_state.dart
//
// Estados da feature de autenticação (Splash + Login).

/// Estado do Splash/Onboarding.
sealed class SplashState {
  const SplashState();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashShowOnboarding extends SplashState {
  const SplashShowOnboarding();
}

final class SplashNavigateToLogin extends SplashState {
  const SplashNavigateToLogin();
}

/// Estado do Login.
sealed class LoginState {
  const LoginState();
}

final class LoginIdle extends LoginState {
  const LoginIdle();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  const LoginSuccess();
}

final class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}
