// lib/core/services/pdf_service.dart
//
// Serviço de geração de PDF para propostas e contratos.
// Utiliza o package `pdf` para geração no dispositivo.

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../../data/dtos/contract_dto.dart';
import '../../data/dtos/proposal_dto.dart';
import '../../data/dtos/provider_dto.dart';
import '../../data/dtos/signature_dto.dart';
import '../../data/supabase/supabase_provider.dart';

part 'pdf_service.g.dart';

/// Formatador de moeda BRL
final _brlFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
final _dateFormat = DateFormat('dd/MM/yyyy');

class PdfService {
  final SupabaseClient _client;

  const PdfService(this._client);

  Future<ProviderDto?> getProviderById(String? providerId) async {
    if (providerId == null || providerId.isEmpty) return null;
    try {
      return await _client.from('providers').select().eq('id', providerId).maybeSingle().then(
            (data) => data == null ? null : ProviderDto.fromJson(data),
          );
    } catch (_) {
      return null;
    }
  }

  /// Gera PDF de uma proposta comercial.
  Future<Uint8List> generateProposalPdf(ProposalDto proposal) async {
    final pdf = pw.Document();
    final provider = await getProviderById(proposal.providerId);
    final brandColor = _parsePdfColor(provider?.corMarca);
    final logo = await _loadLogo(provider?.logoUrl);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _buildBrandHeader(
            title: 'PROPOSTA COMERCIAL',
            provider: provider,
            brandColor: brandColor,
            logo: logo,
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
          if (provider?.assinaturaPadrao?.trim().isNotEmpty == true) ...[
            pw.SizedBox(height: 24),
            pw.Divider(color: brandColor),
            pw.Text(
              provider!.assinaturaPadrao!.trim(),
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
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
    final provider = await getProviderById(contract.providerId);
    final brandColor = _parsePdfColor(provider?.corMarca);
    final logo = await _loadLogo(provider?.logoUrl);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _buildBrandHeader(
            title: 'CONTRATO',
            provider: provider,
            brandColor: brandColor,
            logo: logo,
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
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: brandColor),
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(sig.signatarioNome,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    if (sig.imagemBase64 != null && sig.imagemBase64!.isNotEmpty) ...[
                      pw.SizedBox(height: 8),
                      pw.Container(
                        height: 60,
                        width: 180,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey400),
                        ),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Image(
                            pw.MemoryImage(base64Decode(sig.imagemBase64!)),
                            fit: pw.BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                    pw.SizedBox(height: 8),
                    pw.Text('Data: ${_dateFormat.format(sig.signedAt)}'),
                    if (sig.ip != null) pw.Text('IP: ${sig.ip}'),
                    if (sig.geolocalizacao != null) pw.Text('Geo: ${sig.geolocalizacao}'),
                  ],
                ),
              )),

          // Hash de verificação
          if (contract.hashDocumento != null) ...[
            pw.SizedBox(height: 16),
            pw.Text('Hash SHA-256: ${contract.hashDocumento}',
                style: pw.TextStyle(fontSize: 8, font: pw.Font.courier())),
          ],
          if (provider?.assinaturaPadrao?.trim().isNotEmpty == true) ...[
            pw.SizedBox(height: 24),
            pw.Divider(color: brandColor),
            pw.Text(
              provider!.assinaturaPadrao!.trim(),
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ],
      ),
    );

    return pdf.save();
  }

  /// Upload do PDF para Supabase Storage (bucket `pdfs`).
  Future<String> uploadPdf({
    required Uint8List bytes,
    required String providerId,
    required String fileName,
    String? objectPath,
  }) async {
    final path = objectPath ?? '$providerId/$fileName';
    await _client.storage.from('pdfs').uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(contentType: 'application/pdf', upsert: true),
        );
    return _client.storage.from('pdfs').getPublicUrl(path);
  }

  String hashPdfBytes(Uint8List bytes) {
    return sha256.convert(bytes).toString();
  }

  Future<pw.MemoryImage?> _loadLogo(String? logoUrl) async {
    if (logoUrl == null || logoUrl.trim().isEmpty) return null;
    try {
      final uri = Uri.tryParse(logoUrl);
      final segments = uri?.pathSegments ?? const <String>[];
      final bucketIndex = segments.indexOf('provider-logos');
      if (bucketIndex == -1 || bucketIndex + 1 >= segments.length) {
        return null;
      }
      final objectPath = segments.sublist(bucketIndex + 1).join('/');
      final bytes = await _client.storage.from('provider-logos').download(objectPath);
      return pw.MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  pw.Widget _buildBrandHeader({
    required String title,
    required ProviderDto? provider,
    required PdfColor brandColor,
    required pw.MemoryImage? logo,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null)
              pw.Container(
                width: 56,
                height: 56,
                margin: const pw.EdgeInsets.only(right: 12),
                child: pw.Image(logo, fit: pw.BoxFit.contain),
              ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    title,
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: brandColor,
                    ),
                  ),
                  if (provider != null) ...[
                    pw.SizedBox(height: 4),
                    pw.Text(
                      provider.razaoSocial,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('CNPJ: ${provider.cnpj}'),
                    if (provider.email?.trim().isNotEmpty == true)
                      pw.Text(provider.email!.trim()),
                  ],
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Container(height: 3, color: brandColor),
        pw.SizedBox(height: 12),
      ],
    );
  }

  PdfColor _parsePdfColor(String? hex) {
    final value = hex?.trim();
    if (value == null || value.isEmpty) return PdfColors.orange;
    final normalized = value.startsWith('#') ? value.substring(1) : value;
    final parsed = int.tryParse(normalized, radix: 16);
    if (parsed == null) return PdfColors.orange;
    return PdfColor.fromInt(0xFF000000 | parsed);
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
