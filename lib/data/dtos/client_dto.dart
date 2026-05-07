// lib/data/dtos/client_dto.dart

/// DTO da tabela `clients` — clientes PF/PJ.
class ClientDto {
  final String? id;
  final String? providerId;
  final String nome;
  final String cpfCnpj;
  final String? email;
  final String? telefone;
  final Map<String, dynamic>? endereco;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  const ClientDto({
    this.id,
    this.providerId,
    required this.nome,
    required this.cpfCnpj,
    this.email,
    this.telefone,
    this.endereco,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });

  /// Identifica se é Pessoa Física (CPF = 11 dígitos) ou Jurídica (CNPJ = 14).
  bool get isPessoaFisica => cpfCnpj.replaceAll(RegExp(r'\D'), '').length == 11;

  bool get isArchived => archivedAt != null;

  factory ClientDto.fromJson(Map<String, dynamic> json) => ClientDto(
        id: json['id'] as String?,
        providerId: json['provider_id'] as String?,
        nome: json['nome'] as String,
        cpfCnpj: json['cpf_cnpj'] as String,
        email: json['email'] as String?,
        telefone: json['telefone'] as String?,
        endereco: json['endereco'] as Map<String, dynamic>?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        archivedAt: json['archived_at'] != null
            ? DateTime.parse(json['archived_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'nome': nome,
      'cpf_cnpj': cpfCnpj,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
    };
    if (id != null && id!.trim().isNotEmpty) {
      map['id'] = id;
    }
    if (providerId != null && providerId!.trim().isNotEmpty) {
      map['provider_id'] = providerId;
    }
    return map;
  }

  ClientDto copyWith({
    String? id,
    String? providerId,
    String? nome,
    String? cpfCnpj,
    String? email,
    String? telefone,
    Map<String, dynamic>? endereco,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? archivedAt,
  }) =>
      ClientDto(
        id: id ?? this.id,
        providerId: providerId ?? this.providerId,
        nome: nome ?? this.nome,
        cpfCnpj: cpfCnpj ?? this.cpfCnpj,
        email: email ?? this.email,
        telefone: telefone ?? this.telefone,
        endereco: endereco ?? this.endereco,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        archivedAt: archivedAt ?? this.archivedAt,
      );
}
