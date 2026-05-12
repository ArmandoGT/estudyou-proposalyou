// lib/core/error/app_exception.dart
//
// Hierarquia de exceções do ProposalYou.
// Sealed class com subtipos para cada categoria de erro.

import 'package:supabase_flutter/supabase_flutter.dart';

/// Exceção base do aplicativo. Todas as exceções de domínio estendem esta classe.
sealed class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  /// Retorna uma mensagem amigável em PT-BR para exibição ao usuário.
  String toUserMessage();

  @override
  String toString() => 'AppException($code): $message';
}

/// Erro de conectividade ou timeout de rede.
final class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.originalError});

  @override
  String toUserMessage() =>
      'Sem conexão com a internet. Verifique sua rede e tente novamente.';
}

/// Erro de autenticação (credenciais inválidas, sessão expirada, etc.)
final class AppAuthException extends AppException {
  const AppAuthException(super.message, {super.code, super.originalError});

  @override
  String toUserMessage() => switch (code) {
        'invalid_credentials' =>
          'E-mail ou senha incorretos. Verifique e tente novamente.',
        'email_not_confirmed' =>
          'E-mail ainda não confirmado. Verifique sua caixa de entrada.',
        'session_expired' =>
          'Sua sessão expirou. Faça login novamente.',
        'user_not_found' =>
          'Usuário não encontrado.',
        _ => 'Erro de autenticação. Tente novamente.',
      };
}

/// Erro de operação no banco de dados (Supabase / Drift).
final class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.code, super.originalError});

  @override
  String toUserMessage() =>
      'Erro ao acessar os dados. Tente novamente em alguns instantes.';
}

/// Erro de validação de dados (campos obrigatórios, formato inválido, etc.)
final class ValidationException extends AppException {
  final Map<String, String> fieldErrors;

  const ValidationException(
    super.message, {
    super.code,
    super.originalError,
    this.fieldErrors = const {},
  });

  @override
  String toUserMessage() => message;
}

/// Recurso não encontrado (404).
final class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code, super.originalError});

  @override
  String toUserMessage() =>
      'O item solicitado não foi encontrado ou foi removido.';
}

/// Acesso negado — RLS ou permissão insuficiente.
final class PermissionException extends AppException {
  const PermissionException(super.message, {super.code, super.originalError});

  @override
  String toUserMessage() =>
      'Você não tem permissão para acessar este recurso.';
}

// ─────────────────────────────────────────────────────────────────────────────
// Extensions para conversão de exceções do Supabase → AppException
// ─────────────────────────────────────────────────────────────────────────────

/// Converte [PostgrestException] do Supabase em [AppException].
extension PostgrestExceptionX on PostgrestException {
  AppException toAppException() {
    // RLS violation ou permissão
    if (code == '42501' || message.contains('permission denied')) {
      return PermissionException(message, code: code, originalError: this);
    }
    // Not found (nenhuma linha retornada quando esperava uma)
    if (code == 'PGRST116') {
      return NotFoundException(message, code: code, originalError: this);
    }
    // Unique constraint violation
    if (code == '23505') {
      return ValidationException(
        'Este registro já existe.',
        code: code,
        originalError: this,
      );
    }
    // FK constraint violation
    if (code == '23503') {
      return DatabaseException(
        'Referência inválida: $message',
        code: code,
        originalError: this,
      );
    }
    // Fallback genérico
    return DatabaseException(message, code: code, originalError: this);
  }
}

/// Converte [AuthException] do Supabase em [AppException].
extension GoTrueExceptionX on AuthApiException {
  AppException toAppException() {
    return AppAuthException(
      message,
      code: statusCode,
      originalError: this,
    );
  }
}
