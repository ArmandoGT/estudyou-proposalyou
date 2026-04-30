// lib/data/dtos/proposal_dto.dart

/// DTO da tabela `proposals` — propostas comerciais.
class ProposalDto {
  final String id;
  final String providerId;
  final String clientId;
  final String? templateId;
  final String status; // proposta_status
  final DateTime? validade;
  final List<Map<String, dynamic>> itensJson;
  final double total;
  final double desconto;
  final String? observacoes;
  final int versao;
  final String? shareToken;
  final String? pdfUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Campos expandidos via JOIN (opcionais)
  final String? clienteNome;
  final String? providerEmpresa;

  const ProposalDto({
    required this.id,
    required this.providerId,
    required this.clientId,
    this.templateId,
    required this.status,
    this.validade,
    this.itensJson = const [],
    this.total = 0,
    this.desconto = 0,
    this.observacoes,
    this.versao = 1,
    this.shareToken,
    this.pdfUrl,
    required this.createdAt,
    required this.updatedAt,
    this.clienteNome,
    this.providerEmpresa,
  });

  /// Proposta imutável: não pode ser editada se status for 'enviada' ou 'aprovada'.
  bool get isLocked => status == 'enviada' || status == 'aprovada';

  factory ProposalDto.fromJson(Map<String, dynamic> json) {
    // Suporta itens_json como List ou String
    final rawItens = json['itens_json'];
    final List<Map<String, dynamic>> itens = switch (rawItens) {
      List<dynamic> list => list.cast<Map<String, dynamic>>(),
      _ => const [],
    };

    // Suporta campo expandido 'client' via select com join
    final clientData = json['client'] as Map<String, dynamic>?;

    return ProposalDto(
      id: json['id'] as String,
      providerId: json['provider_id'] as String,
      clientId: json['client_id'] as String,
      templateId: json['template_id'] as String?,
      status: json['status'] as String? ?? 'rascunho',
      validade: json['validade'] != null
          ? DateTime.parse(json['validade'] as String)
          : null,
      itensJson: itens,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      desconto: (json['desconto'] as num?)?.toDouble() ?? 0,
      observacoes: json['observacoes'] as String?,
      versao: json['versao'] as int? ?? 1,
      shareToken: json['share_token'] as String?,
      pdfUrl: json['pdf_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      clienteNome: clientData?['nome'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'provider_id': providerId,
        'client_id': clientId,
        'template_id': templateId,
        'status': status,
        'validade': validade?.toIso8601String().split('T').first,
        'itens_json': itensJson,
        'total': total,
        'desconto': desconto,
        'observacoes': observacoes,
        'versao': versao,
      };

  ProposalDto copyWith({
    String? id, String? providerId, String? clientId, String? templateId,
    String? status, DateTime? validade, List<Map<String, dynamic>>? itensJson,
    double? total, double? desconto, String? observacoes, int? versao,
    String? shareToken, String? pdfUrl, DateTime? createdAt, DateTime? updatedAt,
    String? clienteNome, String? providerEmpresa,
  }) => ProposalDto(
        id: id ?? this.id, providerId: providerId ?? this.providerId,
        clientId: clientId ?? this.clientId, templateId: templateId ?? this.templateId,
        status: status ?? this.status, validade: validade ?? this.validade,
        itensJson: itensJson ?? this.itensJson, total: total ?? this.total,
        desconto: desconto ?? this.desconto, observacoes: observacoes ?? this.observacoes,
        versao: versao ?? this.versao, shareToken: shareToken ?? this.shareToken,
        pdfUrl: pdfUrl ?? this.pdfUrl, createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt, clienteNome: clienteNome ?? this.clienteNome,
        providerEmpresa: providerEmpresa ?? this.providerEmpresa,
      );
}
