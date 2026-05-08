// lib/core/router/app_router.dart
//
// ─────────────────────────────────────────────────────────────────────────────
// ProposalYou — Configuração de rotas com GoRouter + Riverpod
// ─────────────────────────────────────────────────────────────────────────────
//
// Este arquivo define todas as rotas do aplicativo, o auth guard reativo
// via `redirect`, e a estrutura de ShellRoute para o BottomNavigationBar.
//
// A arquitetura Feature-First é respeitada: cada feature possui sua própria
// pasta com data/domain/presentation. O router apenas referencia as telas
// (presentation layer) de cada feature, sem criar acoplamento entre domínios.
//
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import das telas
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/clients/presentation/client_detail_screen.dart';
import '../../features/clients/presentation/client_list_screen.dart';
import '../../features/contracts/presentation/contract_detail_screen.dart';
import '../../features/contracts/presentation/contract_list_screen.dart';
import '../../features/contracts/presentation/contract_step1_screen.dart';
import '../../features/contracts/presentation/contract_step2_screen.dart';
import '../../features/contracts/presentation/contract_step3_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/products/presentation/product_detail_screen.dart';
import '../../features/products/presentation/product_list_screen.dart';
import '../../features/proposals/presentation/proposal_detail_screen.dart';
import '../../features/proposals/presentation/proposal_list_screen.dart';
import '../../features/proposals/presentation/proposal_public_screen.dart';
import '../../features/proposals/presentation/proposal_step1_screen.dart';
import '../../features/proposals/presentation/proposal_step2_screen.dart';
import '../../features/proposals/presentation/proposal_step3_screen.dart';
import '../../features/providers/presentation/provider_edit_screen.dart';
import '../../features/providers/presentation/provider_list_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/signatures/presentation/signature_public_screen.dart';
import '../services/auth_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  // Listenable para notificar o router sobre mudanças no authState sem recriar o GoRouter
  final authStateNotifier = ValueNotifier<bool>(false);

  ref.listen(authServiceProvider, (previous, next) {
    authStateNotifier.value = !authStateNotifier.value;
  });

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    refreshListenable: authStateNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authServiceProvider);
      
      // Se a autenticação estiver carregando (ex: durante login), não redireciona prematuramente
      if (authState.isLoading && authState.value == null) return null;

      final bool isAuthenticated = authState.value != null && !authState.hasError;
      final bool isGoingToLogin = state.matchedLocation == '/login';
      final bool isGoingToSplash = state.matchedLocation == '/splash';
      final bool isPublicSignature = state.matchedLocation.startsWith('/s/');
      final bool isPublicProposal = state.matchedLocation.startsWith('/p/');

      if (isGoingToSplash || isPublicSignature || isPublicProposal) return null;

      if (!isAuthenticated && !isGoingToLogin) return '/login';
      if (isAuthenticated && isGoingToLogin) return '/home';

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Página não encontrada')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go('/home'),
          child: const Text('Voltar ao Início'),
        ),
      ),
    ),
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/p/:shareToken',
        builder: (context, state) => ProposalPublicScreen(
          shareToken: state.pathParameters['shareToken']!,
        ),
      ),
      GoRoute(
        path: '/s/:shareToken',
        builder: (context, state) => SignaturePublicScreen(
          shareToken: state.pathParameters['shareToken']!,
        ),
      ),
      
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: <RouteBase>[
          GoRoute(path: '/home', builder: (context, state) => const HomeDashboardScreen()),
          GoRoute(path: '/clients', builder: (context, state) => const ClientListScreen()),
          GoRoute(path: '/proposals', builder: (context, state) => const ProposalListScreen()),
          GoRoute(path: '/contracts', builder: (context, state) => const ContractListScreen()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
        ],
      ),

      // Rotas filhas (fora do BottomNav, para cobrir tela inteira)
      GoRoute(path: '/clients/:id', builder: (context, state) => ClientDetailScreen(clientId: state.pathParameters['id']!)),
      
      GoRoute(path: '/providers', builder: (context, state) => const ProviderListScreen()),
      GoRoute(path: '/providers/:id/edit', builder: (context, state) => ProviderEditScreen(providerId: state.pathParameters['id']!)),
      
      GoRoute(path: '/products', builder: (context, state) => const ProductListScreen()),
      GoRoute(path: '/products/:id', builder: (context, state) => ProductDetailScreen(productId: state.pathParameters['id']!)),
      
      GoRoute(path: '/proposals/new/step1', builder: (context, state) => const ProposalStep1Screen()),
      GoRoute(path: '/proposals/new/step2', builder: (context, state) => const ProposalStep2Screen()),
      GoRoute(path: '/proposals/new/step3', builder: (context, state) => const ProposalStep3Screen()),
      GoRoute(path: '/proposals/:id', builder: (context, state) => ProposalDetailScreen(proposalId: state.pathParameters['id']!)),
      
      GoRoute(path: '/contracts/new/step1', builder: (context, state) => const ContractStep1Screen()),
      GoRoute(path: '/contracts/new/step2', builder: (context, state) => const ContractStep2Screen()),
      GoRoute(path: '/contracts/new/step3', builder: (context, state) => const ContractStep3Screen()),
      GoRoute(path: '/contracts/:id', builder: (context, state) => ContractDetailScreen(contractId: state.pathParameters['id']!)),
    ],
  );
});

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    final int currentIndex = switch (location) {
      String l when l.startsWith('/home') => 0,
      String l when l.startsWith('/clients') => 1,
      String l when l.startsWith('/proposals') => 2,
      String l when l.startsWith('/contracts') => 3,
      String l when l.startsWith('/settings') => 4,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          final String route = switch (index) {
            0 => '/home',
            1 => '/clients',
            2 => '/proposals',
            3 => '/contracts',
            4 => '/settings',
            _ => '/home',
          };
          context.go(route);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Clientes'),
          NavigationDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description), label: 'Propostas'),
          NavigationDestination(icon: Icon(Icons.article_outlined), selectedIcon: Icon(Icons.article), label: 'Contratos'),
          NavigationDestination(icon: Icon(Icons.menu), selectedIcon: Icon(Icons.menu_open), label: 'Menu'),
        ],
      ),
    );
  }
}
