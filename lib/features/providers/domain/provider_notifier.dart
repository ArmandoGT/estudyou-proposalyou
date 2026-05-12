// lib/features/providers/domain/provider_notifier.dart

import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/logo_storage_service.dart';
import '../../home/domain/home_notifier.dart';
import '../../../data/dtos/provider_dto.dart';
import '../../../data/repositories/provider_repository.dart';

part 'provider_notifier.g.dart';

@riverpod
class ProviderListNotifier extends _$ProviderListNotifier {
  @override
  Future<List<ProviderDto>> build() async {
    ref.watch(authServiceProvider);
    final repo = ref.read(providerRepositoryProvider);
    return repo.getAll(refreshRemote: true);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(providerRepositoryProvider);
      return repo.getAll(refreshRemote: true);
    });
  }

  Future<String?> getActiveProviderSlug() async {
    final auth = ref.read(authServiceProvider.notifier);
    final scope = await auth.getProviderScopeMode();
    if (scope == ProviderScopeMode.all) return null;
    final provider = await auth.getCurrentProvider();
    return provider?.empresa;
  }
}

@riverpod
class ProviderEditNotifier extends _$ProviderEditNotifier {
  @override
  Future<ProviderDto> build(String providerId) async {
    if (providerId == 'new') {
      return ProviderDto(
        id: '',
        empresa: '',
        razaoSocial: '',
        cnpj: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    final repo = ref.read(providerRepositoryProvider);
    return repo.getById(providerId);
  }

  Future<ProviderDto> save(ProviderDto dto, {required bool isNew}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(providerRepositoryProvider);
      if (isNew) {
        return repo.create(dto);
      }
      return repo.update(dto);
    });
    return state.requireValue;
  }

  Future<ProviderDto> uploadLogo({
    required String providerId,
    required Uint8List imageBytes,
    required String fileName,
    required String contentType,
  }) async {
    final previous = state.value;

    try {
      final logoStorage = ref.read(logoStorageServiceProvider);
      final repo = ref.read(providerRepositoryProvider);
      final publicUrl = await logoStorage.uploadLogo(
        bytes: imageBytes,
        providerId: providerId,
        fileName: fileName,
        contentType: contentType,
      );

      await repo.updateLogoUrl(providerId, publicUrl);
      final updated = await repo.getById(providerId);
      ref.invalidate(homeDashboardProvider);
      state = AsyncData(updated);
      return updated;
    } on AppException {
      if (previous != null) {
        state = AsyncData(previous);
      }
      rethrow;
    } catch (e, st) {
      if (previous != null) {
        state = AsyncData(previous);
      } else {
        state = AsyncError(e, st);
      }
      rethrow;
    }
  }
}
