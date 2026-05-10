// lib/features/home/domain/home_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/auth_service.dart';
import '../../../data/dtos/provider_dto.dart';
import '../../../data/repositories/contract_repository.dart';
import '../../../data/repositories/proposal_repository.dart';
import 'home_state.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeDashboardNotifier extends _$HomeDashboardNotifier {
  @override
  Future<HomeDashboardState> build() async {
    return _loadDashboard();
  }

  Future<HomeDashboardState> _loadDashboard() async {
    try {
      final authService = ref.read(authServiceProvider.notifier);
      final proposalRepo = ref.read(proposalRepositoryProvider);
      final contractRepo = ref.read(contractRepositoryProvider);

      final results = await Future.wait([
        authService.getCurrentProvider(),
        proposalRepo.getCountByStatus(),
        contractRepo.countAguardandoAssinatura(),
        proposalRepo.getRecentItems(limit: 5),
        contractRepo.getAll(limit: 5),
      ]);

      final activeProvider = results[0] as ProviderDto?;
      final statusCounts = results[1] as Map<String, int>;
      final contratosAguardando = results[2] as int;
      final recentProposals = results[3] as List;
      final recentContracts = results[4] as List;

      // Mescla recentes e ordena por updated_at
      final recentes = [
        ...recentProposals.map((p) => RecentItem.fromProposal(p)),
        ...recentContracts.map((c) => RecentItem.fromContract(c)),
      ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return HomeDashboardLoaded(
        activeProvider: activeProvider,
        propostasPendentes: (statusCounts['rascunho'] ?? 0) +
            (statusCounts['enviada'] ?? 0),
        propostasAprovadas: statusCounts['aprovada'] ?? 0,
        contratosAguardando: contratosAguardando,
        recentes: recentes.take(5).toList(),
      );
    } catch (e) {
      return HomeDashboardError(e.toString());
    }
  }

  /// Recarrega o dashboard (pull-to-refresh).
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadDashboard);
  }
}
