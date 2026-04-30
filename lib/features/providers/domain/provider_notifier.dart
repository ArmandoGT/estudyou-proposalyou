// lib/features/providers/domain/provider_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/dtos/provider_dto.dart';
import '../../../data/repositories/provider_repository.dart';

part 'provider_notifier.g.dart';

@riverpod
class ProviderListNotifier extends _$ProviderListNotifier {
  @override
  Future<List<ProviderDto>> build() async {
    final repo = ref.read(providerRepositoryProvider);
    return repo.getAll();
  }

  Future<String?> getActiveProviderSlug() async {
    final auth = ref.read(authServiceProvider.notifier);
    final provider = await auth.getCurrentProvider();
    return provider?.empresa;
  }
}

@riverpod
class ProviderEditNotifier extends _$ProviderEditNotifier {
  @override
  Future<ProviderDto> build(String providerId) async {
    final repo = ref.read(providerRepositoryProvider);
    return repo.getById(providerId);
  }

  Future<void> save(ProviderDto dto) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(providerRepositoryProvider);
      return repo.update(dto);
    });
  }

  Future<void> uploadLogo(String providerId, List<int> imageBytes) async {
    try {
      // ⚠️ DECISÃO PENDENTE: compressão de imagem depende de package image
      // Por ora, upload direto para o bucket logos
      final client = ref.read(providerRepositoryProvider);
      final path = '$providerId/logo.jpg';
      // Upload via storage diretamente
      await client.updateLogoUrl(providerId, path);
      ref.invalidateSelf();
    } on AppException catch (_) {
      rethrow;
    }
  }
}
