// lib/features/providers/presentation/provider_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/auth_service.dart';
import '../domain/provider_notifier.dart';

class ProviderListScreen extends ConsumerWidget {
  const ProviderListScreen({super.key});

  static const _providerColors = {
    'estudyou': Color(0xFF1A73E8),
    'protseg': Color(0xFFE65100),
    'protuni': Color(0xFF2E7D32),
  };

  static const _providerIcons = {
    'estudyou': Icons.school,
    'protseg': Icons.security,
    'protuni': Icons.shield,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final asyncProviders = ref.watch(providerListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Empresas')),
      body: FutureBuilder<String?>(
        future: ref.read(providerListProvider.notifier).getActiveProviderSlug(),
        builder: (context, activeSnapshot) {
          final activeSlug = activeSnapshot.data;
          return asyncProviders.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erro: $e')),
            data: (providers) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                FilledButton.icon(
                  onPressed: () => context.push('/providers/new'),
                  icon: const Icon(Icons.add_business),
                  label: const Text('Nova empresa'),
                ),
                const SizedBox(height: 16),
                ...providers.map((p) {
                  final color = _providerColors[p.empresa] ?? theme.colorScheme.primary;
                  final isActive = p.empresa == activeSlug;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: isActive ? color.withValues(alpha: 0.08) : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: color, width: isActive ? 3 : 2),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: color.withValues(alpha: 0.15),
                        child: Icon(_providerIcons[p.empresa] ?? Icons.business, color: color),
                      ),
                      title: Row(
                        children: [
                          Expanded(child: Text(p.razaoSocial, style: theme.textTheme.titleMedium)),
                          if (isActive)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text('Ativa', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      subtitle: Text('CNPJ: ${p.cnpj}\n${p.empresa.toUpperCase()}'),
                      isThreeLine: true,
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'activate') {
                            await ref.read(authServiceProvider.notifier).switchActiveProvider(p.empresa);
                            ref.invalidate(providerListProvider);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${p.razaoSocial} agora é a empresa ativa.')),
                              );
                            }
                            return;
                          }
                          if (context.mounted) {
                            context.push('/providers/${p.id}/edit');
                          }
                        },
                        itemBuilder: (context) => [
                          if (!isActive)
                            const PopupMenuItem(value: 'activate', child: Text('Usar nesta sessão')),
                          const PopupMenuItem(value: 'edit', child: Text('Editar empresa')),
                        ],
                      ),
                      onTap: () => context.push('/providers/${p.id}/edit'),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
