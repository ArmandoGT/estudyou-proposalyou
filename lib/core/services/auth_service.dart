// lib/core/services/auth_service.dart
//
// Serviço de autenticação: login, logout, troca de empresa, biometria.

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

import '../../data/dtos/provider_dto.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/supabase/supabase_provider.dart';
import '../error/app_exception.dart';

part 'auth_service.g.dart';

/// Chaves para flutter_secure_storage
const _kActiveProviderId = 'active_provider_id';
const _kActiveProviderSlug = 'active_provider_slug';
const _kBiometricEnabled = 'biometric_enabled';

/// Serviço de autenticação como AsyncNotifier keepAlive.
///
/// Gerencia o ciclo de vida de autenticação:
/// - Login com email/senha + seleção de empresa
/// - Logout com limpeza de sessão
/// - Troca de empresa ativa sem relogin
/// - Biometria após primeiro login
@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  late final FlutterSecureStorage _secureStorage;
  late final LocalAuthentication _localAuth;

  @override
  Future<User?> build() async {
    _secureStorage = const FlutterSecureStorage();
    _localAuth = LocalAuthentication();

    // Verifica se há sessão ativa
    final client = ref.watch(supabaseClientProvider);
    return client.auth.currentUser;
  }

  /// Login com email e senha. Salva o provider ativo no secure storage.
  Future<void> signIn({
    required String email,
    required String password,
    required String providerSlug,
  }) async {
    state = const AsyncLoading();
    try {
      final client = ref.read(supabaseClientProvider);

      // Autentica no Supabase Auth
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const AuthException(
          'Falha na autenticação',
          code: 'invalid_credentials',
        );
      }

      // Busca o provider pela slug e salva como ativo
      final providerRepo = ref.read(providerRepositoryProvider);
      final provider = await providerRepo.getBySlug(providerSlug);

      await _secureStorage.write(key: _kActiveProviderId, value: provider.id);
      await _secureStorage.write(key: _kActiveProviderSlug, value: providerSlug);

      state = AsyncData(response.user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// Logout: limpa secure storage e invalida sessão Supabase.
  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(supabaseClientProvider);
      await client.auth.signOut();
      await _secureStorage.deleteAll();
      return null;
    });
  }

  /// Troca a empresa ativa sem necessidade de relogin.
  Future<void> switchActiveProvider(String slug) async {
    final providerRepo = ref.read(providerRepositoryProvider);
    final provider = await providerRepo.getBySlug(slug);
    await _secureStorage.write(key: _kActiveProviderId, value: provider.id);
    await _secureStorage.write(key: _kActiveProviderSlug, value: slug);
    // Força rebuild dos providers que dependem do provider ativo
    ref.invalidateSelf();
  }

  /// Retorna o provider ativo da sessão atual.
  Future<ProviderDto?> getCurrentProvider() async {
    final slug = await _secureStorage.read(key: _kActiveProviderSlug);
    if (slug == null) return null;
    try {
      final providerRepo = ref.read(providerRepositoryProvider);
      return await providerRepo.getBySlug(slug);
    } on AppException {
      return null;
    }
  }

  /// Retorna o ID do provider ativo.
  Future<String?> getActiveProviderId() async {
    return _secureStorage.read(key: _kActiveProviderId);
  }

  /// Verifica se biometria está disponível e habilitada.
  Future<bool> isBiometricAvailable() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    return canCheck && isDeviceSupported;
  }

  /// Autentica via biometria (após primeiro login bem-sucedido).
  Future<bool> authenticateWithBiometric() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Autentique-se para acessar o ProposalYou',
      );
    } catch (_) {
      return false;
    }
  }

  /// Habilita/desabilita biometria.
  Future<void> setBiometricEnabled(bool enabled) async {
    await _secureStorage.write(
      key: _kBiometricEnabled,
      value: enabled.toString(),
    );
  }

  Future<bool> isBiometricEnabled() async {
    final value = await _secureStorage.read(key: _kBiometricEnabled);
    return value == 'true';
  }
}
