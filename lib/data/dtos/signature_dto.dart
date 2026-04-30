// lib/data/dtos/signature_dto.dart

/// DTO da tabela `signatures` — assinaturas digitais dos signatários.
class SignatureDto {
  final String id;
  final String contractId;
  final String? shareToken;
  final String signatarioNome;
  final String? signatarioEmail;
  final String? imagemBase64;
  final String? ip;
  final String? geolocalizacao; // Formato: "(lat,lng)"
  final DateTime signedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SignatureDto({
    required this.id,
    required this.contractId,
    this.shareToken,
    required this.signatarioNome,
    this.signatarioEmail,
    this.imagemBase64,
    this.ip,
    this.geolocalizacao,
    required this.signedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SignatureDto.fromJson(Map<String, dynamic> json) => SignatureDto(
        id: json['id'] as String,
        contractId: json['contract_id'] as String,
        shareToken: json['share_token'] as String?,
        signatarioNome: json['signatario_nome'] as String,
        signatarioEmail: json['signatario_email'] as String?,
        imagemBase64: json['imagem_base64'] as String?,
        ip: json['ip'] as String?,
        geolocalizacao: json['geolocalizacao'] as String?,
        signedAt: DateTime.parse(json['signed_at'] as String),
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'contract_id': contractId,
        'share_token': shareToken,
        'signatario_nome': signatarioNome,
        'signatario_email': signatarioEmail,
        'imagem_base64': imagemBase64,
        'ip': ip,
        'geolocalizacao': geolocalizacao,
      };

  SignatureDto copyWith({
    String? id, String? contractId, String? shareToken, String? signatarioNome,
    String? signatarioEmail, String? imagemBase64, String? ip,
    String? geolocalizacao, DateTime? signedAt, DateTime? createdAt,
    DateTime? updatedAt,
  }) => SignatureDto(
        id: id ?? this.id, contractId: contractId ?? this.contractId,
        shareToken: shareToken ?? this.shareToken,
        signatarioNome: signatarioNome ?? this.signatarioNome,
        signatarioEmail: signatarioEmail ?? this.signatarioEmail,
        imagemBase64: imagemBase64 ?? this.imagemBase64, ip: ip ?? this.ip,
        geolocalizacao: geolocalizacao ?? this.geolocalizacao,
        signedAt: signedAt ?? this.signedAt, createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
