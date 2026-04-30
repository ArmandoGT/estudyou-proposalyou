// lib/features/settings/presentation/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/auth_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Meu Perfil'),
            subtitle: const Text('Editar dados da conta'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Meus Prestadores'),
            subtitle: const Text('Gerenciar marcas e logos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/providers'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Produtos e Serviços'),
            subtitle: const Text('Gerenciar catálogo e preços'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/products'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: const Text('Segurança'),
            subtitle: const Text('Biometria e senhas'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: theme.colorScheme.error),
            title: Text('Sair', style: TextStyle(color: theme.colorScheme.error)),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('Sair do sistema?'),
                  content: const Text('Você precisará fazer login novamente.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
                      onPressed: () => Navigator.pop(c, true),
                      child: const Text('Sair'),
                    ),
                  ],
                ),
              );
              
              if (confirm == true) {
                await ref.read(authServiceProvider.notifier).signOut();
                if (context.mounted) context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
