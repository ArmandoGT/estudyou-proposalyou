// lib/features/proposals/domain/proposal_state.dart

import '../../../data/dtos/proposal_dto.dart';

/// Estado da lista de propostas.
sealed class ProposalListState {
  const ProposalListState();
}

final class ProposalListLoading extends ProposalListState {
  const ProposalListLoading();
}

final class ProposalListLoaded extends ProposalListState {
  final List<ProposalDto> proposals;
  final String? activeStatusFilter; // null | 'rascunho' | 'enviada' | 'aprovada' | 'recusada'
  final String searchQuery;

  const ProposalListLoaded({
    required this.proposals,
    this.activeStatusFilter,
    this.searchQuery = '',
  });
}

final class ProposalListError extends ProposalListState {
  final String message;
  const ProposalListError(this.message);
}

/// Estado do Wizard de criação de proposta.
sealed class ProposalWizardState {
  const ProposalWizardState();
}

final class ProposalWizardStep1 extends ProposalWizardState {
  final ProposalDto draft;
  const ProposalWizardStep1(this.draft);
}

final class ProposalWizardStep2 extends ProposalWizardState {
  final ProposalDto draft;
  const ProposalWizardStep2(this.draft);
}

final class ProposalWizardStep3 extends ProposalWizardState {
  final ProposalDto draft;
  const ProposalWizardStep3(this.draft);
}

final class ProposalWizardSaving extends ProposalWizardState {
  const ProposalWizardSaving();
}

final class ProposalWizardSuccess extends ProposalWizardState {
  final ProposalDto proposal;
  const ProposalWizardSuccess(this.proposal);
}

final class ProposalWizardError extends ProposalWizardState {
  final String message;
  final ProposalDto draft;
  const ProposalWizardError(this.message, this.draft);
}

/// Estado para visualização de detalhes (leitura apenas).
sealed class ProposalDetailState {
  const ProposalDetailState();
}

final class ProposalDetailLoading extends ProposalDetailState {
  const ProposalDetailLoading();
}

final class ProposalDetailLoaded extends ProposalDetailState {
  final ProposalDto proposal;
  const ProposalDetailLoaded(this.proposal);
}

final class ProposalDetailError extends ProposalDetailState {
  final String message;
  const ProposalDetailError(this.message);
}
