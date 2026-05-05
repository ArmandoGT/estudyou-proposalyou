// lib/features/auth/domain/auth_notifier.dart
//
// Notifiers para Splash e Login.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

import '../../../core/error/app_exception.dart';
import '../../../core/services/auth_service.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

// ─────────────────────────────────────────────────────────────
// Splash / Onboarding Notifier
// ─────────────────────────────────────────────────────────────

const _kOnboardingComplete = 'onboarding_complete';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  SplashState build() => const SplashLoading();

  /// Verifica se onboarding já foi concluído.
  Future<void> checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool(_kOnboardingComplete) ?? false;

    if (done) {
      state = const SplashNavigateToLogin();
    } else {
      state = const SplashShowOnboarding();
    }
  }

  /// Marca onboarding como completo e navega para login.
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingComplete, true);
    state = const SplashNavigateToLogin();
  }
}

// ─────────────────────────────────────────────────────────────
// Login Notifier
// ─────────────────────────────────────────────────────────────

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => const LoginIdle();

  /// Executa login via AuthService.
  Future<void> login({
    required String email,
    required String password,
    required String providerSlug,
  }) async {
    state = const LoginLoading();

    try {
      final authService = ref.read(authServiceProvider.notifier);
      await authService.signIn(
        email: email,
        password: password,
        providerSlug: providerSlug,
      );
      state = const LoginSuccess();
    } on AppException catch (e) {
      state = LoginError(e.toUserMessage());
    } on AuthApiException catch (e) {
      state = LoginError(e.toAppException().toUserMessage());
    } catch (e, st) {
      print('LOGIN ERRO INESPERADO: $e\n$st');
      state = LoginError('Erro inesperado: $e');
    }
  }

  /// Envia email de recuperação de senha.
  Future<void> resetPassword(String email) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(email);
    } on AuthApiException catch (e) {
      throw e.toAppException();
    }
  }

  void resetState() => state = const LoginIdle();
}
