import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dtos/provider_dto.dart';
import 'auth_service.dart';

final providerScopeModeProvider = FutureProvider<ProviderScopeMode>((ref) async {
  ref.watch(authServiceProvider);
  return ref.read(authServiceProvider.notifier).getProviderScopeMode();
});

final isAllProvidersScopeProvider = FutureProvider<bool>((ref) async {
  final scope = await ref.watch(providerScopeModeProvider.future);
  return scope == ProviderScopeMode.all;
});

final activeProviderIdProvider = FutureProvider<String?>((ref) async {
  ref.watch(authServiceProvider);
  return ref.read(authServiceProvider.notifier).getActiveProviderId();
});

final activeProviderProvider = FutureProvider<ProviderDto?>((ref) async {
  ref.watch(authServiceProvider);
  return ref.read(authServiceProvider.notifier).getCurrentProvider();
});
