// lib/features/home/presentation/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/dtos/provider_dto.dart';
import '../domain/home_notifier.dart';
import '../domain/home_state.dart';

final _dateFormat = DateFormat('dd/MM/yyyy');

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncState = ref.watch(homeDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ProposalYou'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ActiveProviderAvatar(
              provider: asyncState.whenOrNull(
                data: (state) => switch (state) {
                  HomeDashboardLoaded(:final activeProvider) => activeProvider,
                  _ => null,
                },
              ),
              fallbackColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
      body: asyncState.when(
        loading: () => const _DashboardSkeleton(),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (state) => switch (state) {
          HomeDashboardLoading() => const _DashboardSkeleton(),
          HomeDashboardError(:final message) => Center(child: Text(message)),
          HomeDashboardLoaded() => RefreshIndicator(
              onRefresh: () => ref.read(homeDashboardProvider.notifier).refresh(),
              child: _DashboardContent(state: state),
            ),
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final HomeDashboardLoaded state;
  const _DashboardContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(children: [
          Expanded(child: _MetricCard(
            icon: Icons.article_outlined, label: 'Pendentes',
            value: state.propostasPendentes.toString(),
            color: theme.colorScheme.tertiary,
          )),
          const SizedBox(width: 12),
          Expanded(child: _MetricCard(
            icon: Icons.check_circle_outline, label: 'Aprovadas',
            value: state.propostasAprovadas.toString(),
            color: Colors.green,
          )),
          const SizedBox(width: 12),
          Expanded(child: _MetricCard(
            icon: Icons.draw_outlined, label: 'Assinaturas',
            value: state.contratosAguardando.toString(),
            color: theme.colorScheme.error,
          )),
        ]),
        const SizedBox(height: 24),

        // Ações rápidas
        Text('Ações Rápidas', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.push('/proposals/new/step1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.article_outlined, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'Nova Proposta',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.push('/contracts/new/step1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.handshake_outlined, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'Novo Contrato',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.push('/clients/new'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add_outlined, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'Novo Cliente',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
        const SizedBox(height: 24),

        // Lista Recentes
        Text('Recentes', style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          'Últimas propostas e contratos atualizados.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        if (state.recentes.isEmpty)
          _EmptyState()
        else
          ...state.recentes.map((item) => _RecentItemCard(item: item)),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MetricCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold, color: color,
          )),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _RecentItemCard extends StatelessWidget {
  final RecentItem item;
  const _RecentItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isProposal = item.tipo == 'proposta';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isProposal
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.secondaryContainer,
          child: Icon(
            isProposal ? Icons.article_outlined : Icons.handshake_outlined,
            color: isProposal
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(item.clienteNome),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${isProposal ? "Proposta" : "Contrato"} • ${_dateFormat.format(item.updatedAt)}'),
            if (item.total != null)
              Text(
                NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(item.total),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        trailing: Chip(
          label: Text(item.status, style: const TextStyle(fontSize: 11)),
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
        onTap: () {
          if (isProposal) {
            context.push('/proposals/${item.id}');
          } else {
            context.push('/contracts/${item.id}');
          }
        },
      ),
    );
  }
}

class _ActiveProviderAvatar extends StatelessWidget {
  final ProviderDto? provider;
  final Color fallbackColor;

  const _ActiveProviderAvatar({
    required this.provider,
    required this.fallbackColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoUrl = provider?.logoUrl;
    final hasLogo = logoUrl != null && logoUrl.trim().isNotEmpty;

    return CircleAvatar(
      radius: 16,
      backgroundColor: provider == null
          ? fallbackColor
          : theme.colorScheme.primaryContainer,
      backgroundImage: hasLogo ? NetworkImage(logoUrl) : null,
      child: !hasLogo
          ? Icon(
              provider == null ? Icons.hourglass_empty : Icons.business,
              size: 18,
              color: provider == null
                  ? theme.colorScheme.onSurfaceVariant
                  : theme.colorScheme.onPrimaryContainer,
            )
          : null,
    );
  }
}

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < 2 ? 12 : 0),
                child: _SkeletonBox(height: 108, color: theme.colorScheme.surfaceContainerHighest),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _SkeletonBox(height: 20, width: 120, color: theme.colorScheme.surfaceContainerHighest),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < 2 ? 8 : 0),
                child: _SkeletonBox(height: 88, color: theme.colorScheme.surfaceContainerHighest),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _SkeletonBox(height: 20, width: 90, color: theme.colorScheme.surfaceContainerHighest),
        const SizedBox(height: 12),
        const _SkeletonRecentCard(),
        const SizedBox(height: 8),
        const _SkeletonRecentCard(),
        const SizedBox(height: 8),
        const _SkeletonRecentCard(),
      ],
    );
  }
}

class _SkeletonRecentCard extends StatelessWidget {
  const _SkeletonRecentCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SkeletonBox(height: 14, width: 140, color: theme.colorScheme.surfaceContainerHighest),
                  const SizedBox(height: 8),
                  _SkeletonBox(height: 12, width: 180, color: theme.colorScheme.surfaceContainerHighest),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _SkeletonBox(height: 28, width: 72, color: theme.colorScheme.surfaceContainerHighest),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double height;
  final double? width;
  final Color color;

  const _SkeletonBox({required this.height, required this.color, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(children: [
        Icon(Icons.inbox_outlined, size: 64, color: theme.colorScheme.outline),
        const SizedBox(height: 16),
        Text('Nenhuma atividade ainda.',
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.outline)),
        const SizedBox(height: 4),
        Text('Comece criando uma proposta.',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline)),
      ]),
    );
  }
}
