// lib/core/services/share_service.dart
//
// Serviço de compartilhamento de propostas e contratos via
// WhatsApp, clipboard, download local e deep links.

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/dtos/contract_dto.dart';
import '../../data/dtos/proposal_dto.dart';

part 'share_service.g.dart';

// ⚠️ DECISÃO PENDENTE: URL base do app web (deep links)
const _baseUrl = 'https://app.estudyou.com.br';

class ShareService {
  const ShareService();

  /// Gera o deep link público para visualização de proposta.
  String proposalLink(ProposalDto proposal) =>
      '$_baseUrl/p/${proposal.shareToken}';

  /// Gera o deep link público para assinatura de contrato.
  String contractSignLink(ContractDto contract) =>
      '$_baseUrl/s/${contract.shareToken}';

  /// Compartilha proposta via share nativo (WhatsApp, email, etc.)
  Future<void> shareProposal(ProposalDto proposal) async {
    final link = proposalLink(proposal);
    final text = 'Proposta comercial para ${proposal.clienteNome ?? "cliente"}\n'
        'Valor: R\$ ${proposal.total.toStringAsFixed(2)}\n'
        'Visualize aqui: $link';
    await SharePlus.instance.share(ShareParams(text: text));
  }

  /// Compartilha contrato para assinatura via share nativo.
  Future<void> shareContract(ContractDto contract) async {
    final link = contractSignLink(contract);
    final text = 'Contrato para assinatura digital\n'
        'Cliente: ${contract.clienteNome ?? "N/A"}\n'
        'Assine aqui: $link';
    await SharePlus.instance.share(ShareParams(text: text));
  }

  /// Compartilha via WhatsApp com link direto.
  Future<void> shareViaWhatsApp(String url, String clientName) async {
    final text = Uri.encodeComponent(
      'Olá $clientName! Segue o link do documento: $url',
    );
    final whatsappUrl = Uri.parse('https://wa.me/?text=$text');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  /// Copia link para a área de transferência.
  Future<void> copyLinkToClipboard(String url) async {
    await Clipboard.setData(ClipboardData(text: url));
  }

  /// Salva PDF localmente no dispositivo.
  Future<String> downloadPdf(Uint8List bytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// Compartilha arquivo PDF via share nativo.
  Future<void> sharePdfFile(Uint8List bytes, String fileName) async {
    final path = await downloadPdf(bytes, fileName);
    await SharePlus.instance.share(
      ShareParams(files: [XFile(path, mimeType: 'application/pdf')]),
    );
  }
}

@riverpod
ShareService shareService(Ref ref) {
  return const ShareService();
}
