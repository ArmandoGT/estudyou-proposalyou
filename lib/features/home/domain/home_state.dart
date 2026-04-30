// lib/features/home/domain/home_state.dart

import '../../../data/dtos/proposal_dto.dart';
import '../../../data/dtos/contract_dto.dart';

/// Estado do Dashboard Home.
sealed class HomeDashboardState {
  const HomeDashboardState();
}

final class HomeDashboardLoading extends HomeDashboardState {
  const HomeDashboardLoading();
}

final class HomeDashboardLoaded extends HomeDashboardState {
  final int propostasPendentes;
  final int propostasAprovadas;
  final int contratosAguardando;
  final List<RecentItem> recentes;

  const HomeDashboardLoaded({
    required this.propostasPendentes,
    required this.propostasAprovadas,
    required this.contratosAguardando,
    required this.recentes,
  });
}

final class HomeDashboardError extends HomeDashboardState {
  final String message;
  const HomeDashboardError(this.message);
}

/// Item recente genérico (proposta ou contrato) para lista "Recentes".
class RecentItem {
  final String id;
  final String tipo; // 'proposta' | 'contrato'
  final String clienteNome;
  final String status;
  final double? total;
  final DateTime updatedAt;

  const RecentItem({
    required this.id,
    required this.tipo,
    required this.clienteNome,
    required this.status,
    this.total,
    required this.updatedAt,
  });

  factory RecentItem.fromProposal(ProposalDto p) => RecentItem(
        id: p.id, tipo: 'proposta', clienteNome: p.clienteNome ?? 'N/A',
        status: p.status, total: p.total, updatedAt: p.updatedAt,
      );

  factory RecentItem.fromContract(ContractDto c) => RecentItem(
        id: c.id, tipo: 'contrato', clienteNome: c.clienteNome ?? 'N/A',
        status: c.status, updatedAt: c.updatedAt,
      );
}
