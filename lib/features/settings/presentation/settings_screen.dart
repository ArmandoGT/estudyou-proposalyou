// lib/features/settings/presentation/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/auth_service.dart';
import '../../../data/dtos/provider_dto.dart';
import '../../../data/repositories/provider_repository.dart';
import '../../../features/clients/domain/client_notifier.dart';
import '../../../features/contracts/domain/contract_notifier.dart';
import '../../../features/home/domain/home_notifier.dart';
import '../../../features/products/domain/product_notifier.dart';
import '../../../features/proposals/domain/proposal_notifier.dart';
import '../../../shared/theme/theme_mode_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authServiceProvider);
    final themeMode = ref.watch(themeModeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erro: $error')),
        data: (user) => ListView(
          children: [
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(
                ((user?.userMetadata?['name'] as String?)?.trim().isNotEmpty ?? false)
                    ? user!.userMetadata!['name'] as String
                    : (user?.email ?? 'Usuário'),
              ),
              subtitle: Text(user?.email ?? 'Sem e-mail disponível'),
            ),
            const Divider(),
            FutureBuilder<(ProviderScopeMode, ProviderDto?)>(
              future: () async {
                final auth = ref.read(authServiceProvider.notifier);
                final scope = await auth.getProviderScopeMode();
                final provider = await auth.getCurrentProvider();
                return (scope, provider);
              }(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                final scope = data?.$1 ?? ProviderScopeMode.provider;
                final provider = data?.$2;
                return ListTile(
                  leading: const Icon(Icons.apartment),
                  title: const Text('Empresa ativa'),
                  subtitle: Text(
                    scope == ProviderScopeMode.all
                        ? 'Todas as Empresas'
                        : (provider?.razaoSocial ?? 'Escolha qual empresa você está usando agora'),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showProviderSelector(context, ref, scope, provider),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Tema'),
              subtitle: Text(_themeModeLabel(themeMode)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showThemeSelector(context, ref, themeMode),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meu Perfil'),
              subtitle: const Text('Dados da conta conectada'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Minhas empresas'),
              subtitle: const Text('Gerenciar dados, marca e identidade visual'),
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
              leading: const Icon(Icons.description_outlined),
              title: const Text('Modelos de Proposta'),
              subtitle: const Text('Criar e editar templates comerciais'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/proposal-templates'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('Modelos de Contrato'),
              subtitle: const Text('Criar e editar templates jurídicos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/contract-templates'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text('Segurança'),
              subtitle: const Text('Alterar senha da conta'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showPasswordDialog(context, ref),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notificações push'),
              subtitle: const Text('Em breve'),
              enabled: false,
            ),
            const Divider(),
            const AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: 'ProposalYou',
              applicationVersion: '1.0.0+1',
              applicationLegalese: 'ProposalYou',
              aboutBoxChildren: [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text('Gestão de propostas, contratos e assinaturas.'),
                ),
              ],
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
      ),
    );
  }

  static String _themeModeLabel(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'Claro',
        ThemeMode.dark => 'Escuro',
        ThemeMode.system => 'Usar sistema',
      };

  Future<void> _showThemeSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentMode,
  ) async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ThemeModeOptionTile(
              title: 'Usar sistema',
              selected: currentMode == ThemeMode.system,
              onTap: () => Navigator.pop(context, ThemeMode.system),
            ),
            _ThemeModeOptionTile(
              title: 'Claro',
              selected: currentMode == ThemeMode.light,
              onTap: () => Navigator.pop(context, ThemeMode.light),
            ),
            _ThemeModeOptionTile(
              title: 'Escuro',
              selected: currentMode == ThemeMode.dark,
              onTap: () => Navigator.pop(context, ThemeMode.dark),
            ),
          ],
        ),
      ),
    );

    if (selected != null) {
      await ref.read(themeModeControllerProvider.notifier).setThemeMode(selected);
    }
  }

  Future<void> _showProviderSelector(
    BuildContext context,
    WidgetRef ref,
    ProviderScopeMode currentScope,
    ProviderDto? currentProvider,
  ) async {
    List<ProviderDto> providers = const [];
    try {
      providers = await ref.read(providerRepositoryProvider).getAll();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível carregar as empresas: $error')),
        );
      }
    }
    if (!context.mounted) return;

    final selection = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Trocar empresa ativa'),
              subtitle: Text('Você pode alternar entre empresas sem sair da conta. Em Todas as Empresas, algumas criações ficam indisponíveis.'),
            ),
            ListTile(
              leading: const Icon(Icons.apartment_outlined),
              title: const Text('Todas as Empresas'),
              subtitle: const Text('Visualize dados sem segmentação por uma empresa específica.'),
              trailing: currentScope == ProviderScopeMode.all ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(context, '__all__'),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: providers
                    .map(
                      (provider) => ListTile(
                        leading: const Icon(Icons.business),
                        title: Text(provider.razaoSocial),
                        subtitle: Text(provider.empresa),
                        trailing: currentScope == ProviderScopeMode.provider && currentProvider?.id == provider.id
                            ? const Icon(Icons.check)
                            : null,
                        onTap: () => Navigator.pop(context, provider.empresa),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );

    if (selection == null) return;

    if (selection == '__all__') {
      await ref.read(authServiceProvider.notifier).switchToAllProviders();
    } else if (selection != currentProvider?.empresa || currentScope == ProviderScopeMode.all) {
      await ref.read(authServiceProvider.notifier).switchActiveProvider(selection);
    }

    ref.invalidate(homeDashboardProvider);
    ref.invalidate(productListProvider);
    ref.invalidate(clientListProvider);
    ref.invalidate(archivedClientListProvider);
    ref.invalidate(proposalListProvider);
    ref.invalidate(archivedProposalListProvider);
    ref.invalidate(contractListProvider);
  }

  Future<void> _showPasswordDialog(BuildContext context, WidgetRef ref) async {
    final formKey = GlobalKey<FormState>();
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    var isSaving = false;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Alterar senha'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: passwordCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Nova senha'),
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return 'Informe ao menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Confirmar nova senha'),
                    validator: (value) {
                      if (value != passwordCtrl.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSaving ? null : () => Navigator.pop(dialogContext),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        setState(() => isSaving = true);
                        try {
                          await ref.read(authServiceProvider.notifier).updatePassword(
                                passwordCtrl.text.trim(),
                              );
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Senha atualizada com sucesso.')),
                            );
                          }
                        } catch (error) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Não foi possível alterar a senha: $error')),
                            );
                          }
                        } finally {
                          if (dialogContext.mounted) {
                            setState(() => isSaving = false);
                          }
                        }
                      },
                child: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );

    passwordCtrl.dispose();
    confirmCtrl.dispose();
  }
}

class _ThemeModeOptionTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeModeOptionTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: onTap,
    );
  }
}
