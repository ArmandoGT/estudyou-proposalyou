// lib/main.dart
//
// ─────────────────────────────────────────────────────────────────────────────
// ProposalYou — Ponto de entrada principal do aplicativo
// ─────────────────────────────────────────────────────────────────────────────
//
// FLUXO DE BOOT:
//
// 1. `WidgetsFlutterBinding.ensureInitialized()` garante que os bindings
//    nativos do Flutter estejam prontos antes de qualquer operação assíncrona.
//
// 2. `Supabase.initialize()` conecta ao backend Supabase utilizando URL e
//    anon key fornecidos via `--dart-define`. Isso configura o cliente global
//    de autenticação, banco de dados (PostgreSQL) e storage.
//
// 3. `ProviderScope` envolve toda a árvore de widgets, inicializando o
//    container do Riverpod. Todos os providers (auth, router, features)
//    ficam acessíveis via `ref.watch` / `ref.read`.
//
// 4. `ProposalYouApp` (ConsumerWidget) lê o router configurado em
//    `appRouterProvider` e renderiza o `MaterialApp.router`, delegando
//    toda a navegação ao GoRouter com guards reativos.
//
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/router/app_router.dart';
import 'shared/theme/app_theme.dart';

/// Chaves de configuração injetadas em tempo de compilação via
/// `flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`
///
/// Em CI/CD, estas variáveis são definidas como secrets do pipeline.
/// Em desenvolvimento local, passe diretamente no comando `flutter run`.
const String _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const String _supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  // Garante que os bindings do Flutter estão inicializados antes de
  // operações assíncronas (Supabase, SharedPreferences, etc.)
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o cliente Supabase globalmente.
  // A URL e a anon key são injetadas via --dart-define para evitar
  // exposição de segredos no código-fonte ou em arquivos .env.
  await Supabase.initialize(
    url: _supabaseUrl,
    anonKey: _supabaseAnonKey,
  );

  // Inicia o app envolvido pelo ProviderScope do Riverpod.
  // O ProviderScope é o container raiz que mantém o estado de todos
  // os providers acessíveis na árvore de widgets.
  runApp(const ProviderScope(child: ProposalYouApp()));
}

/// Widget raiz do aplicativo ProposalYou.
///
/// Utiliza [ConsumerWidget] para acessar o sistema de providers do Riverpod.
/// O router é obtido via `ref.watch(appRouterProvider)`, garantindo que
/// mudanças no estado de autenticação (via redirect) sejam refletidas
/// automaticamente na navegação.
class ProposalYouApp extends ConsumerWidget {
  const ProposalYouApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observa o provider do GoRouter. Qualquer mudança no estado de
    // autenticação (authStateProvider) causa rebuild do redirect,
    // redirecionando o usuário para /login ou /home conforme necessário.
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      // Configuração do GoRouter (rotas, guards, deep links)
      routerConfig: router,

      // Título exibido no gerenciador de tarefas do sistema operacional
      title: 'ProposalYou',

      // Tema claro padrão — Material 3 com ColorScheme.fromSeed
      theme: AppTheme.light(),

      // Tema escuro — ativado automaticamente pelo sistema ou configurações
      darkTheme: AppTheme.dark(),

      // Modo de tema: segue a preferência do sistema operacional
      // ⚠️ DECISÃO PENDENTE: permitir override manual via settings (Fase 2)
      themeMode: ThemeMode.system,

      // Desativa o banner "DEBUG" no canto superior direito
      debugShowCheckedModeBanner: false,
    );
  }
}
