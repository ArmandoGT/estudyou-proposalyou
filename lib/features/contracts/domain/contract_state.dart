// lib/features/contracts/domain/contract_state.dart

import '../../../data/dtos/contract_dto.dart';
import '../../../data/dtos/proposal_dto.dart';

/// Estado da lista de contratos.
sealed class ContractListState {
  const ContractListState();
}

final class ContractListLoading extends ContractListState {
  const ContractListLoading();
}

final class ContractListLoaded extends ContractListState {
  final List<ContractDto> contracts;
  final String? activeStatusFilter; // null | 'minuta' | 'aguardando_assinatura' | 'assinado' | 'cancelado'
  final String searchQuery;

  const ContractListLoaded({
    required this.contracts,
    this.activeStatusFilter,
    this.searchQuery = '',
  });
}

final class ContractListError extends ContractListState {
  final String message;
  const ContractListError(this.message);
}

/// Estado da visualização do contrato.
sealed class ContractDetailState {
  const ContractDetailState();
}

final class ContractDetailLoading extends ContractDetailState {
  const ContractDetailLoading();
}

final class ContractDetailLoaded extends ContractDetailState {
  final ContractDto contract;
  const ContractDetailLoaded(this.contract);
}

final class ContractDetailError extends ContractDetailState {
  final String message;
  const ContractDetailError(this.message);
}

/// Estado do Wizard de Contrato.
sealed class ContractWizardState {
  const ContractWizardState();
}

final class ContractWizardLoading extends ContractWizardState {
  const ContractWizardLoading();
}

final class ContractWizardStep1 extends ContractWizardState {
  final ContractDto draft;
  final ProposalDto? selectedProposal;
  const ContractWizardStep1(this.draft, {this.selectedProposal});
}

final class ContractWizardStep2 extends ContractWizardState {
  final ContractDto draft;
  final ProposalDto? selectedProposal;
  const ContractWizardStep2(this.draft, {this.selectedProposal});
}

final class ContractWizardSaving extends ContractWizardState {
  const ContractWizardSaving();
}

final class ContractWizardSuccess extends ContractWizardState {
  final ContractDto contract;
  const ContractWizardSuccess(this.contract);
}

final class ContractWizardError extends ContractWizardState {
  final String message;
  final ContractDto draft;
  const ContractWizardError(this.message, this.draft);
}
