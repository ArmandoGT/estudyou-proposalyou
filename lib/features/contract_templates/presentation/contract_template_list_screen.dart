import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/app_exception.dart';
import '../../../data/repositories/contract_template_repository.dart';

final contractTemplateListProvider = FutureProvider.autoDispose((ref) {
  return ref.read(contractTemplateRepositoryProvider).getAll();
});

class ContractTemplateListScreen extends ConsumerWidget {
  const ContractTemplateListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final templatesAsync = ref.watch(contractTemplateListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Modelos de Contrato')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/contract-templates/new'),
        icon: const Icon(Icons.add),
        label: const Text('Novo modelo'),
      ),
      body: templatesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          final message = error is AppException ? error.toUserMessage() : 'Não foi possível carregar os modelos.';
          return Center(child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(message, textAlign: TextAlign.center, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
          ));
        },
        data: (templates) {
          if (templates.isEmpty) {
            return Center(
              child: Text('Nenhum modelo de contrato cadastrado.', style: theme.textTheme.titleMedium),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: templates.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final template = templates[index];
              final previewText = template.corpoJson['conteudo']?.toString() ?? 'Sem conteúdo';
              return Card(
                child: ListTile(
                  onTap: () => context.push('/contract-templates/${template.id}'),
                  title: Text(template.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text('Provider: ${template.providerId}'),
                      Text('Versão: v${template.versao}'),
                      const SizedBox(height: 4),
                      Text(
                        previewText,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
