// lib/core/services/pdf_service.dart
//
// Serviço de geração de PDF para propostas e contratos.
// Utiliza o package `pdf` para geração no dispositivo.

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../data/dtos/contract_dto.dart';
import '../../data/dtos/proposal_dto.dart';
import '../../data/dtos/signature_dto.dart';
import '../../data/supabase/supabase_provider.dart';

part 'pdf_service.g.dart';

/// Formatador de moeda BRL
final _brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _dateFormat = DateFormat('dd/MM/yyyy');

class PdfService {
  final SupabaseClient _client;

  const PdfService(this._client);

  /// Gera PDF de uma proposta comercial.
  Future<Uint8List> generateProposalPdf(ProposalDto proposal) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // Cabeçalho
          pw.Header(
            level: 0,
            child: pw.Text(
              'PROPOSTA COMERCIAL',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 8),

          // Informações gerais
          _buildInfoRow('Cliente', proposal.clienteNome ?? 'N/A'),
          _buildInfoRow('Versão', 'v${proposal.versao}'),
          _buildInfoRow('Status', (proposal.status ?? 'rascunho').toUpperCase()),
          if (proposal.validade != null)
            _buildInfoRow('Validade', _dateFormat.format(proposal.validade!)),
          pw.SizedBox(height: 16),

          // Tabela de itens
          if (proposal.itensJson.isNotEmpty) ...[
            pw.Header(level: 1, child: pw.Text('Itens')),
            pw.TableHelper.fromTextArray(
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
              cellPadding: const pw.EdgeInsets.all(6),
              headers: ['Item', 'Qtd', 'Unitário', 'Total'],
              data: proposal.itensJson.map((item) {
                final nome = item['nome'] as String? ?? '';
                final qty = item['quantidade'] as num? ?? 1;
                final price = (item['preco'] as num?)?.toDouble() ?? 0;
                return [
                  nome,
                  qty.toString(),
                  _brlFormat.format(price),
                  _brlFormat.format(price * qty),
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 12),
          ],

          // Resumo financeiro
          pw.Divider(),
          if (proposal.desconto > 0)
            _buildInfoRow('Desconto', _brlFormat.format(proposal.desconto)),
          _buildInfoRow('TOTAL', _brlFormat.format(proposal.total),
              bold: true),

          // Observações
          if (proposal.observacoes != null && proposal.observacoes!.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            pw.Header(level: 1, child: pw.Text('Observações')),
            pw.Text(proposal.observacoes!),
          ],
        ],
      ),
    );

    return pdf.save();
  }

  /// Gera PDF de contrato com assinaturas inseridas visualmente.
  Future<Uint8List> generateContractPdf(
    ContractDto contract,
    List<SignatureDto> signatures,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'CONTRATO',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 8),

          _buildInfoRow('Cliente', contract.clienteNome ?? 'N/A'),
          _buildInfoRow('Status', contract.status.toUpperCase()),
          if (contract.vigenciaInicio != null)
            _buildInfoRow('Vigência', '${_dateFormat.format(contract.vigenciaInicio!)} a ${contract.vigenciaFim != null ? _dateFormat.format(contract.vigenciaFim!) : "N/A"}'),
          pw.SizedBox(height: 16),

          // Texto do contrato
          if (contract.textoFinal != null) ...[
            pw.Text(contract.textoFinal!, style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height: 24),
          ],

          // Assinaturas
          pw.Header(level: 1, child: pw.Text('Assinaturas')),
          ...signatures.map((sig) => pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 16),
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(sig.signatarioNome,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Data: ${_dateFormat.format(sig.signedAt)}'),
                    if (sig.ip != null) pw.Text('IP: ${sig.ip}'),
                  ],
                ),
              )),

          // Hash de verificação
          if (contract.hashDocumento != null) ...[
            pw.SizedBox(height: 16),
            pw.Text('Hash SHA-256: ${contract.hashDocumento}',
                style: pw.TextStyle(fontSize: 8, font: pw.Font.courier())),
          ],
        ],
      ),
    );

    return pdf.save();
  }

  /// Upload do PDF para Supabase Storage (bucket `pdfs`).
  /// Organiza por provider_id para isolamento via RLS.
  Future<String> uploadPdf({
    required Uint8List bytes,
    required String providerId,
    required String fileName,
  }) async {
    final path = '$providerId/$fileName';
    await _client.storage.from('pdfs').uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(contentType: 'application/pdf', upsert: true),
        );
    return _client.storage.from('pdfs').getPublicUrl(path);
  }

  /// Helper para linha de informação no PDF.
  static pw.Widget _buildInfoRow(String label, String value, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 100,
            child: pw.Text('$label:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
          ),
          pw.Expanded(
            child: pw.Text(value,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
                )),
          ),
        ],
      ),
    );
  }
}

@riverpod
PdfService pdfService(Ref ref) {
  return PdfService(ref.watch(supabaseClientProvider));
}
