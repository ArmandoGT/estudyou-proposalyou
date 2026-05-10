// lib/features/contracts/domain/contract_notifier.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/dtos/contract_dto.dart';
import '../../../data/dtos/proposal_dto.dart';
import '../../../data/repositories/contract_repository.dart';
import 'contract_state.dart';

part 'contract_notifier.g.dart';

// ─────────────────────────────────────────────────────────────
// Lista de Contratos
// ─────────────────────────────────────────────────────────────

@riverpod
class ContractListNotifier extends _$ContractListNotifier {
  Timer? _debounce;

  @override
  ContractListState build() {
    ref.onDispose(() => _debounce?.cancel());
    _loadContracts();
    return const ContractListLoading();
  }

  Future<void> _loadContracts() async {
    try {
      final repo = ref.read(contractRepositoryProvider);
      final contracts = await repo.getAll();
      state = ContractListLoaded(contracts: contracts);
    } on AppException catch (e) {
      state = ContractListError(e.toUserMessage());
    }
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(contractRepositoryProvider);
        final currentState = state;
        final filter = currentState is ContractListLoaded ? currentState.activeStatusFilter : null;

        List<ContractDto> results;
        if (query.isEmpty) {
          results = await repo.getAll();
        } else {
          results = await repo.search(query);
        }

        if (filter != null) {
          results = _applyFilter(results, filter);
        }

        state = ContractListLoaded(contracts: results, activeStatusFilter: filter, searchQuery: query);
      } on AppException catch (e) {
        state = ContractListError(e.toUserMessage());
      }
    });
  }

  void filterByStatus(String? status) {
    final currentState = state;
    if (currentState is! ContractListLoaded) return;

    var contracts = currentState.contracts;
    if (status != null) {
      contracts = _applyFilter(contracts, status);
    }
    state = ContractListLoaded(
      contracts: contracts, activeStatusFilter: status, searchQuery: currentState.searchQuery,
    );

    if (currentState.searchQuery.isNotEmpty) {
      search(currentState.searchQuery);
    } else {
      _loadContracts();
    }
  }

  List<ContractDto> _applyFilter(List<ContractDto> list, String status) {
    return list.where((c) => c.status == status).toList();
  }

  Future<void> refresh() => _loadContracts();
}

// ─────────────────────────────────────────────────────────────
// Detalhes do Contrato
// ─────────────────────────────────────────────────────────────

@riverpod
class ContractDetailNotifier extends _$ContractDetailNotifier {
  @override
  ContractDetailState build(String contractId) {
    _load(contractId);
    return const ContractDetailLoading();
  }

  Future<void> _load(String id) async {
    try {
      final repo = ref.read(contractRepositoryProvider);
      final contract = await repo.getById(id);
      state = ContractDetailLoaded(contract);
    } on AppException catch (e) {
      state = ContractDetailError(e.toUserMessage());
    }
  }

  Future<void> refresh() => _load(contractId);

  Future<void> sendForSignature() async {
    final currentState = state;
    if (currentState is! ContractDetailLoaded) return;

    try {
      final repo = ref.read(contractRepositoryProvider);
      await repo.updateStatus(currentState.contract.id, 'aguardando_assinatura');
      await _load(currentState.contract.id);
    } on AppException catch (e) {
      state = ContractDetailError(e.toUserMessage());
    }
  }
}

// ─────────────────────────────────────────────────────────────
// Wizard de Contrato
// ─────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class ContractWizardNotifier extends _$ContractWizardNotifier {
  @override
  ContractWizardState build() {
    return _createInitialState();
  }

  ContractWizardState _createInitialState() {
    final draft = ContractDto(
      id: '', providerId: '', clientId: '', textoFinal: '',
      status: 'minuta', linkAssinatura: '', hashDocumento: '',
      createdAt: DateTime.now(), updatedAt: DateTime.now(),
    );
    return ContractWizardStep1(draft);
  }
  
  void startWizard([ContractDto? initialDraft]) {
    if (initialDraft != null) {
      state = ContractWizardStep1(initialDraft);
    } else {
      state = _createInitialState();
    }
  }

  void selectProposal(ProposalDto proposal, ContractDto currentDraft) {
    final newDraft = currentDraft.copyWith(
      proposalId: proposal.id,
      clientId: proposal.clientId,
      providerId: proposal.providerId ?? currentDraft.providerId,
      textoFinal: '<p>Contrato referente à proposta aprovada.</p>',
    );
    state = ContractWizardStep1(newDraft, selectedProposal: proposal);
  }

  void startFromProposal(ProposalDto proposal) {
    final draft = ContractDto(
      id: '',
      providerId: proposal.providerId ?? '',
      clientId: proposal.clientId ?? '',
      proposalId: proposal.id,
      textoFinal: '<p>Contrato referente à proposta aprovada.</p>',
      status: 'minuta',
      linkAssinatura: '',
      hashDocumento: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    state = ContractWizardStep2(draft, selectedProposal: proposal);
  }

  void goToStep(int step, ContractDto draft, {ProposalDto? proposal}) {
    if (step == 1) state = ContractWizardStep1(draft, selectedProposal: proposal);
    if (step == 2) state = ContractWizardStep2(draft, selectedProposal: proposal);
    if (step == 3) state = ContractWizardStep3(draft, selectedProposal: proposal);
  }

  Future<void> save(ContractDto finalDraft, {bool isNew = true, ProposalDto? proposal}) async {
    state = const ContractWizardSaving();
    try {
      final repo = ref.read(contractRepositoryProvider);
      var draftToSave = finalDraft;
      if (draftToSave.providerId.isEmpty) {
        final authService = ref.read(authServiceProvider.notifier);
        final activeProviderId = await authService.getActiveProviderId();
        draftToSave = draftToSave.copyWith(providerId: activeProviderId ?? '');
      }

      ContractDto saved;
      if (isNew) {
        final json = draftToSave.toJson()..remove('id')..remove('pdf_url')..remove('hash_documento');
        saved = await repo.create(ContractDto.fromJson({
          ...json,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }));
      } else {
        saved = await repo.update(draftToSave);
      }
      state = ContractWizardSuccess(saved);
    } on AppException catch (e) {
      state = ContractWizardError(e.toUserMessage(), finalDraft);
      if (proposal != null) {
        state = ContractWizardStep3(finalDraft, selectedProposal: proposal);
      }
    }
  }

  void reset() {
    state = _createInitialState();
  }
}
