// lib/data/dtos/proposal_template_dto.dart

/// DTO da tabela `proposal_templates` — modelos de proposta.
class ProposalTemplateDto {
  final String id;
  final String providerId;
  final String nome;
  final Map<String, dynamic> corpoJson;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProposalTemplateDto({
    required this.id,
    required this.providerId,
    required this.nome,
    required this.corpoJson,
    this.ativo = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProposalTemplateDto.fromJson(Map<String, dynamic> json) =>
      ProposalTemplateDto(
        id: json['id'] as String,
        providerId: json['provider_id'] as String,
        nome: json['nome'] as String,
        corpoJson: json['corpo_json'] as Map<String, dynamic>? ?? {},
        ativo: json['ativo'] as bool? ?? true,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'provider_id': providerId,
        'nome': nome,
        'corpo_json': corpoJson,
        'ativo': ativo,
      };

  ProposalTemplateDto copyWith({
    String? id, String? providerId, String? nome,
    Map<String, dynamic>? corpoJson, bool? ativo,
    DateTime? createdAt, DateTime? updatedAt,
  }) => ProposalTemplateDto(
        id: id ?? this.id, providerId: providerId ?? this.providerId,
        nome: nome ?? this.nome, corpoJson: corpoJson ?? this.corpoJson,
        ativo: ativo ?? this.ativo, createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
