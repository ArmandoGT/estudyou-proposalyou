// lib/features/auth/presentation/splash_screen.dart
//
// Tela de Splash / Onboarding com 3 slides.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/auth_notifier.dart';
import '../domain/auth_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Verifica onboarding após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashProvider.notifier).checkOnboarding();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen(splashProvider, (_, state) {
      if (state is SplashNavigateToLogin) {
        context.go('/login');
      }
    });

    final state = ref.watch(splashProvider);

    if (state is SplashLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.description_outlined, size: 80, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text('ProposalYou', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    // Onboarding com 3 slides
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: const [
                  _OnboardingSlide(
                    icon: Icons.article_outlined,
                    title: 'Crie Propostas',
                    description: 'Gere propostas comerciais profissionais em minutos com modelos personalizáveis.',
                  ),
                  _OnboardingSlide(
                    icon: Icons.handshake_outlined,
                    title: 'Feche Contratos',
                    description: 'Transforme propostas aprovadas em contratos com assinatura digital.',
                  ),
                  _OnboardingSlide(
                    icon: Icons.draw_outlined,
                    title: 'Assine Digitalmente',
                    description: 'Envie links de assinatura para seus clientes. Seguro, rápido e legal.',
                  ),
                ],
              ),
            ),
            // Indicadores de página
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == i ? 24 : 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == i
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                  ),
                )),
              ),
            ),
            // Botão "Começar"
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      ref.read(splashProvider.notifier).completeOnboarding();
                    }
                  },
                  child: Text(_currentPage < 2 ? 'Próximo' : 'Começar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120, color: theme.colorScheme.primary),
          const SizedBox(height: 32),
          Text(title, style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
