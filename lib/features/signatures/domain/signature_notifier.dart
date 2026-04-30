// lib/features/signatures/domain/signature_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../data/repositories/contract_repository.dart';
import '../../../data/repositories/signature_repository.dart';
import '../../../data/dtos/signature_dto.dart';
import 'signature_state.dart';

part 'signature_notifier.g.dart';

@riverpod
class SignatureNotifier extends _$SignatureNotifier {
  @override
  SignatureState build(String contractId) {
    _load(contractId);
    return const SignatureLoading();
  }

  Future<void> _load(String id) async {
    try {
      final repo = ref.read(contractRepositoryProvider);
      // Simula fetch publico sem auth
      final contract = await repo.getById(id);
      
      if (contract.status == 'assinado') {
        state = SignatureSuccess(contract, contract.pdfUrl ?? '');
      } else {
        state = SignatureLoaded(contract: contract);
      }
    } on AppException catch (e) {
      state = SignatureError(e.toUserMessage());
    }
  }

  Future<void> signContract({
    required String ip,
    required String userAgent,
    required List<int> signatureImageBytes,
  }) async {
    final currentState = state;
    if (currentState is! SignatureLoaded) return;

    state = SignatureLoaded(contract: currentState.contract, isSigning: true);

    try {
      final contractRepo = ref.read(contractRepositoryProvider);
      final sigRepo = ref.read(signatureRepositoryProvider);

      // 1. Gera ID pra assinatura
      final sigId = DateTime.now().millisecondsSinceEpoch.toString();

      // 2. Cria o registro de assinatura
      final sigDto = SignatureDto(
        id: sigId,
        contractId: currentState.contract.id,
        signatarioNome: currentState.contract.clienteNome ?? 'Cliente',
        ip: ip,
        signedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await sigRepo.signContract(dto: sigDto);

      // 3. Atualiza contrato para 'assinado'
      final updatedContract = currentState.contract.copyWith(
        status: 'assinado',
        hashDocumento: 'simulated_hash_$sigId',
        pdfUrl: 'https://app.estudyou.com.br/s/${currentState.contract.id}/certificate',
      );
      
      await contractRepo.update(updatedContract);

      state = SignatureSuccess(updatedContract, updatedContract.pdfUrl ?? '');
    } on AppException catch (e) {
      state = SignatureError(e.toUserMessage());
    }
  }
}
