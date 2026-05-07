// lib/data/dtos/product_dto.dart

/// DTO da tabela `products` — catálogo de produtos/serviços.
class ProductDto {
  final String? id;
  final String? providerId;
  final String nome;
  final String? descricao;
  final double preco;
  final String tipo; // produto_tipo: 'produto' | 'servico'
  final String? unidade;
  final bool ativo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  const ProductDto({
    this.id,
    this.providerId,
    required this.nome,
    this.descricao,
    required this.preco,
    required this.tipo,
    this.unidade,
    this.ativo = true,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
        id: json['id'] as String?,
        providerId: json['provider_id'] as String?,
        nome: json['nome'] as String,
        descricao: json['descricao'] as String?,
        preco: (json['preco'] as num).toDouble(),
        tipo: json['tipo'] as String,
        unidade: json['unidade'] as String?,
        ativo: json['ativo'] as bool? ?? true,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        archivedAt: json['archived_at'] != null
            ? DateTime.parse(json['archived_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'tipo': tipo,
      'unidade': unidade,
      'ativo': ativo,
    };
    if (id != null && id!.trim().isNotEmpty) {
      map['id'] = id;
    }
    if (providerId != null && providerId!.trim().isNotEmpty) {
      map['provider_id'] = providerId;
    }
    return map;
  }

  ProductDto copyWith({
    String? id, String? providerId, String? nome, String? descricao,
    double? preco, String? tipo, String? unidade, bool? ativo,
    DateTime? createdAt, DateTime? updatedAt, DateTime? archivedAt,
  }) => ProductDto(
        id: id ?? this.id, providerId: providerId ?? this.providerId,
        nome: nome ?? this.nome, descricao: descricao ?? this.descricao,
        preco: preco ?? this.preco, tipo: tipo ?? this.tipo,
        unidade: unidade ?? this.unidade, ativo: ativo ?? this.ativo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        archivedAt: archivedAt ?? this.archivedAt,
      );
}
