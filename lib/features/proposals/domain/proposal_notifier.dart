// lib/features/proposals/domain/proposal_notifier.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../data/dtos/proposal_dto.dart';
import '../../../data/repositories/proposal_repository.dart';
import 'proposal_state.dart';

part 'proposal_notifier.g.dart';

// ─────────────────────────────────────────────────────────────
// Lista de Propostas
// ─────────────────────────────────────────────────────────────

@riverpod
class ProposalListNotifier extends _$ProposalListNotifier {
  Timer? _debounce;

  @override
  ProposalListState build() {
    ref.onDispose(() => _debounce?.cancel());
    _loadProposals();
    return const ProposalListLoading();
  }

  Future<void> _loadProposals() async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      final proposals = await repo.getAll();
      state = ProposalListLoaded(proposals: proposals);
    } on AppException catch (e) {
      state = ProposalListError(e.toUserMessage());
    }
  }

  /// Busca com debounce.
  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(proposalRepositoryProvider);
        final currentState = state;
        final filter = currentState is ProposalListLoaded ? currentState.activeStatusFilter : null;

        List<ProposalDto> results;
        if (query.isEmpty) {
          results = await repo.getAll();
        } else {
          results = await repo.search(query);
        }

        // Aplica filtro local
        if (filter != null) {
          results = _applyFilter(results, filter);
        }

        state = ProposalListLoaded(proposals: results, activeStatusFilter: filter, searchQuery: query);
      } on AppException catch (e) {
        state = ProposalListError(e.toUserMessage());
      }
    });
  }

  void filterByStatus(String? status) {
    final currentState = state;
    if (currentState is! ProposalListLoaded) return;

    var proposals = currentState.proposals;
    if (status != null) {
      proposals = _applyFilter(proposals, status);
    }
    state = ProposalListLoaded(
      proposals: proposals, activeStatusFilter: status, searchQuery: currentState.searchQuery,
    );

    if (currentState.searchQuery.isNotEmpty) {
      search(currentState.searchQuery);
    } else {
      _loadProposals();
    }
  }

  List<ProposalDto> _applyFilter(List<ProposalDto> list, String status) {
    return list.where((p) => p.status == status).toList();
  }

  Future<void> refresh() => _loadProposals();
}

// ─────────────────────────────────────────────────────────────
// Detalhes da Proposta (Visualização)
// ─────────────────────────────────────────────────────────────

@riverpod
class ProposalDetailNotifier extends _$ProposalDetailNotifier {
  @override
  ProposalDetailState build(String proposalId) {
    _load(proposalId);
    return const ProposalDetailLoading();
  }

  Future<void> _load(String id) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      final proposal = await repo.getById(id);
      state = ProposalDetailLoaded(proposal);
    } on AppException catch (e) {
      state = ProposalDetailError(e.toUserMessage());
    }
  }
}

// ─────────────────────────────────────────────────────────────
// Wizard de Proposta (Criação/Edição)
// ─────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class ProposalWizardNotifier extends _$ProposalWizardNotifier {
  @override
  ProposalWizardState build() {
    return _createInitialState();
  }

  ProposalWizardState _createInitialState() {
    final draft = ProposalDto(
      id: '', providerId: '', clientId: '',
      itensJson: [], total: 0.0, status: 'rascunho', validade: null,
      createdAt: DateTime.now(), updatedAt: DateTime.now(),
    );
    return ProposalWizardStep1(draft);
  }

  void startWizard([ProposalDto? initialDraft]) {
    if (initialDraft != null) {
      state = ProposalWizardStep1(initialDraft);
    } else {
      state = _createInitialState();
    }
  }

  void updateDraft(ProposalDto draft) {
    final currentState = state;
    if (currentState is ProposalWizardStep1) {
      state = ProposalWizardStep1(draft);
    } else if (currentState is ProposalWizardStep2) {
      state = ProposalWizardStep2(draft);
    } else if (currentState is ProposalWizardStep3) {
      state = ProposalWizardStep3(draft);
    }
  }

  void goToStep(int step, ProposalDto currentDraft) {
    if (step == 1) state = ProposalWizardStep1(currentDraft);
    if (step == 2) state = ProposalWizardStep2(currentDraft);
    if (step == 3) state = ProposalWizardStep3(currentDraft);
  }

  Future<void> save(ProposalDto finalDraft, {bool isNew = true}) async {
    state = const ProposalWizardSaving();
    try {
      final repo = ref.read(proposalRepositoryProvider);
      ProposalDto saved;
      if (isNew) {
        final json = finalDraft.toJson()..remove('id');
        saved = await repo.create(ProposalDto.fromJson({
          ...json,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }));
      } else {
        saved = await repo.update(finalDraft);
      }
      state = ProposalWizardSuccess(saved);
    } on AppException catch (e) {
      state = ProposalWizardError(e.toUserMessage(), finalDraft);
    }
  }

  void reset() {
    state = _createInitialState();
  }
}
