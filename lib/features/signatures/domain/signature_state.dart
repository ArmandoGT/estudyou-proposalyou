// lib/features/signatures/domain/signature_state.dart

import '../../../data/dtos/contract_dto.dart';

sealed class SignatureState {
  const SignatureState();
}

final class SignatureLoading extends SignatureState {
  const SignatureLoading();
}

final class SignatureLoaded extends SignatureState {
  final ContractDto contract;
  final bool isSigning;

  const SignatureLoaded({required this.contract, this.isSigning = false});
}

final class SignatureSuccess extends SignatureState {
  final ContractDto contract;
  final String certificateUrl;

  const SignatureSuccess(this.contract, this.certificateUrl);
}

final class SignatureAlreadySigned extends SignatureState {
  final ContractDto contract;
  final String message;

  const SignatureAlreadySigned(this.contract, this.message);
}

final class SignatureInvalidLink extends SignatureState {
  final String message;

  const SignatureInvalidLink(this.message);
}

final class SignatureError extends SignatureState {
  final String message;
  const SignatureError(this.message);
}
