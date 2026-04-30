// lib/data/supabase/supabase_provider.dart
//
// Providers Riverpod para acesso ao Supabase Client, Auth e Auth State Stream.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_provider.g.dart';

/// Provider global do SupabaseClient — keepAlive para manter a conexão.
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}

/// Provider do GoTrueClient para operações de autenticação.
@Riverpod(keepAlive: true)
GoTrueClient authClient(Ref ref) {
  return ref.watch(supabaseClientProvider).auth;
}

/// Stream reativa do estado de autenticação.
/// Emite eventos a cada login, logout ou refresh de token.
/// Usado pelo GoRouter para rebuild automático do redirect.
@riverpod
Stream<AuthState> authStateStream(Ref ref) {
  return ref.watch(authClientProvider).onAuthStateChange;
}

/// Provider do usuário atualmente logado (nullable).
@riverpod
User? currentUser(Ref ref) {
  // Escuta a stream de auth para reagir a mudanças
  ref.watch(authStateStreamProvider);
  return ref.watch(supabaseClientProvider).auth.currentUser;
}
