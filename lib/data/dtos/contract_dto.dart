// lib/data/dtos/contract_dto.dart

/// DTO da tabela `contracts` — contratos com assinatura digital.
class ContractDto {
  final String id;
  final String providerId;
  final String clientId;
  final String? templateId;
  final String? proposalId;
  final String status; // contrato_status
  final String? textoFinal;
  final DateTime? vigenciaInicio;
  final DateTime? vigenciaFim;
  final String? shareToken;
  final String? pdfUrl;
  final String? hashDocumento;
  final int totalSignatarios;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Campos expandidos via JOIN
  final String? clienteNome;
  final int? assinaturasRealizadas;

  const ContractDto({
    required this.id,
    required this.providerId,
    required this.clientId,
    this.templateId,
    this.proposalId,
    required this.status,
    this.textoFinal,
    this.vigenciaInicio,
    this.vigenciaFim,
    this.shareToken,
    this.pdfUrl,
    this.hashDocumento,
    this.totalSignatarios = 2,
    required this.createdAt,
    required this.updatedAt,
    this.clienteNome,
    this.assinaturasRealizadas,
  });

  /// Progresso de assinaturas (ex: "1/2")
  String get progressoAssinaturas =>
      '${assinaturasRealizadas ?? 0}/$totalSignatarios';

  factory ContractDto.fromJson(Map<String, dynamic> json) {
    final clientData = json['client'] as Map<String, dynamic>?;
    final sigs = json['signatures'] as List<dynamic>?;

    return ContractDto(
      id: json['id'] as String,
      providerId: json['provider_id'] as String,
      clientId: json['client_id'] as String,
      templateId: json['template_id'] as String?,
      proposalId: json['proposal_id'] as String?,
      status: json['status'] as String? ?? 'aguardando_assinatura',
      textoFinal: json['texto_final'] as String?,
      vigenciaInicio: json['vigencia_inicio'] != null
          ? DateTime.parse(json['vigencia_inicio'] as String) : null,
      vigenciaFim: json['vigencia_fim'] != null
          ? DateTime.parse(json['vigencia_fim'] as String) : null,
      shareToken: json['share_token'] as String?,
      pdfUrl: json['pdf_url'] as String?,
      hashDocumento: json['hash_documento'] as String?,
      totalSignatarios: json['total_signatarios'] as int? ?? 2,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      clienteNome: clientData?['nome'] as String?,
      assinaturasRealizadas: sigs?.length,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id, 'provider_id': providerId, 'client_id': clientId,
        'template_id': templateId, 'proposal_id': proposalId,
        'status': status, 'texto_final': textoFinal,
        'vigencia_inicio': vigenciaInicio?.toIso8601String().split('T').first,
        'vigencia_fim': vigenciaFim?.toIso8601String().split('T').first,
        'total_signatarios': totalSignatarios,
      };

  ContractDto copyWith({
    String? id, String? providerId, String? clientId, String? templateId,
    String? proposalId, String? status, String? textoFinal,
    DateTime? vigenciaInicio, DateTime? vigenciaFim, String? shareToken,
    String? pdfUrl, String? hashDocumento, int? totalSignatarios,
    DateTime? createdAt, DateTime? updatedAt, String? clienteNome,
    int? assinaturasRealizadas,
  }) => ContractDto(
        id: id ?? this.id, providerId: providerId ?? this.providerId,
        clientId: clientId ?? this.clientId, templateId: templateId ?? this.templateId,
        proposalId: proposalId ?? this.proposalId, status: status ?? this.status,
        textoFinal: textoFinal ?? this.textoFinal,
        vigenciaInicio: vigenciaInicio ?? this.vigenciaInicio,
        vigenciaFim: vigenciaFim ?? this.vigenciaFim,
        shareToken: shareToken ?? this.shareToken, pdfUrl: pdfUrl ?? this.pdfUrl,
        hashDocumento: hashDocumento ?? this.hashDocumento,
        totalSignatarios: totalSignatarios ?? this.totalSignatarios,
        createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt,
        clienteNome: clienteNome ?? this.clienteNome,
        assinaturasRealizadas: assinaturasRealizadas ?? this.assinaturasRealizadas,
      );
}
