// lib/data/dtos/contract_template_dto.dart

/// DTO da tabela `contract_templates` — modelos de contrato com versionamento.
class ContractTemplateDto {
  final String id;
  final String providerId;
  final String nome;
  final Map<String, dynamic> corpoJson;
  final int versao;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ContractTemplateDto({
    required this.id,
    required this.providerId,
    required this.nome,
    required this.corpoJson,
    this.versao = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContractTemplateDto.fromJson(Map<String, dynamic> json) =>
      ContractTemplateDto(
        id: json['id'] as String,
        providerId: json['provider_id'] as String,
        nome: json['nome'] as String,
        corpoJson: json['corpo_json'] as Map<String, dynamic>? ?? {},
        versao: json['versao'] as int? ?? 1,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id, 'provider_id': providerId, 'nome': nome,
        'corpo_json': corpoJson, 'versao': versao,
      };

  ContractTemplateDto copyWith({
    String? id, String? providerId, String? nome,
    Map<String, dynamic>? corpoJson, int? versao,
    DateTime? createdAt, DateTime? updatedAt,
  }) => ContractTemplateDto(
        id: id ?? this.id, providerId: providerId ?? this.providerId,
        nome: nome ?? this.nome, corpoJson: corpoJson ?? this.corpoJson,
        versao: versao ?? this.versao, createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
