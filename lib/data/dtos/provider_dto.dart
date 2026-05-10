// lib/data/dtos/provider_dto.dart

/// DTO da tabela `providers` — empresas prestadoras multi-tenant.
class ProviderDto {
  final String id;
  final String empresa; // empresa_slug: estudyou, protseg, protuni
  final String razaoSocial;
  final String cnpj;
  final String? logoUrl;
  final String? endereco;
  final String? responsavel;
  final String? email;
  final String? corMarca;
  final String? assinaturaPadrao;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProviderDto({
    required this.id,
    required this.empresa,
    required this.razaoSocial,
    required this.cnpj,
    this.logoUrl,
    this.endereco,
    this.responsavel,
    this.email,
    this.corMarca,
    this.assinaturaPadrao,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProviderDto.fromJson(Map<String, dynamic> json) => ProviderDto(
        id: json['id'] as String,
        empresa: json['empresa'] as String,
        razaoSocial: json['razao_social'] as String,
        cnpj: json['cnpj'] as String,
        logoUrl: json['logo_url'] as String?,
        endereco: json['endereco'] as String?,
        responsavel: json['responsavel'] as String?,
        email: json['email'] as String?,
        corMarca: json['cor_marca'] as String?,
        assinaturaPadrao: json['assinatura_padrao'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toInsertJson() => {
        'empresa': empresa,
        'razao_social': razaoSocial,
        'cnpj': cnpj,
        'logo_url': logoUrl,
        'endereco': endereco,
        'responsavel': responsavel,
        'email': email,
        'cor_marca': corMarca,
        'assinatura_padrao': assinaturaPadrao,
      };

  Map<String, dynamic> toUpdateJson() => {
        'id': id,
        'empresa': empresa,
        'razao_social': razaoSocial,
        'cnpj': cnpj,
        'logo_url': logoUrl,
        'endereco': endereco,
        'responsavel': responsavel,
        'email': email,
        'cor_marca': corMarca,
        'assinatura_padrao': assinaturaPadrao,
      };

  Map<String, dynamic> toJson() => toUpdateJson();

  ProviderDto copyWith({
    String? id,
    String? empresa,
    String? razaoSocial,
    String? cnpj,
    String? logoUrl,
    String? endereco,
    String? responsavel,
    String? email,
    String? corMarca,
    String? assinaturaPadrao,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProviderDto(
        id: id ?? this.id,
        empresa: empresa ?? this.empresa,
        razaoSocial: razaoSocial ?? this.razaoSocial,
        cnpj: cnpj ?? this.cnpj,
        logoUrl: logoUrl ?? this.logoUrl,
        endereco: endereco ?? this.endereco,
        responsavel: responsavel ?? this.responsavel,
        email: email ?? this.email,
        corMarca: corMarca ?? this.corMarca,
        assinaturaPadrao: assinaturaPadrao ?? this.assinaturaPadrao,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
