// lib/features/signatures/domain/signature_notifier.dart

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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
  SignatureState build(String shareToken) {
    _load(shareToken);
    return const SignatureLoading();
  }

  Future<void> _load(String shareToken) async {
    try {
      final repo = ref.read(contractRepositoryProvider);
      final contract = await repo.getByShareToken(shareToken);

      if (contract == null) {
        state = const SignatureInvalidLink('Link de assinatura inválido ou expirado.');
        return;
      }

      if (contract.status == 'assinado') {
        state = SignatureAlreadySigned(
          contract,
          'Este contrato já foi assinado e não aceita novas assinaturas.',
        );
      } else {
        state = SignatureLoaded(contract: contract);
      }
    } on AppException catch (e) {
      state = SignatureError(e.toUserMessage());
    }
  }

  Future<void> signContract({
    required String signatarioNome,
    String? ip,
    required String userAgent,
    required List<int> signatureImageBytes,
  }) async {
    final currentState = state;
    if (currentState is! SignatureLoaded) return;

    state = SignatureLoaded(contract: currentState.contract, isSigning: true);

    try {
      final contractRepo = ref.read(contractRepositoryProvider);
      final sigRepo = ref.read(signatureRepositoryProvider);

      final alreadySigned = await sigRepo.hasAlreadySigned(
        contractId: currentState.contract.id,
        signatarioNome: signatarioNome,
      );
      if (alreadySigned) {
        state = SignatureAlreadySigned(
          currentState.contract,
          'Já existe uma assinatura registrada para este nome neste contrato.',
        );
        return;
      }

      final signedAt = DateTime.now();
      final sigId = signedAt.microsecondsSinceEpoch.toString();
      final signatureBase64 = base64Encode(signatureImageBytes);
      final resolvedIp = ip?.trim().isNotEmpty == true ? ip!.trim() : await _resolveIpAddress();
      final geolocation = await _resolveGeolocation();
      final documentHash = _generateDocumentHash(
        contractText: currentState.contract.textoFinal ?? '',
        signatarioNome: signatarioNome,
        signatureBase64: signatureBase64,
        signedAt: signedAt,
        userAgent: userAgent,
        shareToken: currentState.contract.shareToken ?? currentState.contract.id,
      );

      final sigDto = SignatureDto(
        id: sigId,
        contractId: currentState.contract.id,
        shareToken: currentState.contract.shareToken,
        signatarioNome: signatarioNome,
        imagemBase64: signatureBase64,
        ip: resolvedIp,
        geolocalizacao: geolocation,
        signedAt: signedAt,
        createdAt: signedAt,
        updatedAt: signedAt,
      );

      await sigRepo.signContract(dto: sigDto);
      await contractRepo.updateStatus(currentState.contract.id, 'assinado');

      final certificateUrl = 'https://app.estudyou.com.br/contracts/${currentState.contract.id}/certificate';

      await contractRepo.updateFinalDocument(
        currentState.contract.id,
        pdfUrl: certificateUrl,
        hash: documentHash,
      );

      final updatedContract = currentState.contract.copyWith(
        status: 'assinado',
        hashDocumento: documentHash,
        pdfUrl: certificateUrl,
      );

      state = SignatureSuccess(updatedContract, certificateUrl);
    } on AppException catch (e) {
      state = SignatureError(e.toUserMessage());
    }
  }

  Future<String?> _resolveIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org'));
      if (response.statusCode == 200) {
        final value = response.body.trim();
        return value.isEmpty ? null : value;
      }
    } catch (_) {}
    return null;
  }

  Future<String?> _resolveGeolocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition();
      return '(${position.latitude},${position.longitude})';
    } catch (_) {
      return null;
    }
  }

  String _generateDocumentHash({
    required String contractText,
    required String signatarioNome,
    required String signatureBase64,
    required DateTime signedAt,
    required String userAgent,
    required String shareToken,
  }) {
    final payload = [
      shareToken,
      signatarioNome,
      signedAt.toIso8601String(),
      userAgent,
      contractText,
      signatureBase64,
    ].join('|');

    return sha256.convert(utf8.encode(payload)).toString();
  }
}
