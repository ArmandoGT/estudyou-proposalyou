// lib/features/proposals/domain/proposal_notifier.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/active_provider_context.dart';
import '../../../core/services/auth_service.dart';
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
    ref.watch(providerScopeModeProvider);
    ref.onDispose(() => _debounce?.cancel());
    _loadProposals();
    return const ProposalListLoading();
  }

  Future<void> _loadProposals({bool refreshRemote = false}) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      final scope = await ref.read(providerScopeModeProvider.future);
      final activeProviderId = scope == ProviderScopeMode.all
          ? null
          : await ref.read(activeProviderIdProvider.future);
      final proposals = await repo.getAll(
        providerId: activeProviderId,
        refreshRemote: refreshRemote,
      );
      final currentState = state;
      final filter = currentState is ProposalListLoaded ? currentState.activeStatusFilter : null;
      final query = currentState is ProposalListLoaded ? currentState.searchQuery : '';
      final filteredProposals = filter == null ? proposals : _applyFilter(proposals, filter);
      state = ProposalListLoaded(
        proposals: filteredProposals,
        activeStatusFilter: filter,
        searchQuery: query,
      );
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
        final scope = await ref.read(providerScopeModeProvider.future);
        final activeProviderId = scope == ProviderScopeMode.all
            ? null
            : await ref.read(activeProviderIdProvider.future);
        final currentState = state;
        final filter = currentState is ProposalListLoaded ? currentState.activeStatusFilter : null;

        List<ProposalDto> results;
        if (query.isEmpty) {
          results = await repo.getAll(providerId: activeProviderId);
        } else {
          results = await repo.search(query, providerId: activeProviderId);
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

  Future<void> archive(String id) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      await repo.archive(id);
      _loadProposals();
    } on AppException catch (e) {
      state = ProposalListError(e.toUserMessage());
    }
  }

  Future<void> deletePermanently(String id) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      await repo.deletePermanently(id);
      _loadProposals();
    } on AppException catch (e) {
      state = ProposalListError(e.toUserMessage());
    }
  }

  Future<void> refresh() => _loadProposals(refreshRemote: true);
}

@riverpod
class ArchivedProposalListNotifier extends _$ArchivedProposalListNotifier {
  Timer? _debounce;

  @override
  ProposalListState build() {
    ref.watch(providerScopeModeProvider);
    ref.onDispose(() => _debounce?.cancel());
    _loadArchivedProposals();
    return const ProposalListLoading();
  }

  Future<void> _loadArchivedProposals({bool refreshRemote = false}) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      final scope = await ref.read(providerScopeModeProvider.future);
      final activeProviderId = scope == ProviderScopeMode.all
          ? null
          : await ref.read(activeProviderIdProvider.future);
      final proposals = await repo.getAll(
        providerId: activeProviderId,
        refreshRemote: refreshRemote,
        archivedOnly: true,
      );
      final currentState = state;
      final filter = currentState is ProposalListLoaded ? currentState.activeStatusFilter : null;
      final query = currentState is ProposalListLoaded ? currentState.searchQuery : '';
      final filtered = filter == null ? proposals : _applyFilter(proposals, filter);
      state = ProposalListLoaded(
        proposals: filtered,
        activeStatusFilter: filter,
        searchQuery: query,
      );
    } on AppException catch (e) {
      state = ProposalListError(e.toUserMessage());
    }
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(proposalRepositoryProvider);
        final scope = await ref.read(providerScopeModeProvider.future);
        final activeProviderId = scope == ProviderScopeMode.all
            ? null
            : await ref.read(activeProviderIdProvider.future);
        final currentState = state;
        final filter = currentState is ProposalListLoaded ? currentState.activeStatusFilter : null;

        List<ProposalDto> results;
        if (query.isEmpty) {
          results = await repo.getAll(providerId: activeProviderId, archivedOnly: true);
        } else {
          results = await repo.search(query, providerId: activeProviderId, archivedOnly: true);
        }

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
      proposals: proposals,
      activeStatusFilter: status,
      searchQuery: currentState.searchQuery,
    );

    if (currentState.searchQuery.isNotEmpty) {
      search(currentState.searchQuery);
    } else {
      _loadArchivedProposals();
    }
  }

  List<ProposalDto> _applyFilter(List<ProposalDto> list, String status) {
    return list.where((p) => p.status == status).toList();
  }

  Future<void> restore(String id) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      await repo.restore(id);
      _loadArchivedProposals();
    } on AppException catch (e) {
      state = ProposalListError(e.toUserMessage());
    }
  }

  Future<void> deletePermanently(String id) async {
    try {
      final repo = ref.read(proposalRepositoryProvider);
      await repo.deletePermanently(id);
      _loadArchivedProposals();
    } on AppException catch (e) {
      state = ProposalListError(e.toUserMessage());
    }
  }

  Future<void> refresh() => _loadArchivedProposals(refreshRemote: true);
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
      id: null, providerId: '', clientId: '',
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
    try {
      final repo = ref.read(proposalRepositoryProvider);
      
      // Injeta o provedor ativo caso esteja nulo ou vazio (essencial para RLS)
      var draftToSave = finalDraft;
      if (draftToSave.providerId == null || draftToSave.providerId!.isEmpty) {
        final authService = ref.read(authServiceProvider.notifier);
        final activeProviderId = await authService.getActiveProviderId();
        draftToSave = draftToSave.copyWith(providerId: activeProviderId);
      }

      ProposalDto saved;
      if (isNew) {
        final json = draftToSave.toJson()..remove('id');
        saved = await repo.create(ProposalDto.fromJson({
          ...json,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }));
      } else {
        saved = await repo.update(finalDraft);
      }
      state = ProposalWizardSuccess(saved);
    } catch (e) {
      // Retorna ao estado anterior com os dados intactos
      state = ProposalWizardStep3(finalDraft);
      throw Exception('Erro ao gerar proposta: $e');
    }
  }

  void reset() {
    state = _createInitialState();
  }
}
