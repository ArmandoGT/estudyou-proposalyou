// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedProvidersTable extends CachedProviders
    with TableInfo<$CachedProvidersTable, CachedProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _empresaMeta = const VerificationMeta(
    'empresa',
  );
  @override
  late final GeneratedColumn<String> empresa = GeneratedColumn<String>(
    'empresa',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _razaoSocialMeta = const VerificationMeta(
    'razaoSocial',
  );
  @override
  late final GeneratedColumn<String> razaoSocial = GeneratedColumn<String>(
    'razao_social',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
    'cnpj',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _corMarcaMeta = const VerificationMeta(
    'corMarca',
  );
  @override
  late final GeneratedColumn<String> corMarca = GeneratedColumn<String>(
    'cor_marca',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataJsonMeta = const VerificationMeta(
    'dataJson',
  );
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
    'data_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    empresa,
    razaoSocial,
    cnpj,
    logoUrl,
    corMarca,
    dataJson,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('empresa')) {
      context.handle(
        _empresaMeta,
        empresa.isAcceptableOrUnknown(data['empresa']!, _empresaMeta),
      );
    } else if (isInserting) {
      context.missing(_empresaMeta);
    }
    if (data.containsKey('razao_social')) {
      context.handle(
        _razaoSocialMeta,
        razaoSocial.isAcceptableOrUnknown(
          data['razao_social']!,
          _razaoSocialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_razaoSocialMeta);
    }
    if (data.containsKey('cnpj')) {
      context.handle(
        _cnpjMeta,
        cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta),
      );
    } else if (isInserting) {
      context.missing(_cnpjMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('cor_marca')) {
      context.handle(
        _corMarcaMeta,
        corMarca.isAcceptableOrUnknown(data['cor_marca']!, _corMarcaMeta),
      );
    }
    if (data.containsKey('data_json')) {
      context.handle(
        _dataJsonMeta,
        dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      empresa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}empresa'],
      )!,
      razaoSocial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}razao_social'],
      )!,
      cnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnpj'],
      )!,
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      corMarca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cor_marca'],
      ),
      dataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_json'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $CachedProvidersTable createAlias(String alias) {
    return $CachedProvidersTable(attachedDatabase, alias);
  }
}

class CachedProvider extends DataClass implements Insertable<CachedProvider> {
  final String id;
  final String empresa;
  final String razaoSocial;
  final String cnpj;
  final String? logoUrl;
  final String? corMarca;
  final String? dataJson;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const CachedProvider({
    required this.id,
    required this.empresa,
    required this.razaoSocial,
    required this.cnpj,
    this.logoUrl,
    this.corMarca,
    this.dataJson,
    required this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['empresa'] = Variable<String>(empresa);
    map['razao_social'] = Variable<String>(razaoSocial);
    map['cnpj'] = Variable<String>(cnpj);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || corMarca != null) {
      map['cor_marca'] = Variable<String>(corMarca);
    }
    if (!nullToAbsent || dataJson != null) {
      map['data_json'] = Variable<String>(dataJson);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedProvidersCompanion toCompanion(bool nullToAbsent) {
    return CachedProvidersCompanion(
      id: Value(id),
      empresa: Value(empresa),
      razaoSocial: Value(razaoSocial),
      cnpj: Value(cnpj),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      corMarca: corMarca == null && nullToAbsent
          ? const Value.absent()
          : Value(corMarca),
      dataJson: dataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(dataJson),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProvider(
      id: serializer.fromJson<String>(json['id']),
      empresa: serializer.fromJson<String>(json['empresa']),
      razaoSocial: serializer.fromJson<String>(json['razaoSocial']),
      cnpj: serializer.fromJson<String>(json['cnpj']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      corMarca: serializer.fromJson<String?>(json['corMarca']),
      dataJson: serializer.fromJson<String?>(json['dataJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'empresa': serializer.toJson<String>(empresa),
      'razaoSocial': serializer.toJson<String>(razaoSocial),
      'cnpj': serializer.toJson<String>(cnpj),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'corMarca': serializer.toJson<String?>(corMarca),
      'dataJson': serializer.toJson<String?>(dataJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedProvider copyWith({
    String? id,
    String? empresa,
    String? razaoSocial,
    String? cnpj,
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> corMarca = const Value.absent(),
    Value<String?> dataJson = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedProvider(
    id: id ?? this.id,
    empresa: empresa ?? this.empresa,
    razaoSocial: razaoSocial ?? this.razaoSocial,
    cnpj: cnpj ?? this.cnpj,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    corMarca: corMarca.present ? corMarca.value : this.corMarca,
    dataJson: dataJson.present ? dataJson.value : this.dataJson,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedProvider copyWithCompanion(CachedProvidersCompanion data) {
    return CachedProvider(
      id: data.id.present ? data.id.value : this.id,
      empresa: data.empresa.present ? data.empresa.value : this.empresa,
      razaoSocial: data.razaoSocial.present
          ? data.razaoSocial.value
          : this.razaoSocial,
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      corMarca: data.corMarca.present ? data.corMarca.value : this.corMarca,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProvider(')
          ..write('id: $id, ')
          ..write('empresa: $empresa, ')
          ..write('razaoSocial: $razaoSocial, ')
          ..write('cnpj: $cnpj, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('corMarca: $corMarca, ')
          ..write('dataJson: $dataJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    empresa,
    razaoSocial,
    cnpj,
    logoUrl,
    corMarca,
    dataJson,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProvider &&
          other.id == this.id &&
          other.empresa == this.empresa &&
          other.razaoSocial == this.razaoSocial &&
          other.cnpj == this.cnpj &&
          other.logoUrl == this.logoUrl &&
          other.corMarca == this.corMarca &&
          other.dataJson == this.dataJson &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedProvidersCompanion extends UpdateCompanion<CachedProvider> {
  final Value<String> id;
  final Value<String> empresa;
  final Value<String> razaoSocial;
  final Value<String> cnpj;
  final Value<String?> logoUrl;
  final Value<String?> corMarca;
  final Value<String?> dataJson;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedProvidersCompanion({
    this.id = const Value.absent(),
    this.empresa = const Value.absent(),
    this.razaoSocial = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.corMarca = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProvidersCompanion.insert({
    required String id,
    required String empresa,
    required String razaoSocial,
    required String cnpj,
    this.logoUrl = const Value.absent(),
    this.corMarca = const Value.absent(),
    this.dataJson = const Value.absent(),
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       empresa = Value(empresa),
       razaoSocial = Value(razaoSocial),
       cnpj = Value(cnpj),
       updatedAt = Value(updatedAt);
  static Insertable<CachedProvider> custom({
    Expression<String>? id,
    Expression<String>? empresa,
    Expression<String>? razaoSocial,
    Expression<String>? cnpj,
    Expression<String>? logoUrl,
    Expression<String>? corMarca,
    Expression<String>? dataJson,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (empresa != null) 'empresa': empresa,
      if (razaoSocial != null) 'razao_social': razaoSocial,
      if (cnpj != null) 'cnpj': cnpj,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (corMarca != null) 'cor_marca': corMarca,
      if (dataJson != null) 'data_json': dataJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProvidersCompanion copyWith({
    Value<String>? id,
    Value<String>? empresa,
    Value<String>? razaoSocial,
    Value<String>? cnpj,
    Value<String?>? logoUrl,
    Value<String?>? corMarca,
    Value<String?>? dataJson,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedProvidersCompanion(
      id: id ?? this.id,
      empresa: empresa ?? this.empresa,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      cnpj: cnpj ?? this.cnpj,
      logoUrl: logoUrl ?? this.logoUrl,
      corMarca: corMarca ?? this.corMarca,
      dataJson: dataJson ?? this.dataJson,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (empresa.present) {
      map['empresa'] = Variable<String>(empresa.value);
    }
    if (razaoSocial.present) {
      map['razao_social'] = Variable<String>(razaoSocial.value);
    }
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (corMarca.present) {
      map['cor_marca'] = Variable<String>(corMarca.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedProvidersCompanion(')
          ..write('id: $id, ')
          ..write('empresa: $empresa, ')
          ..write('razaoSocial: $razaoSocial, ')
          ..write('cnpj: $cnpj, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('corMarca: $corMarca, ')
          ..write('dataJson: $dataJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedClientsTable extends CachedClients
    with TableInfo<$CachedClientsTable, CachedClient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cpfCnpjMeta = const VerificationMeta(
    'cpfCnpj',
  );
  @override
  late final GeneratedColumn<String> cpfCnpj = GeneratedColumn<String>(
    'cpf_cnpj',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telefoneMeta = const VerificationMeta(
    'telefone',
  );
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
    'telefone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enderecoJsonMeta = const VerificationMeta(
    'enderecoJson',
  );
  @override
  late final GeneratedColumn<String> enderecoJson = GeneratedColumn<String>(
    'endereco_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    providerId,
    nome,
    cpfCnpj,
    email,
    telefone,
    enderecoJson,
    updatedAt,
    archivedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedClient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('cpf_cnpj')) {
      context.handle(
        _cpfCnpjMeta,
        cpfCnpj.isAcceptableOrUnknown(data['cpf_cnpj']!, _cpfCnpjMeta),
      );
    } else if (isInserting) {
      context.missing(_cpfCnpjMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('telefone')) {
      context.handle(
        _telefoneMeta,
        telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta),
      );
    }
    if (data.containsKey('endereco_json')) {
      context.handle(
        _enderecoJsonMeta,
        enderecoJson.isAcceptableOrUnknown(
          data['endereco_json']!,
          _enderecoJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedClient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedClient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      cpfCnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf_cnpj'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      telefone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefone'],
      ),
      enderecoJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endereco_json'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $CachedClientsTable createAlias(String alias) {
    return $CachedClientsTable(attachedDatabase, alias);
  }
}

class CachedClient extends DataClass implements Insertable<CachedClient> {
  final String id;
  final String providerId;
  final String nome;
  final String cpfCnpj;
  final String? email;
  final String? telefone;
  final String? enderecoJson;
  final DateTime updatedAt;
  final DateTime? archivedAt;
  final DateTime? syncedAt;
  const CachedClient({
    required this.id,
    required this.providerId,
    required this.nome,
    required this.cpfCnpj,
    this.email,
    this.telefone,
    this.enderecoJson,
    required this.updatedAt,
    this.archivedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider_id'] = Variable<String>(providerId);
    map['nome'] = Variable<String>(nome);
    map['cpf_cnpj'] = Variable<String>(cpfCnpj);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || enderecoJson != null) {
      map['endereco_json'] = Variable<String>(enderecoJson);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedClientsCompanion toCompanion(bool nullToAbsent) {
    return CachedClientsCompanion(
      id: Value(id),
      providerId: Value(providerId),
      nome: Value(nome),
      cpfCnpj: Value(cpfCnpj),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      enderecoJson: enderecoJson == null && nullToAbsent
          ? const Value.absent()
          : Value(enderecoJson),
      updatedAt: Value(updatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedClient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedClient(
      id: serializer.fromJson<String>(json['id']),
      providerId: serializer.fromJson<String>(json['providerId']),
      nome: serializer.fromJson<String>(json['nome']),
      cpfCnpj: serializer.fromJson<String>(json['cpfCnpj']),
      email: serializer.fromJson<String?>(json['email']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      enderecoJson: serializer.fromJson<String?>(json['enderecoJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'providerId': serializer.toJson<String>(providerId),
      'nome': serializer.toJson<String>(nome),
      'cpfCnpj': serializer.toJson<String>(cpfCnpj),
      'email': serializer.toJson<String?>(email),
      'telefone': serializer.toJson<String?>(telefone),
      'enderecoJson': serializer.toJson<String?>(enderecoJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedClient copyWith({
    String? id,
    String? providerId,
    String? nome,
    String? cpfCnpj,
    Value<String?> email = const Value.absent(),
    Value<String?> telefone = const Value.absent(),
    Value<String?> enderecoJson = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> archivedAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedClient(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    nome: nome ?? this.nome,
    cpfCnpj: cpfCnpj ?? this.cpfCnpj,
    email: email.present ? email.value : this.email,
    telefone: telefone.present ? telefone.value : this.telefone,
    enderecoJson: enderecoJson.present ? enderecoJson.value : this.enderecoJson,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedClient copyWithCompanion(CachedClientsCompanion data) {
    return CachedClient(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      nome: data.nome.present ? data.nome.value : this.nome,
      cpfCnpj: data.cpfCnpj.present ? data.cpfCnpj.value : this.cpfCnpj,
      email: data.email.present ? data.email.value : this.email,
      telefone: data.telefone.present ? data.telefone.value : this.telefone,
      enderecoJson: data.enderecoJson.present
          ? data.enderecoJson.value
          : this.enderecoJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedClient(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('cpfCnpj: $cpfCnpj, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('enderecoJson: $enderecoJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    providerId,
    nome,
    cpfCnpj,
    email,
    telefone,
    enderecoJson,
    updatedAt,
    archivedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedClient &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.nome == this.nome &&
          other.cpfCnpj == this.cpfCnpj &&
          other.email == this.email &&
          other.telefone == this.telefone &&
          other.enderecoJson == this.enderecoJson &&
          other.updatedAt == this.updatedAt &&
          other.archivedAt == this.archivedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedClientsCompanion extends UpdateCompanion<CachedClient> {
  final Value<String> id;
  final Value<String> providerId;
  final Value<String> nome;
  final Value<String> cpfCnpj;
  final Value<String?> email;
  final Value<String?> telefone;
  final Value<String?> enderecoJson;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> archivedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedClientsCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.nome = const Value.absent(),
    this.cpfCnpj = const Value.absent(),
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.enderecoJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedClientsCompanion.insert({
    required String id,
    required String providerId,
    required String nome,
    required String cpfCnpj,
    this.email = const Value.absent(),
    this.telefone = const Value.absent(),
    this.enderecoJson = const Value.absent(),
    required DateTime updatedAt,
    this.archivedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerId = Value(providerId),
       nome = Value(nome),
       cpfCnpj = Value(cpfCnpj),
       updatedAt = Value(updatedAt);
  static Insertable<CachedClient> custom({
    Expression<String>? id,
    Expression<String>? providerId,
    Expression<String>? nome,
    Expression<String>? cpfCnpj,
    Expression<String>? email,
    Expression<String>? telefone,
    Expression<String>? enderecoJson,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (nome != null) 'nome': nome,
      if (cpfCnpj != null) 'cpf_cnpj': cpfCnpj,
      if (email != null) 'email': email,
      if (telefone != null) 'telefone': telefone,
      if (enderecoJson != null) 'endereco_json': enderecoJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedClientsCompanion copyWith({
    Value<String>? id,
    Value<String>? providerId,
    Value<String>? nome,
    Value<String>? cpfCnpj,
    Value<String?>? email,
    Value<String?>? telefone,
    Value<String?>? enderecoJson,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? archivedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedClientsCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      nome: nome ?? this.nome,
      cpfCnpj: cpfCnpj ?? this.cpfCnpj,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      enderecoJson: enderecoJson ?? this.enderecoJson,
      updatedAt: updatedAt ?? this.updatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (cpfCnpj.present) {
      map['cpf_cnpj'] = Variable<String>(cpfCnpj.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (enderecoJson.present) {
      map['endereco_json'] = Variable<String>(enderecoJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedClientsCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('cpfCnpj: $cpfCnpj, ')
          ..write('email: $email, ')
          ..write('telefone: $telefone, ')
          ..write('enderecoJson: $enderecoJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedProductsTable extends CachedProducts
    with TableInfo<$CachedProductsTable, CachedProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descricaoMeta = const VerificationMeta(
    'descricao',
  );
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
    'descricao',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precoMeta = const VerificationMeta('preco');
  @override
  late final GeneratedColumn<double> preco = GeneratedColumn<double>(
    'preco',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('produto'),
  );
  static const VerificationMeta _unidadeMeta = const VerificationMeta(
    'unidade',
  );
  @override
  late final GeneratedColumn<String> unidade = GeneratedColumn<String>(
    'unidade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
    'ativo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ativo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    providerId,
    nome,
    descricao,
    preco,
    tipo,
    unidade,
    ativo,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(
        _descricaoMeta,
        descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta),
      );
    }
    if (data.containsKey('preco')) {
      context.handle(
        _precoMeta,
        preco.isAcceptableOrUnknown(data['preco']!, _precoMeta),
      );
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('unidade')) {
      context.handle(
        _unidadeMeta,
        unidade.isAcceptableOrUnknown(data['unidade']!, _unidadeMeta),
      );
    }
    if (data.containsKey('ativo')) {
      context.handle(
        _ativoMeta,
        ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      descricao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descricao'],
      ),
      preco: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}preco'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      unidade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unidade'],
      ),
      ativo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ativo'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $CachedProductsTable createAlias(String alias) {
    return $CachedProductsTable(attachedDatabase, alias);
  }
}

class CachedProduct extends DataClass implements Insertable<CachedProduct> {
  final String id;
  final String providerId;
  final String nome;
  final String? descricao;
  final double preco;
  final String tipo;
  final String? unidade;
  final bool ativo;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const CachedProduct({
    required this.id,
    required this.providerId,
    required this.nome,
    this.descricao,
    required this.preco,
    required this.tipo,
    this.unidade,
    required this.ativo,
    required this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider_id'] = Variable<String>(providerId);
    map['nome'] = Variable<String>(nome);
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    map['preco'] = Variable<double>(preco);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || unidade != null) {
      map['unidade'] = Variable<String>(unidade);
    }
    map['ativo'] = Variable<bool>(ativo);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedProductsCompanion toCompanion(bool nullToAbsent) {
    return CachedProductsCompanion(
      id: Value(id),
      providerId: Value(providerId),
      nome: Value(nome),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      preco: Value(preco),
      tipo: Value(tipo),
      unidade: unidade == null && nullToAbsent
          ? const Value.absent()
          : Value(unidade),
      ativo: Value(ativo),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProduct(
      id: serializer.fromJson<String>(json['id']),
      providerId: serializer.fromJson<String>(json['providerId']),
      nome: serializer.fromJson<String>(json['nome']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      preco: serializer.fromJson<double>(json['preco']),
      tipo: serializer.fromJson<String>(json['tipo']),
      unidade: serializer.fromJson<String?>(json['unidade']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'providerId': serializer.toJson<String>(providerId),
      'nome': serializer.toJson<String>(nome),
      'descricao': serializer.toJson<String?>(descricao),
      'preco': serializer.toJson<double>(preco),
      'tipo': serializer.toJson<String>(tipo),
      'unidade': serializer.toJson<String?>(unidade),
      'ativo': serializer.toJson<bool>(ativo),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedProduct copyWith({
    String? id,
    String? providerId,
    String? nome,
    Value<String?> descricao = const Value.absent(),
    double? preco,
    String? tipo,
    Value<String?> unidade = const Value.absent(),
    bool? ativo,
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedProduct(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    nome: nome ?? this.nome,
    descricao: descricao.present ? descricao.value : this.descricao,
    preco: preco ?? this.preco,
    tipo: tipo ?? this.tipo,
    unidade: unidade.present ? unidade.value : this.unidade,
    ativo: ativo ?? this.ativo,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedProduct copyWithCompanion(CachedProductsCompanion data) {
    return CachedProduct(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      nome: data.nome.present ? data.nome.value : this.nome,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      preco: data.preco.present ? data.preco.value : this.preco,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      unidade: data.unidade.present ? data.unidade.value : this.unidade,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProduct(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('preco: $preco, ')
          ..write('tipo: $tipo, ')
          ..write('unidade: $unidade, ')
          ..write('ativo: $ativo, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    providerId,
    nome,
    descricao,
    preco,
    tipo,
    unidade,
    ativo,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProduct &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.nome == this.nome &&
          other.descricao == this.descricao &&
          other.preco == this.preco &&
          other.tipo == this.tipo &&
          other.unidade == this.unidade &&
          other.ativo == this.ativo &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedProductsCompanion extends UpdateCompanion<CachedProduct> {
  final Value<String> id;
  final Value<String> providerId;
  final Value<String> nome;
  final Value<String?> descricao;
  final Value<double> preco;
  final Value<String> tipo;
  final Value<String?> unidade;
  final Value<bool> ativo;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedProductsCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.preco = const Value.absent(),
    this.tipo = const Value.absent(),
    this.unidade = const Value.absent(),
    this.ativo = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProductsCompanion.insert({
    required String id,
    required String providerId,
    required String nome,
    this.descricao = const Value.absent(),
    this.preco = const Value.absent(),
    this.tipo = const Value.absent(),
    this.unidade = const Value.absent(),
    this.ativo = const Value.absent(),
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerId = Value(providerId),
       nome = Value(nome),
       updatedAt = Value(updatedAt);
  static Insertable<CachedProduct> custom({
    Expression<String>? id,
    Expression<String>? providerId,
    Expression<String>? nome,
    Expression<String>? descricao,
    Expression<double>? preco,
    Expression<String>? tipo,
    Expression<String>? unidade,
    Expression<bool>? ativo,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (nome != null) 'nome': nome,
      if (descricao != null) 'descricao': descricao,
      if (preco != null) 'preco': preco,
      if (tipo != null) 'tipo': tipo,
      if (unidade != null) 'unidade': unidade,
      if (ativo != null) 'ativo': ativo,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? providerId,
    Value<String>? nome,
    Value<String?>? descricao,
    Value<double>? preco,
    Value<String>? tipo,
    Value<String?>? unidade,
    Value<bool>? ativo,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedProductsCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      tipo: tipo ?? this.tipo,
      unidade: unidade ?? this.unidade,
      ativo: ativo ?? this.ativo,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (preco.present) {
      map['preco'] = Variable<double>(preco.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (unidade.present) {
      map['unidade'] = Variable<String>(unidade.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedProductsCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('preco: $preco, ')
          ..write('tipo: $tipo, ')
          ..write('unidade: $unidade, ')
          ..write('ativo: $ativo, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedProposalsTable extends CachedProposals
    with TableInfo<$CachedProposalsTable, CachedProposal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProposalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('rascunho'),
  );
  static const VerificationMeta _itensJsonMeta = const VerificationMeta(
    'itensJson',
  );
  @override
  late final GeneratedColumn<String> itensJson = GeneratedColumn<String>(
    'itens_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descontoMeta = const VerificationMeta(
    'desconto',
  );
  @override
  late final GeneratedColumn<double> desconto = GeneratedColumn<double>(
    'desconto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _observacoesMeta = const VerificationMeta(
    'observacoes',
  );
  @override
  late final GeneratedColumn<String> observacoes = GeneratedColumn<String>(
    'observacoes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validadeMeta = const VerificationMeta(
    'validade',
  );
  @override
  late final GeneratedColumn<DateTime> validade = GeneratedColumn<DateTime>(
    'validade',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    providerId,
    clientId,
    status,
    itensJson,
    total,
    desconto,
    observacoes,
    validade,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_proposals';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProposal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('itens_json')) {
      context.handle(
        _itensJsonMeta,
        itensJson.isAcceptableOrUnknown(data['itens_json']!, _itensJsonMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('desconto')) {
      context.handle(
        _descontoMeta,
        desconto.isAcceptableOrUnknown(data['desconto']!, _descontoMeta),
      );
    }
    if (data.containsKey('observacoes')) {
      context.handle(
        _observacoesMeta,
        observacoes.isAcceptableOrUnknown(
          data['observacoes']!,
          _observacoesMeta,
        ),
      );
    }
    if (data.containsKey('validade')) {
      context.handle(
        _validadeMeta,
        validade.isAcceptableOrUnknown(data['validade']!, _validadeMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedProposal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProposal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      itensJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}itens_json'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      desconto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}desconto'],
      )!,
      observacoes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observacoes'],
      ),
      validade: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}validade'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $CachedProposalsTable createAlias(String alias) {
    return $CachedProposalsTable(attachedDatabase, alias);
  }
}

class CachedProposal extends DataClass implements Insertable<CachedProposal> {
  final String id;
  final String providerId;
  final String clientId;
  final String status;
  final String itensJson;
  final double total;
  final double desconto;
  final String? observacoes;
  final DateTime? validade;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const CachedProposal({
    required this.id,
    required this.providerId,
    required this.clientId,
    required this.status,
    required this.itensJson,
    required this.total,
    required this.desconto,
    this.observacoes,
    this.validade,
    required this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider_id'] = Variable<String>(providerId);
    map['client_id'] = Variable<String>(clientId);
    map['status'] = Variable<String>(status);
    map['itens_json'] = Variable<String>(itensJson);
    map['total'] = Variable<double>(total);
    map['desconto'] = Variable<double>(desconto);
    if (!nullToAbsent || observacoes != null) {
      map['observacoes'] = Variable<String>(observacoes);
    }
    if (!nullToAbsent || validade != null) {
      map['validade'] = Variable<DateTime>(validade);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedProposalsCompanion toCompanion(bool nullToAbsent) {
    return CachedProposalsCompanion(
      id: Value(id),
      providerId: Value(providerId),
      clientId: Value(clientId),
      status: Value(status),
      itensJson: Value(itensJson),
      total: Value(total),
      desconto: Value(desconto),
      observacoes: observacoes == null && nullToAbsent
          ? const Value.absent()
          : Value(observacoes),
      validade: validade == null && nullToAbsent
          ? const Value.absent()
          : Value(validade),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedProposal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProposal(
      id: serializer.fromJson<String>(json['id']),
      providerId: serializer.fromJson<String>(json['providerId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      status: serializer.fromJson<String>(json['status']),
      itensJson: serializer.fromJson<String>(json['itensJson']),
      total: serializer.fromJson<double>(json['total']),
      desconto: serializer.fromJson<double>(json['desconto']),
      observacoes: serializer.fromJson<String?>(json['observacoes']),
      validade: serializer.fromJson<DateTime?>(json['validade']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'providerId': serializer.toJson<String>(providerId),
      'clientId': serializer.toJson<String>(clientId),
      'status': serializer.toJson<String>(status),
      'itensJson': serializer.toJson<String>(itensJson),
      'total': serializer.toJson<double>(total),
      'desconto': serializer.toJson<double>(desconto),
      'observacoes': serializer.toJson<String?>(observacoes),
      'validade': serializer.toJson<DateTime?>(validade),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedProposal copyWith({
    String? id,
    String? providerId,
    String? clientId,
    String? status,
    String? itensJson,
    double? total,
    double? desconto,
    Value<String?> observacoes = const Value.absent(),
    Value<DateTime?> validade = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedProposal(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    clientId: clientId ?? this.clientId,
    status: status ?? this.status,
    itensJson: itensJson ?? this.itensJson,
    total: total ?? this.total,
    desconto: desconto ?? this.desconto,
    observacoes: observacoes.present ? observacoes.value : this.observacoes,
    validade: validade.present ? validade.value : this.validade,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedProposal copyWithCompanion(CachedProposalsCompanion data) {
    return CachedProposal(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      status: data.status.present ? data.status.value : this.status,
      itensJson: data.itensJson.present ? data.itensJson.value : this.itensJson,
      total: data.total.present ? data.total.value : this.total,
      desconto: data.desconto.present ? data.desconto.value : this.desconto,
      observacoes: data.observacoes.present
          ? data.observacoes.value
          : this.observacoes,
      validade: data.validade.present ? data.validade.value : this.validade,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProposal(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('clientId: $clientId, ')
          ..write('status: $status, ')
          ..write('itensJson: $itensJson, ')
          ..write('total: $total, ')
          ..write('desconto: $desconto, ')
          ..write('observacoes: $observacoes, ')
          ..write('validade: $validade, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    providerId,
    clientId,
    status,
    itensJson,
    total,
    desconto,
    observacoes,
    validade,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProposal &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.clientId == this.clientId &&
          other.status == this.status &&
          other.itensJson == this.itensJson &&
          other.total == this.total &&
          other.desconto == this.desconto &&
          other.observacoes == this.observacoes &&
          other.validade == this.validade &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedProposalsCompanion extends UpdateCompanion<CachedProposal> {
  final Value<String> id;
  final Value<String> providerId;
  final Value<String> clientId;
  final Value<String> status;
  final Value<String> itensJson;
  final Value<double> total;
  final Value<double> desconto;
  final Value<String?> observacoes;
  final Value<DateTime?> validade;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedProposalsCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.status = const Value.absent(),
    this.itensJson = const Value.absent(),
    this.total = const Value.absent(),
    this.desconto = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.validade = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProposalsCompanion.insert({
    required String id,
    required String providerId,
    required String clientId,
    this.status = const Value.absent(),
    this.itensJson = const Value.absent(),
    this.total = const Value.absent(),
    this.desconto = const Value.absent(),
    this.observacoes = const Value.absent(),
    this.validade = const Value.absent(),
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerId = Value(providerId),
       clientId = Value(clientId),
       updatedAt = Value(updatedAt);
  static Insertable<CachedProposal> custom({
    Expression<String>? id,
    Expression<String>? providerId,
    Expression<String>? clientId,
    Expression<String>? status,
    Expression<String>? itensJson,
    Expression<double>? total,
    Expression<double>? desconto,
    Expression<String>? observacoes,
    Expression<DateTime>? validade,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (clientId != null) 'client_id': clientId,
      if (status != null) 'status': status,
      if (itensJson != null) 'itens_json': itensJson,
      if (total != null) 'total': total,
      if (desconto != null) 'desconto': desconto,
      if (observacoes != null) 'observacoes': observacoes,
      if (validade != null) 'validade': validade,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProposalsCompanion copyWith({
    Value<String>? id,
    Value<String>? providerId,
    Value<String>? clientId,
    Value<String>? status,
    Value<String>? itensJson,
    Value<double>? total,
    Value<double>? desconto,
    Value<String?>? observacoes,
    Value<DateTime?>? validade,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedProposalsCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      clientId: clientId ?? this.clientId,
      status: status ?? this.status,
      itensJson: itensJson ?? this.itensJson,
      total: total ?? this.total,
      desconto: desconto ?? this.desconto,
      observacoes: observacoes ?? this.observacoes,
      validade: validade ?? this.validade,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (itensJson.present) {
      map['itens_json'] = Variable<String>(itensJson.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (desconto.present) {
      map['desconto'] = Variable<double>(desconto.value);
    }
    if (observacoes.present) {
      map['observacoes'] = Variable<String>(observacoes.value);
    }
    if (validade.present) {
      map['validade'] = Variable<DateTime>(validade.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedProposalsCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('clientId: $clientId, ')
          ..write('status: $status, ')
          ..write('itensJson: $itensJson, ')
          ..write('total: $total, ')
          ..write('desconto: $desconto, ')
          ..write('observacoes: $observacoes, ')
          ..write('validade: $validade, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedProvidersTable cachedProviders = $CachedProvidersTable(
    this,
  );
  late final $CachedClientsTable cachedClients = $CachedClientsTable(this);
  late final $CachedProductsTable cachedProducts = $CachedProductsTable(this);
  late final $CachedProposalsTable cachedProposals = $CachedProposalsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedProviders,
    cachedClients,
    cachedProducts,
    cachedProposals,
  ];
}

typedef $$CachedProvidersTableCreateCompanionBuilder =
    CachedProvidersCompanion Function({
      required String id,
      required String empresa,
      required String razaoSocial,
      required String cnpj,
      Value<String?> logoUrl,
      Value<String?> corMarca,
      Value<String?> dataJson,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedProvidersTableUpdateCompanionBuilder =
    CachedProvidersCompanion Function({
      Value<String> id,
      Value<String> empresa,
      Value<String> razaoSocial,
      Value<String> cnpj,
      Value<String?> logoUrl,
      Value<String?> corMarca,
      Value<String?> dataJson,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $CachedProvidersTable> {
  $$CachedProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get empresa => $composableBuilder(
    column: $table.empresa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get razaoSocial => $composableBuilder(
    column: $table.razaoSocial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get corMarca => $composableBuilder(
    column: $table.corMarca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedProvidersTable> {
  $$CachedProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get empresa => $composableBuilder(
    column: $table.empresa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get razaoSocial => $composableBuilder(
    column: $table.razaoSocial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get corMarca => $composableBuilder(
    column: $table.corMarca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedProvidersTable> {
  $$CachedProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get empresa =>
      $composableBuilder(column: $table.empresa, builder: (column) => column);

  GeneratedColumn<String> get razaoSocial => $composableBuilder(
    column: $table.razaoSocial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get corMarca =>
      $composableBuilder(column: $table.corMarca, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedProvidersTable,
          CachedProvider,
          $$CachedProvidersTableFilterComposer,
          $$CachedProvidersTableOrderingComposer,
          $$CachedProvidersTableAnnotationComposer,
          $$CachedProvidersTableCreateCompanionBuilder,
          $$CachedProvidersTableUpdateCompanionBuilder,
          (
            CachedProvider,
            BaseReferences<
              _$AppDatabase,
              $CachedProvidersTable,
              CachedProvider
            >,
          ),
          CachedProvider,
          PrefetchHooks Function()
        > {
  $$CachedProvidersTableTableManager(
    _$AppDatabase db,
    $CachedProvidersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> empresa = const Value.absent(),
                Value<String> razaoSocial = const Value.absent(),
                Value<String> cnpj = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> corMarca = const Value.absent(),
                Value<String?> dataJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProvidersCompanion(
                id: id,
                empresa: empresa,
                razaoSocial: razaoSocial,
                cnpj: cnpj,
                logoUrl: logoUrl,
                corMarca: corMarca,
                dataJson: dataJson,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String empresa,
                required String razaoSocial,
                required String cnpj,
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> corMarca = const Value.absent(),
                Value<String?> dataJson = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProvidersCompanion.insert(
                id: id,
                empresa: empresa,
                razaoSocial: razaoSocial,
                cnpj: cnpj,
                logoUrl: logoUrl,
                corMarca: corMarca,
                dataJson: dataJson,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedProvidersTable,
      CachedProvider,
      $$CachedProvidersTableFilterComposer,
      $$CachedProvidersTableOrderingComposer,
      $$CachedProvidersTableAnnotationComposer,
      $$CachedProvidersTableCreateCompanionBuilder,
      $$CachedProvidersTableUpdateCompanionBuilder,
      (
        CachedProvider,
        BaseReferences<_$AppDatabase, $CachedProvidersTable, CachedProvider>,
      ),
      CachedProvider,
      PrefetchHooks Function()
    >;
typedef $$CachedClientsTableCreateCompanionBuilder =
    CachedClientsCompanion Function({
      required String id,
      required String providerId,
      required String nome,
      required String cpfCnpj,
      Value<String?> email,
      Value<String?> telefone,
      Value<String?> enderecoJson,
      required DateTime updatedAt,
      Value<DateTime?> archivedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedClientsTableUpdateCompanionBuilder =
    CachedClientsCompanion Function({
      Value<String> id,
      Value<String> providerId,
      Value<String> nome,
      Value<String> cpfCnpj,
      Value<String?> email,
      Value<String?> telefone,
      Value<String?> enderecoJson,
      Value<DateTime> updatedAt,
      Value<DateTime?> archivedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedClientsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedClientsTable> {
  $$CachedClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cpfCnpj => $composableBuilder(
    column: $table.cpfCnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefone => $composableBuilder(
    column: $table.telefone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enderecoJson => $composableBuilder(
    column: $table.enderecoJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedClientsTable> {
  $$CachedClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cpfCnpj => $composableBuilder(
    column: $table.cpfCnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefone => $composableBuilder(
    column: $table.telefone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enderecoJson => $composableBuilder(
    column: $table.enderecoJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedClientsTable> {
  $$CachedClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get cpfCnpj =>
      $composableBuilder(column: $table.cpfCnpj, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get telefone =>
      $composableBuilder(column: $table.telefone, builder: (column) => column);

  GeneratedColumn<String> get enderecoJson => $composableBuilder(
    column: $table.enderecoJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedClientsTable,
          CachedClient,
          $$CachedClientsTableFilterComposer,
          $$CachedClientsTableOrderingComposer,
          $$CachedClientsTableAnnotationComposer,
          $$CachedClientsTableCreateCompanionBuilder,
          $$CachedClientsTableUpdateCompanionBuilder,
          (
            CachedClient,
            BaseReferences<_$AppDatabase, $CachedClientsTable, CachedClient>,
          ),
          CachedClient,
          PrefetchHooks Function()
        > {
  $$CachedClientsTableTableManager(_$AppDatabase db, $CachedClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerId = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> cpfCnpj = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> telefone = const Value.absent(),
                Value<String?> enderecoJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedClientsCompanion(
                id: id,
                providerId: providerId,
                nome: nome,
                cpfCnpj: cpfCnpj,
                email: email,
                telefone: telefone,
                enderecoJson: enderecoJson,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String providerId,
                required String nome,
                required String cpfCnpj,
                Value<String?> email = const Value.absent(),
                Value<String?> telefone = const Value.absent(),
                Value<String?> enderecoJson = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedClientsCompanion.insert(
                id: id,
                providerId: providerId,
                nome: nome,
                cpfCnpj: cpfCnpj,
                email: email,
                telefone: telefone,
                enderecoJson: enderecoJson,
                updatedAt: updatedAt,
                archivedAt: archivedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedClientsTable,
      CachedClient,
      $$CachedClientsTableFilterComposer,
      $$CachedClientsTableOrderingComposer,
      $$CachedClientsTableAnnotationComposer,
      $$CachedClientsTableCreateCompanionBuilder,
      $$CachedClientsTableUpdateCompanionBuilder,
      (
        CachedClient,
        BaseReferences<_$AppDatabase, $CachedClientsTable, CachedClient>,
      ),
      CachedClient,
      PrefetchHooks Function()
    >;
typedef $$CachedProductsTableCreateCompanionBuilder =
    CachedProductsCompanion Function({
      required String id,
      required String providerId,
      required String nome,
      Value<String?> descricao,
      Value<double> preco,
      Value<String> tipo,
      Value<String?> unidade,
      Value<bool> ativo,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedProductsTableUpdateCompanionBuilder =
    CachedProductsCompanion Function({
      Value<String> id,
      Value<String> providerId,
      Value<String> nome,
      Value<String?> descricao,
      Value<double> preco,
      Value<String> tipo,
      Value<String?> unidade,
      Value<bool> ativo,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedProductsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedProductsTable> {
  $$CachedProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descricao => $composableBuilder(
    column: $table.descricao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get preco => $composableBuilder(
    column: $table.preco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unidade => $composableBuilder(
    column: $table.unidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ativo => $composableBuilder(
    column: $table.ativo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedProductsTable> {
  $$CachedProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descricao => $composableBuilder(
    column: $table.descricao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get preco => $composableBuilder(
    column: $table.preco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unidade => $composableBuilder(
    column: $table.unidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ativo => $composableBuilder(
    column: $table.ativo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedProductsTable> {
  $$CachedProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get descricao =>
      $composableBuilder(column: $table.descricao, builder: (column) => column);

  GeneratedColumn<double> get preco =>
      $composableBuilder(column: $table.preco, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get unidade =>
      $composableBuilder(column: $table.unidade, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedProductsTable,
          CachedProduct,
          $$CachedProductsTableFilterComposer,
          $$CachedProductsTableOrderingComposer,
          $$CachedProductsTableAnnotationComposer,
          $$CachedProductsTableCreateCompanionBuilder,
          $$CachedProductsTableUpdateCompanionBuilder,
          (
            CachedProduct,
            BaseReferences<_$AppDatabase, $CachedProductsTable, CachedProduct>,
          ),
          CachedProduct,
          PrefetchHooks Function()
        > {
  $$CachedProductsTableTableManager(
    _$AppDatabase db,
    $CachedProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerId = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String?> descricao = const Value.absent(),
                Value<double> preco = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String?> unidade = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProductsCompanion(
                id: id,
                providerId: providerId,
                nome: nome,
                descricao: descricao,
                preco: preco,
                tipo: tipo,
                unidade: unidade,
                ativo: ativo,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String providerId,
                required String nome,
                Value<String?> descricao = const Value.absent(),
                Value<double> preco = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String?> unidade = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProductsCompanion.insert(
                id: id,
                providerId: providerId,
                nome: nome,
                descricao: descricao,
                preco: preco,
                tipo: tipo,
                unidade: unidade,
                ativo: ativo,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedProductsTable,
      CachedProduct,
      $$CachedProductsTableFilterComposer,
      $$CachedProductsTableOrderingComposer,
      $$CachedProductsTableAnnotationComposer,
      $$CachedProductsTableCreateCompanionBuilder,
      $$CachedProductsTableUpdateCompanionBuilder,
      (
        CachedProduct,
        BaseReferences<_$AppDatabase, $CachedProductsTable, CachedProduct>,
      ),
      CachedProduct,
      PrefetchHooks Function()
    >;
typedef $$CachedProposalsTableCreateCompanionBuilder =
    CachedProposalsCompanion Function({
      required String id,
      required String providerId,
      required String clientId,
      Value<String> status,
      Value<String> itensJson,
      Value<double> total,
      Value<double> desconto,
      Value<String?> observacoes,
      Value<DateTime?> validade,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedProposalsTableUpdateCompanionBuilder =
    CachedProposalsCompanion Function({
      Value<String> id,
      Value<String> providerId,
      Value<String> clientId,
      Value<String> status,
      Value<String> itensJson,
      Value<double> total,
      Value<double> desconto,
      Value<String?> observacoes,
      Value<DateTime?> validade,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedProposalsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedProposalsTable> {
  $$CachedProposalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itensJson => $composableBuilder(
    column: $table.itensJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get desconto => $composableBuilder(
    column: $table.desconto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observacoes => $composableBuilder(
    column: $table.observacoes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validade => $composableBuilder(
    column: $table.validade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedProposalsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedProposalsTable> {
  $$CachedProposalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itensJson => $composableBuilder(
    column: $table.itensJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get desconto => $composableBuilder(
    column: $table.desconto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observacoes => $composableBuilder(
    column: $table.observacoes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validade => $composableBuilder(
    column: $table.validade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedProposalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedProposalsTable> {
  $$CachedProposalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
    column: $table.providerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get itensJson =>
      $composableBuilder(column: $table.itensJson, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get desconto =>
      $composableBuilder(column: $table.desconto, builder: (column) => column);

  GeneratedColumn<String> get observacoes => $composableBuilder(
    column: $table.observacoes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get validade =>
      $composableBuilder(column: $table.validade, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedProposalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedProposalsTable,
          CachedProposal,
          $$CachedProposalsTableFilterComposer,
          $$CachedProposalsTableOrderingComposer,
          $$CachedProposalsTableAnnotationComposer,
          $$CachedProposalsTableCreateCompanionBuilder,
          $$CachedProposalsTableUpdateCompanionBuilder,
          (
            CachedProposal,
            BaseReferences<
              _$AppDatabase,
              $CachedProposalsTable,
              CachedProposal
            >,
          ),
          CachedProposal,
          PrefetchHooks Function()
        > {
  $$CachedProposalsTableTableManager(
    _$AppDatabase db,
    $CachedProposalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProposalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedProposalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedProposalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> itensJson = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> desconto = const Value.absent(),
                Value<String?> observacoes = const Value.absent(),
                Value<DateTime?> validade = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProposalsCompanion(
                id: id,
                providerId: providerId,
                clientId: clientId,
                status: status,
                itensJson: itensJson,
                total: total,
                desconto: desconto,
                observacoes: observacoes,
                validade: validade,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String providerId,
                required String clientId,
                Value<String> status = const Value.absent(),
                Value<String> itensJson = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> desconto = const Value.absent(),
                Value<String?> observacoes = const Value.absent(),
                Value<DateTime?> validade = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProposalsCompanion.insert(
                id: id,
                providerId: providerId,
                clientId: clientId,
                status: status,
                itensJson: itensJson,
                total: total,
                desconto: desconto,
                observacoes: observacoes,
                validade: validade,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedProposalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedProposalsTable,
      CachedProposal,
      $$CachedProposalsTableFilterComposer,
      $$CachedProposalsTableOrderingComposer,
      $$CachedProposalsTableAnnotationComposer,
      $$CachedProposalsTableCreateCompanionBuilder,
      $$CachedProposalsTableUpdateCompanionBuilder,
      (
        CachedProposal,
        BaseReferences<_$AppDatabase, $CachedProposalsTable, CachedProposal>,
      ),
      CachedProposal,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedProvidersTableTableManager get cachedProviders =>
      $$CachedProvidersTableTableManager(_db, _db.cachedProviders);
  $$CachedClientsTableTableManager get cachedClients =>
      $$CachedClientsTableTableManager(_db, _db.cachedClients);
  $$CachedProductsTableTableManager get cachedProducts =>
      $$CachedProductsTableTableManager(_db, _db.cachedProducts);
  $$CachedProposalsTableTableManager get cachedProposals =>
      $$CachedProposalsTableTableManager(_db, _db.cachedProposals);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
