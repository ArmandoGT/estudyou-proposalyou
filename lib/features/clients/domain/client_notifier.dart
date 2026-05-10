// lib/features/clients/domain/client_notifier.dart

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/services/active_provider_context.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/dtos/client_dto.dart';
import '../../../data/repositories/client_repository.dart';
import 'client_state.dart';

part 'client_notifier.g.dart';

// ─────────────────────────────────────────────────────────────
// Lista de Clientes
// ─────────────────────────────────────────────────────────────

@riverpod
class ClientListNotifier extends _$ClientListNotifier {
  Timer? _debounce;

  @override
  ClientListState build() {
    ref.watch(providerScopeModeProvider);
    ref.onDispose(() => _debounce?.cancel());
    _loadClients();
    return const ClientListLoading();
  }

  Future<void> _loadClients({bool refreshRemote = false}) async {
    try {
      final repo = ref.read(clientRepositoryProvider);
      final scope = await ref.read(providerScopeModeProvider.future);
      final activeProviderId = scope == ProviderScopeMode.all
          ? null
          : await ref.read(activeProviderIdProvider.future);
      final clients = await repo.getAll(
        providerId: activeProviderId,
        refreshRemote: refreshRemote,
      );
      final currentState = state;
      final filter = currentState is ClientListLoaded ? currentState.activeFilter : null;
      final query = currentState is ClientListLoaded ? currentState.searchQuery : '';
      final filteredClients = filter == null ? clients : _applyFilter(clients, filter);
      state = ClientListLoaded(
        clients: filteredClients,
        activeFilter: filter,
        searchQuery: query,
      );
    } on AppException catch (e) {
      state = ClientListError(e.toUserMessage());
    }
  }

  /// Busca com debounce de 300ms.
  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(clientRepositoryProvider);
        final scope = await ref.read(providerScopeModeProvider.future);
        final activeProviderId = scope == ProviderScopeMode.all
            ? null
            : await ref.read(activeProviderIdProvider.future);
        final currentState = state;
        final filter = currentState is ClientListLoaded ? currentState.activeFilter : null;

        List<ClientDto> results;
        if (query.isEmpty) {
          results = await repo.getAll(providerId: activeProviderId);
        } else {
          results = await repo.search(query, providerId: activeProviderId);
        }

        // Aplica filtro PF/PJ local
        if (filter != null) {
          results = _applyFilter(results, filter);
        }

        state = ClientListLoaded(clients: results, activeFilter: filter, searchQuery: query);
      } on AppException catch (e) {
        state = ClientListError(e.toUserMessage());
      }
    });
  }

  /// Filtra por tipo PF (11 dígitos) ou PJ (14 dígitos).
  void filterByType(String? type) {
    final currentState = state;
    if (currentState is! ClientListLoaded) return;

    var clients = currentState.clients;
    if (type != null) {
      clients = _applyFilter(clients, type);
    }
    state = ClientListLoaded(
      clients: clients, activeFilter: type, searchQuery: currentState.searchQuery,
    );
    // Re-busca para obter lista não filtrada, depois filtra
    if (currentState.searchQuery.isNotEmpty) {
      search(currentState.searchQuery);
    } else {
      _loadClients();
    }
  }

  List<ClientDto> _applyFilter(List<ClientDto> clients, String type) {
    return clients.where((c) {
      final digits = c.cpfCnpj.replaceAll(RegExp(r'\D'), '');
      if (type == 'pf') return digits.length == 11;
      if (type == 'pj') return digits.length == 14;
      return true;
    }).toList();
  }

  /// Soft-delete (arquivar).
  Future<void> archive(String id) async {
    try {
      final repo = ref.read(clientRepositoryProvider);
      await repo.archive(id);
      _loadClients();
    } on AppException catch (e) {
      state = ClientListError(e.toUserMessage());
    }
  }

  Future<void> restore(String id) async {
    try {
      final repo = ref.read(clientRepositoryProvider);
      await repo.restore(id);
      _loadClients();
    } on AppException catch (e) {
      state = ClientListError(e.toUserMessage());
    }
  }

  Future<void> refresh() => _loadClients(refreshRemote: true);
}

@riverpod
class ArchivedClientListNotifier extends _$ArchivedClientListNotifier {
  Timer? _debounce;

  @override
  ClientListState build() {
    ref.watch(activeProviderIdProvider);
    ref.onDispose(() => _debounce?.cancel());
    _loadArchivedClients();
    return const ClientListLoading();
  }

  Future<void> _loadArchivedClients() async {
    try {
      final repo = ref.read(clientRepositoryProvider);
      final activeProviderId = await ref.read(activeProviderIdProvider.future);
      final clients = await repo.getArchived(providerId: activeProviderId);
      state = ClientListLoaded(clients: clients);
    } on AppException catch (e) {
      state = ClientListError(e.toUserMessage());
    }
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(clientRepositoryProvider);
        final activeProviderId = await ref.read(activeProviderIdProvider.future);
        final clients = await repo.getArchived(providerId: activeProviderId, limit: 100);
        final normalized = query.trim().toLowerCase();
        final filtered = normalized.isEmpty
            ? clients
            : clients.where((client) {
                final nome = client.nome.toLowerCase();
                final documento = client.cpfCnpj.toLowerCase();
                return nome.contains(normalized) || documento.contains(normalized);
              }).toList();
        state = ClientListLoaded(clients: filtered, searchQuery: query);
      } on AppException catch (e) {
        state = ClientListError(e.toUserMessage());
      }
    });
  }

  Future<void> restore(String id) async {
    try {
      final repo = ref.read(clientRepositoryProvider);
      await repo.restore(id);
      _loadArchivedClients();
    } on AppException catch (e) {
      state = ClientListError(e.toUserMessage());
    }
  }

  Future<void> refresh() => _loadArchivedClients();
}

@riverpod
Future<ClientDeletionPreview> clientDeletionPreview(Ref ref, String clientId) async {
  final repo = ref.read(clientRepositoryProvider);
  final impact = await repo.getDeletionImpact(clientId);

  final options = <ClientDeletionOption>[];

  if (impact.contractsCount == 0 && impact.proposalsCount == 0) {
    options.add(
      const ClientDeletionOption(
        key: 'clientOnly',
        title: 'Excluir apenas cliente',
        description: 'Remove somente o cadastro do cliente.',
      ),
    );
  }

  if (impact.contractsCount > 0 && impact.proposalsCount == 0) {
    options.add(
      const ClientDeletionOption(
        key: 'clientWithContracts',
        title: 'Excluir cliente e contratos vinculados',
        description: 'Remove o cliente junto com os contratos vinculados.',
      ),
    );
  }

  if (impact.contractsCount > 0 || impact.proposalsCount > 0) {
    options.add(
      const ClientDeletionOption(
        key: 'clientWithContractsAndProposals',
        title: 'Excluir cliente, contratos e propostas vinculados',
        description: 'Remove o cliente e todos os vínculos comerciais relacionados.',
      ),
    );
  }

  return ClientDeletionPreview(
    contractsCount: impact.contractsCount,
    proposalsCount: impact.proposalsCount,
    options: options,
  );
}

// ─────────────────────────────────────────────────────────────
// Detalhe / Edição de Cliente
// ─────────────────────────────────────────────────────────────

@riverpod
class ClientDetailNotifier extends _$ClientDetailNotifier {
  @override
  ClientDetailState build(String? clientId) {
    if (clientId == null || clientId == 'new') {
      return ClientDetailLoaded(
        client: ClientDto(
          id: '', providerId: '', nome: '', cpfCnpj: '',
          createdAt: DateTime.now(), updatedAt: DateTime.now(),
        ),
        isNew: true,
      );
    }
    _loadClient(clientId);
    return const ClientDetailLoading();
  }

  Future<void> _loadClient(String id) async {
    try {
      final repo = ref.read(clientRepositoryProvider);
      final client = await repo.getById(id);
      state = ClientDetailLoaded(client: client);
    } on AppException catch (e) {
      state = ClientDetailError(e.toUserMessage());
    }
  }

  /// Salva (insert ou update) o cliente repassando a resposta (sucesso/erro) para a UI.
  Future<void> saveClient(ClientDto dto) async {
    final currentState = state;
    if (currentState is! ClientDetailLoaded) return;

    state = ClientDetailLoaded(client: dto, isNew: currentState.isNew, isSaving: true);

    try {
      final repo = ref.read(clientRepositoryProvider);
      
      // Injeta o ID do provider ativo da sessão
      final authService = ref.read(authServiceProvider.notifier);
      final activeProviderId = await authService.getActiveProviderId();
      
      final dtoToSave = dto.copyWith(providerId: activeProviderId);

      ClientDto saved;
      if (currentState.isNew) {
        final json = dtoToSave.toJson()..remove('id');
        saved = await repo.create(ClientDto.fromJson({
          ...json,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        }));
      } else {
        saved = await repo.update(dtoToSave);
      }
      
      // Em caso de sucesso, atualizamos o estado
      state = ClientDetailSaved(saved);
      
    } catch (e) {
      // ignore: avoid_print
      print('Erro crítico ao salvar cliente no Supabase: $e');
      
      // Restaura o estado para permitir nova tentativa
      state = ClientDetailLoaded(client: dto, isNew: currentState.isNew, isSaving: false);
      
      // Lança a exceção novamente para que a camada de Apresentação (UI) a intercepte
      throw Exception('Não foi possível salvar o cliente. Detalhes: $e');
    }
  }

  /// Busca endereço via ViaCEP.
  Future<Map<String, dynamic>?> fetchAddressByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'\D'), '');
    if (cleanCep.length != 8) return null;

    try {
      final response = await http.get(
        Uri.parse('https://viacep.com.br/ws/$cleanCep/json/'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data.containsKey('erro')) return null;
        return {
          'cep': cleanCep,
          'logradouro': data['logradouro'],
          'bairro': data['bairro'],
          'cidade': data['localidade'],
          'uf': data['uf'],
        };
      }
    } catch (_) {
      // Falha silenciosa — campo manual disponível
    }
    return null;
  }
}
