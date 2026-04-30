// lib/features/clients/domain/client_state.dart

import '../../../data/dtos/client_dto.dart';

/// Estado da lista de clientes.
sealed class ClientListState {
  const ClientListState();
}

final class ClientListLoading extends ClientListState {
  const ClientListLoading();
}

final class ClientListLoaded extends ClientListState {
  final List<ClientDto> clients;
  final String? activeFilter; // null | 'pf' | 'pj'
  final String searchQuery;

  const ClientListLoaded({
    required this.clients,
    this.activeFilter,
    this.searchQuery = '',
  });
}

final class ClientListError extends ClientListState {
  final String message;
  const ClientListError(this.message);
}

/// Estado do detalhe/edição de cliente.
sealed class ClientDetailState {
  const ClientDetailState();
}

final class ClientDetailLoading extends ClientDetailState {
  const ClientDetailLoading();
}

final class ClientDetailLoaded extends ClientDetailState {
  final ClientDto client;
  final bool isNew;
  final bool isSaving;

  const ClientDetailLoaded({
    required this.client,
    this.isNew = false,
    this.isSaving = false,
  });
}

final class ClientDetailSaved extends ClientDetailState {
  final ClientDto client;
  const ClientDetailSaved(this.client);
}

final class ClientDetailError extends ClientDetailState {
  final String message;
  const ClientDetailError(this.message);
}
