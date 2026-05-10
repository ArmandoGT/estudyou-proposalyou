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
    archivedAt,
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
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
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
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
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
  final DateTime? archivedAt;
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
    this.archivedAt,
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
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
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
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
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
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
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
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
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
    Value<DateTime?> archivedAt = const Value.absent(),
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
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
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
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
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
          ..write('archivedAt: $archivedAt, ')
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
    archivedAt,
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
          other.archivedAt == this.archivedAt &&
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
  final Value<DateTime?> archivedAt;
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
    this.archivedAt = const Value.absent(),
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
    this.archivedAt = const Value.absent(),
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
    Expression<DateTime>? archivedAt,
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
      if (archivedAt != null) 'archived_at': archivedAt,
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
    Value<DateTime?>? archivedAt,
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
      archivedAt: archivedAt ?? this.archivedAt,
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
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
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
          ..write('archivedAt: $archivedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedProposalTemplatesTable extends CachedProposalTemplates
    with TableInfo<$CachedProposalTemplatesTable, CachedProposalTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProposalTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _corpoJsonMeta = const VerificationMeta(
    'corpoJson',
  );
  @override
  late final GeneratedColumn<String> corpoJson = GeneratedColumn<String>(
    'corpo_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    corpoJson,
    ativo,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_proposal_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProposalTemplate> instance, {
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
    if (data.containsKey('corpo_json')) {
      context.handle(
        _corpoJsonMeta,
        corpoJson.isAcceptableOrUnknown(data['corpo_json']!, _corpoJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_corpoJsonMeta);
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
  CachedProposalTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProposalTemplate(
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
      corpoJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}corpo_json'],
      )!,
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
  $CachedProposalTemplatesTable createAlias(String alias) {
    return $CachedProposalTemplatesTable(attachedDatabase, alias);
  }
}

class CachedProposalTemplate extends DataClass
    implements Insertable<CachedProposalTemplate> {
  final String id;
  final String providerId;
  final String nome;
  final String corpoJson;
  final bool ativo;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const CachedProposalTemplate({
    required this.id,
    required this.providerId,
    required this.nome,
    required this.corpoJson,
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
    map['corpo_json'] = Variable<String>(corpoJson);
    map['ativo'] = Variable<bool>(ativo);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedProposalTemplatesCompanion toCompanion(bool nullToAbsent) {
    return CachedProposalTemplatesCompanion(
      id: Value(id),
      providerId: Value(providerId),
      nome: Value(nome),
      corpoJson: Value(corpoJson),
      ativo: Value(ativo),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedProposalTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProposalTemplate(
      id: serializer.fromJson<String>(json['id']),
      providerId: serializer.fromJson<String>(json['providerId']),
      nome: serializer.fromJson<String>(json['nome']),
      corpoJson: serializer.fromJson<String>(json['corpoJson']),
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
      'corpoJson': serializer.toJson<String>(corpoJson),
      'ativo': serializer.toJson<bool>(ativo),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedProposalTemplate copyWith({
    String? id,
    String? providerId,
    String? nome,
    String? corpoJson,
    bool? ativo,
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedProposalTemplate(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    nome: nome ?? this.nome,
    corpoJson: corpoJson ?? this.corpoJson,
    ativo: ativo ?? this.ativo,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedProposalTemplate copyWithCompanion(
    CachedProposalTemplatesCompanion data,
  ) {
    return CachedProposalTemplate(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      nome: data.nome.present ? data.nome.value : this.nome,
      corpoJson: data.corpoJson.present ? data.corpoJson.value : this.corpoJson,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProposalTemplate(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('corpoJson: $corpoJson, ')
          ..write('ativo: $ativo, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, providerId, nome, corpoJson, ativo, updatedAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProposalTemplate &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.nome == this.nome &&
          other.corpoJson == this.corpoJson &&
          other.ativo == this.ativo &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedProposalTemplatesCompanion
    extends UpdateCompanion<CachedProposalTemplate> {
  final Value<String> id;
  final Value<String> providerId;
  final Value<String> nome;
  final Value<String> corpoJson;
  final Value<bool> ativo;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedProposalTemplatesCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.nome = const Value.absent(),
    this.corpoJson = const Value.absent(),
    this.ativo = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProposalTemplatesCompanion.insert({
    required String id,
    required String providerId,
    required String nome,
    required String corpoJson,
    this.ativo = const Value.absent(),
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerId = Value(providerId),
       nome = Value(nome),
       corpoJson = Value(corpoJson),
       updatedAt = Value(updatedAt);
  static Insertable<CachedProposalTemplate> custom({
    Expression<String>? id,
    Expression<String>? providerId,
    Expression<String>? nome,
    Expression<String>? corpoJson,
    Expression<bool>? ativo,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (nome != null) 'nome': nome,
      if (corpoJson != null) 'corpo_json': corpoJson,
      if (ativo != null) 'ativo': ativo,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProposalTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? providerId,
    Value<String>? nome,
    Value<String>? corpoJson,
    Value<bool>? ativo,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedProposalTemplatesCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      nome: nome ?? this.nome,
      corpoJson: corpoJson ?? this.corpoJson,
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
    if (corpoJson.present) {
      map['corpo_json'] = Variable<String>(corpoJson.value);
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
    return (StringBuffer('CachedProposalTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('corpoJson: $corpoJson, ')
          ..write('ativo: $ativo, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedContractsTable extends CachedContracts
    with TableInfo<$CachedContractsTable, CachedContract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedContractsTable(this.attachedDatabase, [this._alias]);
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
    defaultValue: const Constant('minuta'),
  );
  static const VerificationMeta _textoFinalMeta = const VerificationMeta(
    'textoFinal',
  );
  @override
  late final GeneratedColumn<String> textoFinal = GeneratedColumn<String>(
    'texto_final',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proposalIdMeta = const VerificationMeta(
    'proposalId',
  );
  @override
  late final GeneratedColumn<String> proposalId = GeneratedColumn<String>(
    'proposal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vigenciaInicioMeta = const VerificationMeta(
    'vigenciaInicio',
  );
  @override
  late final GeneratedColumn<DateTime> vigenciaInicio =
      GeneratedColumn<DateTime>(
        'vigencia_inicio',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _vigenciaFimMeta = const VerificationMeta(
    'vigenciaFim',
  );
  @override
  late final GeneratedColumn<DateTime> vigenciaFim = GeneratedColumn<DateTime>(
    'vigencia_fim',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shareTokenMeta = const VerificationMeta(
    'shareToken',
  );
  @override
  late final GeneratedColumn<String> shareToken = GeneratedColumn<String>(
    'share_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pdfUrlMeta = const VerificationMeta('pdfUrl');
  @override
  late final GeneratedColumn<String> pdfUrl = GeneratedColumn<String>(
    'pdf_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hashDocumentoMeta = const VerificationMeta(
    'hashDocumento',
  );
  @override
  late final GeneratedColumn<String> hashDocumento = GeneratedColumn<String>(
    'hash_documento',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalSignatariosMeta = const VerificationMeta(
    'totalSignatarios',
  );
  @override
  late final GeneratedColumn<int> totalSignatarios = GeneratedColumn<int>(
    'total_signatarios',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _linkAssinaturaMeta = const VerificationMeta(
    'linkAssinatura',
  );
  @override
  late final GeneratedColumn<String> linkAssinatura = GeneratedColumn<String>(
    'link_assinatura',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clienteNomeMeta = const VerificationMeta(
    'clienteNome',
  );
  @override
  late final GeneratedColumn<String> clienteNome = GeneratedColumn<String>(
    'cliente_nome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assinaturasRealizadasMeta =
      const VerificationMeta('assinaturasRealizadas');
  @override
  late final GeneratedColumn<int> assinaturasRealizadas = GeneratedColumn<int>(
    'assinaturas_realizadas',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    textoFinal,
    proposalId,
    templateId,
    vigenciaInicio,
    vigenciaFim,
    shareToken,
    pdfUrl,
    hashDocumento,
    totalSignatarios,
    linkAssinatura,
    clienteNome,
    assinaturasRealizadas,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_contracts';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedContract> instance, {
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
    if (data.containsKey('texto_final')) {
      context.handle(
        _textoFinalMeta,
        textoFinal.isAcceptableOrUnknown(data['texto_final']!, _textoFinalMeta),
      );
    }
    if (data.containsKey('proposal_id')) {
      context.handle(
        _proposalIdMeta,
        proposalId.isAcceptableOrUnknown(data['proposal_id']!, _proposalIdMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('vigencia_inicio')) {
      context.handle(
        _vigenciaInicioMeta,
        vigenciaInicio.isAcceptableOrUnknown(
          data['vigencia_inicio']!,
          _vigenciaInicioMeta,
        ),
      );
    }
    if (data.containsKey('vigencia_fim')) {
      context.handle(
        _vigenciaFimMeta,
        vigenciaFim.isAcceptableOrUnknown(
          data['vigencia_fim']!,
          _vigenciaFimMeta,
        ),
      );
    }
    if (data.containsKey('share_token')) {
      context.handle(
        _shareTokenMeta,
        shareToken.isAcceptableOrUnknown(data['share_token']!, _shareTokenMeta),
      );
    }
    if (data.containsKey('pdf_url')) {
      context.handle(
        _pdfUrlMeta,
        pdfUrl.isAcceptableOrUnknown(data['pdf_url']!, _pdfUrlMeta),
      );
    }
    if (data.containsKey('hash_documento')) {
      context.handle(
        _hashDocumentoMeta,
        hashDocumento.isAcceptableOrUnknown(
          data['hash_documento']!,
          _hashDocumentoMeta,
        ),
      );
    }
    if (data.containsKey('total_signatarios')) {
      context.handle(
        _totalSignatariosMeta,
        totalSignatarios.isAcceptableOrUnknown(
          data['total_signatarios']!,
          _totalSignatariosMeta,
        ),
      );
    }
    if (data.containsKey('link_assinatura')) {
      context.handle(
        _linkAssinaturaMeta,
        linkAssinatura.isAcceptableOrUnknown(
          data['link_assinatura']!,
          _linkAssinaturaMeta,
        ),
      );
    }
    if (data.containsKey('cliente_nome')) {
      context.handle(
        _clienteNomeMeta,
        clienteNome.isAcceptableOrUnknown(
          data['cliente_nome']!,
          _clienteNomeMeta,
        ),
      );
    }
    if (data.containsKey('assinaturas_realizadas')) {
      context.handle(
        _assinaturasRealizadasMeta,
        assinaturasRealizadas.isAcceptableOrUnknown(
          data['assinaturas_realizadas']!,
          _assinaturasRealizadasMeta,
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
  CachedContract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedContract(
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
      textoFinal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}texto_final'],
      ),
      proposalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposal_id'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      vigenciaInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}vigencia_inicio'],
      ),
      vigenciaFim: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}vigencia_fim'],
      ),
      shareToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}share_token'],
      ),
      pdfUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_url'],
      ),
      hashDocumento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash_documento'],
      ),
      totalSignatarios: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_signatarios'],
      )!,
      linkAssinatura: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link_assinatura'],
      ),
      clienteNome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_nome'],
      ),
      assinaturasRealizadas: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assinaturas_realizadas'],
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
  $CachedContractsTable createAlias(String alias) {
    return $CachedContractsTable(attachedDatabase, alias);
  }
}

class CachedContract extends DataClass implements Insertable<CachedContract> {
  final String id;
  final String providerId;
  final String clientId;
  final String status;
  final String? textoFinal;
  final String? proposalId;
  final String? templateId;
  final DateTime? vigenciaInicio;
  final DateTime? vigenciaFim;
  final String? shareToken;
  final String? pdfUrl;
  final String? hashDocumento;
  final int totalSignatarios;
  final String? linkAssinatura;
  final String? clienteNome;
  final int? assinaturasRealizadas;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const CachedContract({
    required this.id,
    required this.providerId,
    required this.clientId,
    required this.status,
    this.textoFinal,
    this.proposalId,
    this.templateId,
    this.vigenciaInicio,
    this.vigenciaFim,
    this.shareToken,
    this.pdfUrl,
    this.hashDocumento,
    required this.totalSignatarios,
    this.linkAssinatura,
    this.clienteNome,
    this.assinaturasRealizadas,
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
    if (!nullToAbsent || textoFinal != null) {
      map['texto_final'] = Variable<String>(textoFinal);
    }
    if (!nullToAbsent || proposalId != null) {
      map['proposal_id'] = Variable<String>(proposalId);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    if (!nullToAbsent || vigenciaInicio != null) {
      map['vigencia_inicio'] = Variable<DateTime>(vigenciaInicio);
    }
    if (!nullToAbsent || vigenciaFim != null) {
      map['vigencia_fim'] = Variable<DateTime>(vigenciaFim);
    }
    if (!nullToAbsent || shareToken != null) {
      map['share_token'] = Variable<String>(shareToken);
    }
    if (!nullToAbsent || pdfUrl != null) {
      map['pdf_url'] = Variable<String>(pdfUrl);
    }
    if (!nullToAbsent || hashDocumento != null) {
      map['hash_documento'] = Variable<String>(hashDocumento);
    }
    map['total_signatarios'] = Variable<int>(totalSignatarios);
    if (!nullToAbsent || linkAssinatura != null) {
      map['link_assinatura'] = Variable<String>(linkAssinatura);
    }
    if (!nullToAbsent || clienteNome != null) {
      map['cliente_nome'] = Variable<String>(clienteNome);
    }
    if (!nullToAbsent || assinaturasRealizadas != null) {
      map['assinaturas_realizadas'] = Variable<int>(assinaturasRealizadas);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedContractsCompanion toCompanion(bool nullToAbsent) {
    return CachedContractsCompanion(
      id: Value(id),
      providerId: Value(providerId),
      clientId: Value(clientId),
      status: Value(status),
      textoFinal: textoFinal == null && nullToAbsent
          ? const Value.absent()
          : Value(textoFinal),
      proposalId: proposalId == null && nullToAbsent
          ? const Value.absent()
          : Value(proposalId),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      vigenciaInicio: vigenciaInicio == null && nullToAbsent
          ? const Value.absent()
          : Value(vigenciaInicio),
      vigenciaFim: vigenciaFim == null && nullToAbsent
          ? const Value.absent()
          : Value(vigenciaFim),
      shareToken: shareToken == null && nullToAbsent
          ? const Value.absent()
          : Value(shareToken),
      pdfUrl: pdfUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfUrl),
      hashDocumento: hashDocumento == null && nullToAbsent
          ? const Value.absent()
          : Value(hashDocumento),
      totalSignatarios: Value(totalSignatarios),
      linkAssinatura: linkAssinatura == null && nullToAbsent
          ? const Value.absent()
          : Value(linkAssinatura),
      clienteNome: clienteNome == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteNome),
      assinaturasRealizadas: assinaturasRealizadas == null && nullToAbsent
          ? const Value.absent()
          : Value(assinaturasRealizadas),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedContract.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedContract(
      id: serializer.fromJson<String>(json['id']),
      providerId: serializer.fromJson<String>(json['providerId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      status: serializer.fromJson<String>(json['status']),
      textoFinal: serializer.fromJson<String?>(json['textoFinal']),
      proposalId: serializer.fromJson<String?>(json['proposalId']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      vigenciaInicio: serializer.fromJson<DateTime?>(json['vigenciaInicio']),
      vigenciaFim: serializer.fromJson<DateTime?>(json['vigenciaFim']),
      shareToken: serializer.fromJson<String?>(json['shareToken']),
      pdfUrl: serializer.fromJson<String?>(json['pdfUrl']),
      hashDocumento: serializer.fromJson<String?>(json['hashDocumento']),
      totalSignatarios: serializer.fromJson<int>(json['totalSignatarios']),
      linkAssinatura: serializer.fromJson<String?>(json['linkAssinatura']),
      clienteNome: serializer.fromJson<String?>(json['clienteNome']),
      assinaturasRealizadas: serializer.fromJson<int?>(
        json['assinaturasRealizadas'],
      ),
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
      'textoFinal': serializer.toJson<String?>(textoFinal),
      'proposalId': serializer.toJson<String?>(proposalId),
      'templateId': serializer.toJson<String?>(templateId),
      'vigenciaInicio': serializer.toJson<DateTime?>(vigenciaInicio),
      'vigenciaFim': serializer.toJson<DateTime?>(vigenciaFim),
      'shareToken': serializer.toJson<String?>(shareToken),
      'pdfUrl': serializer.toJson<String?>(pdfUrl),
      'hashDocumento': serializer.toJson<String?>(hashDocumento),
      'totalSignatarios': serializer.toJson<int>(totalSignatarios),
      'linkAssinatura': serializer.toJson<String?>(linkAssinatura),
      'clienteNome': serializer.toJson<String?>(clienteNome),
      'assinaturasRealizadas': serializer.toJson<int?>(assinaturasRealizadas),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedContract copyWith({
    String? id,
    String? providerId,
    String? clientId,
    String? status,
    Value<String?> textoFinal = const Value.absent(),
    Value<String?> proposalId = const Value.absent(),
    Value<String?> templateId = const Value.absent(),
    Value<DateTime?> vigenciaInicio = const Value.absent(),
    Value<DateTime?> vigenciaFim = const Value.absent(),
    Value<String?> shareToken = const Value.absent(),
    Value<String?> pdfUrl = const Value.absent(),
    Value<String?> hashDocumento = const Value.absent(),
    int? totalSignatarios,
    Value<String?> linkAssinatura = const Value.absent(),
    Value<String?> clienteNome = const Value.absent(),
    Value<int?> assinaturasRealizadas = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedContract(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    clientId: clientId ?? this.clientId,
    status: status ?? this.status,
    textoFinal: textoFinal.present ? textoFinal.value : this.textoFinal,
    proposalId: proposalId.present ? proposalId.value : this.proposalId,
    templateId: templateId.present ? templateId.value : this.templateId,
    vigenciaInicio: vigenciaInicio.present
        ? vigenciaInicio.value
        : this.vigenciaInicio,
    vigenciaFim: vigenciaFim.present ? vigenciaFim.value : this.vigenciaFim,
    shareToken: shareToken.present ? shareToken.value : this.shareToken,
    pdfUrl: pdfUrl.present ? pdfUrl.value : this.pdfUrl,
    hashDocumento: hashDocumento.present
        ? hashDocumento.value
        : this.hashDocumento,
    totalSignatarios: totalSignatarios ?? this.totalSignatarios,
    linkAssinatura: linkAssinatura.present
        ? linkAssinatura.value
        : this.linkAssinatura,
    clienteNome: clienteNome.present ? clienteNome.value : this.clienteNome,
    assinaturasRealizadas: assinaturasRealizadas.present
        ? assinaturasRealizadas.value
        : this.assinaturasRealizadas,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedContract copyWithCompanion(CachedContractsCompanion data) {
    return CachedContract(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      status: data.status.present ? data.status.value : this.status,
      textoFinal: data.textoFinal.present
          ? data.textoFinal.value
          : this.textoFinal,
      proposalId: data.proposalId.present
          ? data.proposalId.value
          : this.proposalId,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      vigenciaInicio: data.vigenciaInicio.present
          ? data.vigenciaInicio.value
          : this.vigenciaInicio,
      vigenciaFim: data.vigenciaFim.present
          ? data.vigenciaFim.value
          : this.vigenciaFim,
      shareToken: data.shareToken.present
          ? data.shareToken.value
          : this.shareToken,
      pdfUrl: data.pdfUrl.present ? data.pdfUrl.value : this.pdfUrl,
      hashDocumento: data.hashDocumento.present
          ? data.hashDocumento.value
          : this.hashDocumento,
      totalSignatarios: data.totalSignatarios.present
          ? data.totalSignatarios.value
          : this.totalSignatarios,
      linkAssinatura: data.linkAssinatura.present
          ? data.linkAssinatura.value
          : this.linkAssinatura,
      clienteNome: data.clienteNome.present
          ? data.clienteNome.value
          : this.clienteNome,
      assinaturasRealizadas: data.assinaturasRealizadas.present
          ? data.assinaturasRealizadas.value
          : this.assinaturasRealizadas,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedContract(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('clientId: $clientId, ')
          ..write('status: $status, ')
          ..write('textoFinal: $textoFinal, ')
          ..write('proposalId: $proposalId, ')
          ..write('templateId: $templateId, ')
          ..write('vigenciaInicio: $vigenciaInicio, ')
          ..write('vigenciaFim: $vigenciaFim, ')
          ..write('shareToken: $shareToken, ')
          ..write('pdfUrl: $pdfUrl, ')
          ..write('hashDocumento: $hashDocumento, ')
          ..write('totalSignatarios: $totalSignatarios, ')
          ..write('linkAssinatura: $linkAssinatura, ')
          ..write('clienteNome: $clienteNome, ')
          ..write('assinaturasRealizadas: $assinaturasRealizadas, ')
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
    textoFinal,
    proposalId,
    templateId,
    vigenciaInicio,
    vigenciaFim,
    shareToken,
    pdfUrl,
    hashDocumento,
    totalSignatarios,
    linkAssinatura,
    clienteNome,
    assinaturasRealizadas,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedContract &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.clientId == this.clientId &&
          other.status == this.status &&
          other.textoFinal == this.textoFinal &&
          other.proposalId == this.proposalId &&
          other.templateId == this.templateId &&
          other.vigenciaInicio == this.vigenciaInicio &&
          other.vigenciaFim == this.vigenciaFim &&
          other.shareToken == this.shareToken &&
          other.pdfUrl == this.pdfUrl &&
          other.hashDocumento == this.hashDocumento &&
          other.totalSignatarios == this.totalSignatarios &&
          other.linkAssinatura == this.linkAssinatura &&
          other.clienteNome == this.clienteNome &&
          other.assinaturasRealizadas == this.assinaturasRealizadas &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedContractsCompanion extends UpdateCompanion<CachedContract> {
  final Value<String> id;
  final Value<String> providerId;
  final Value<String> clientId;
  final Value<String> status;
  final Value<String?> textoFinal;
  final Value<String?> proposalId;
  final Value<String?> templateId;
  final Value<DateTime?> vigenciaInicio;
  final Value<DateTime?> vigenciaFim;
  final Value<String?> shareToken;
  final Value<String?> pdfUrl;
  final Value<String?> hashDocumento;
  final Value<int> totalSignatarios;
  final Value<String?> linkAssinatura;
  final Value<String?> clienteNome;
  final Value<int?> assinaturasRealizadas;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedContractsCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.status = const Value.absent(),
    this.textoFinal = const Value.absent(),
    this.proposalId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.vigenciaInicio = const Value.absent(),
    this.vigenciaFim = const Value.absent(),
    this.shareToken = const Value.absent(),
    this.pdfUrl = const Value.absent(),
    this.hashDocumento = const Value.absent(),
    this.totalSignatarios = const Value.absent(),
    this.linkAssinatura = const Value.absent(),
    this.clienteNome = const Value.absent(),
    this.assinaturasRealizadas = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedContractsCompanion.insert({
    required String id,
    required String providerId,
    required String clientId,
    this.status = const Value.absent(),
    this.textoFinal = const Value.absent(),
    this.proposalId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.vigenciaInicio = const Value.absent(),
    this.vigenciaFim = const Value.absent(),
    this.shareToken = const Value.absent(),
    this.pdfUrl = const Value.absent(),
    this.hashDocumento = const Value.absent(),
    this.totalSignatarios = const Value.absent(),
    this.linkAssinatura = const Value.absent(),
    this.clienteNome = const Value.absent(),
    this.assinaturasRealizadas = const Value.absent(),
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerId = Value(providerId),
       clientId = Value(clientId),
       updatedAt = Value(updatedAt);
  static Insertable<CachedContract> custom({
    Expression<String>? id,
    Expression<String>? providerId,
    Expression<String>? clientId,
    Expression<String>? status,
    Expression<String>? textoFinal,
    Expression<String>? proposalId,
    Expression<String>? templateId,
    Expression<DateTime>? vigenciaInicio,
    Expression<DateTime>? vigenciaFim,
    Expression<String>? shareToken,
    Expression<String>? pdfUrl,
    Expression<String>? hashDocumento,
    Expression<int>? totalSignatarios,
    Expression<String>? linkAssinatura,
    Expression<String>? clienteNome,
    Expression<int>? assinaturasRealizadas,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (clientId != null) 'client_id': clientId,
      if (status != null) 'status': status,
      if (textoFinal != null) 'texto_final': textoFinal,
      if (proposalId != null) 'proposal_id': proposalId,
      if (templateId != null) 'template_id': templateId,
      if (vigenciaInicio != null) 'vigencia_inicio': vigenciaInicio,
      if (vigenciaFim != null) 'vigencia_fim': vigenciaFim,
      if (shareToken != null) 'share_token': shareToken,
      if (pdfUrl != null) 'pdf_url': pdfUrl,
      if (hashDocumento != null) 'hash_documento': hashDocumento,
      if (totalSignatarios != null) 'total_signatarios': totalSignatarios,
      if (linkAssinatura != null) 'link_assinatura': linkAssinatura,
      if (clienteNome != null) 'cliente_nome': clienteNome,
      if (assinaturasRealizadas != null)
        'assinaturas_realizadas': assinaturasRealizadas,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedContractsCompanion copyWith({
    Value<String>? id,
    Value<String>? providerId,
    Value<String>? clientId,
    Value<String>? status,
    Value<String?>? textoFinal,
    Value<String?>? proposalId,
    Value<String?>? templateId,
    Value<DateTime?>? vigenciaInicio,
    Value<DateTime?>? vigenciaFim,
    Value<String?>? shareToken,
    Value<String?>? pdfUrl,
    Value<String?>? hashDocumento,
    Value<int>? totalSignatarios,
    Value<String?>? linkAssinatura,
    Value<String?>? clienteNome,
    Value<int?>? assinaturasRealizadas,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedContractsCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      clientId: clientId ?? this.clientId,
      status: status ?? this.status,
      textoFinal: textoFinal ?? this.textoFinal,
      proposalId: proposalId ?? this.proposalId,
      templateId: templateId ?? this.templateId,
      vigenciaInicio: vigenciaInicio ?? this.vigenciaInicio,
      vigenciaFim: vigenciaFim ?? this.vigenciaFim,
      shareToken: shareToken ?? this.shareToken,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      hashDocumento: hashDocumento ?? this.hashDocumento,
      totalSignatarios: totalSignatarios ?? this.totalSignatarios,
      linkAssinatura: linkAssinatura ?? this.linkAssinatura,
      clienteNome: clienteNome ?? this.clienteNome,
      assinaturasRealizadas:
          assinaturasRealizadas ?? this.assinaturasRealizadas,
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
    if (textoFinal.present) {
      map['texto_final'] = Variable<String>(textoFinal.value);
    }
    if (proposalId.present) {
      map['proposal_id'] = Variable<String>(proposalId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (vigenciaInicio.present) {
      map['vigencia_inicio'] = Variable<DateTime>(vigenciaInicio.value);
    }
    if (vigenciaFim.present) {
      map['vigencia_fim'] = Variable<DateTime>(vigenciaFim.value);
    }
    if (shareToken.present) {
      map['share_token'] = Variable<String>(shareToken.value);
    }
    if (pdfUrl.present) {
      map['pdf_url'] = Variable<String>(pdfUrl.value);
    }
    if (hashDocumento.present) {
      map['hash_documento'] = Variable<String>(hashDocumento.value);
    }
    if (totalSignatarios.present) {
      map['total_signatarios'] = Variable<int>(totalSignatarios.value);
    }
    if (linkAssinatura.present) {
      map['link_assinatura'] = Variable<String>(linkAssinatura.value);
    }
    if (clienteNome.present) {
      map['cliente_nome'] = Variable<String>(clienteNome.value);
    }
    if (assinaturasRealizadas.present) {
      map['assinaturas_realizadas'] = Variable<int>(
        assinaturasRealizadas.value,
      );
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
    return (StringBuffer('CachedContractsCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('clientId: $clientId, ')
          ..write('status: $status, ')
          ..write('textoFinal: $textoFinal, ')
          ..write('proposalId: $proposalId, ')
          ..write('templateId: $templateId, ')
          ..write('vigenciaInicio: $vigenciaInicio, ')
          ..write('vigenciaFim: $vigenciaFim, ')
          ..write('shareToken: $shareToken, ')
          ..write('pdfUrl: $pdfUrl, ')
          ..write('hashDocumento: $hashDocumento, ')
          ..write('totalSignatarios: $totalSignatarios, ')
          ..write('linkAssinatura: $linkAssinatura, ')
          ..write('clienteNome: $clienteNome, ')
          ..write('assinaturasRealizadas: $assinaturasRealizadas, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedContractTemplatesTable extends CachedContractTemplates
    with TableInfo<$CachedContractTemplatesTable, CachedContractTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedContractTemplatesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _corpoJsonMeta = const VerificationMeta(
    'corpoJson',
  );
  @override
  late final GeneratedColumn<String> corpoJson = GeneratedColumn<String>(
    'corpo_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versaoMeta = const VerificationMeta('versao');
  @override
  late final GeneratedColumn<int> versao = GeneratedColumn<int>(
    'versao',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    corpoJson,
    versao,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_contract_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedContractTemplate> instance, {
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
    if (data.containsKey('corpo_json')) {
      context.handle(
        _corpoJsonMeta,
        corpoJson.isAcceptableOrUnknown(data['corpo_json']!, _corpoJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_corpoJsonMeta);
    }
    if (data.containsKey('versao')) {
      context.handle(
        _versaoMeta,
        versao.isAcceptableOrUnknown(data['versao']!, _versaoMeta),
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
  CachedContractTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedContractTemplate(
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
      corpoJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}corpo_json'],
      )!,
      versao: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}versao'],
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
  $CachedContractTemplatesTable createAlias(String alias) {
    return $CachedContractTemplatesTable(attachedDatabase, alias);
  }
}

class CachedContractTemplate extends DataClass
    implements Insertable<CachedContractTemplate> {
  final String id;
  final String providerId;
  final String nome;
  final String corpoJson;
  final int versao;
  final DateTime updatedAt;
  final DateTime? syncedAt;
  const CachedContractTemplate({
    required this.id,
    required this.providerId,
    required this.nome,
    required this.corpoJson,
    required this.versao,
    required this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider_id'] = Variable<String>(providerId);
    map['nome'] = Variable<String>(nome);
    map['corpo_json'] = Variable<String>(corpoJson);
    map['versao'] = Variable<int>(versao);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  CachedContractTemplatesCompanion toCompanion(bool nullToAbsent) {
    return CachedContractTemplatesCompanion(
      id: Value(id),
      providerId: Value(providerId),
      nome: Value(nome),
      corpoJson: Value(corpoJson),
      versao: Value(versao),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory CachedContractTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedContractTemplate(
      id: serializer.fromJson<String>(json['id']),
      providerId: serializer.fromJson<String>(json['providerId']),
      nome: serializer.fromJson<String>(json['nome']),
      corpoJson: serializer.fromJson<String>(json['corpoJson']),
      versao: serializer.fromJson<int>(json['versao']),
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
      'corpoJson': serializer.toJson<String>(corpoJson),
      'versao': serializer.toJson<int>(versao),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  CachedContractTemplate copyWith({
    String? id,
    String? providerId,
    String? nome,
    String? corpoJson,
    int? versao,
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => CachedContractTemplate(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    nome: nome ?? this.nome,
    corpoJson: corpoJson ?? this.corpoJson,
    versao: versao ?? this.versao,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  CachedContractTemplate copyWithCompanion(
    CachedContractTemplatesCompanion data,
  ) {
    return CachedContractTemplate(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      nome: data.nome.present ? data.nome.value : this.nome,
      corpoJson: data.corpoJson.present ? data.corpoJson.value : this.corpoJson,
      versao: data.versao.present ? data.versao.value : this.versao,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedContractTemplate(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('corpoJson: $corpoJson, ')
          ..write('versao: $versao, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, providerId, nome, corpoJson, versao, updatedAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedContractTemplate &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.nome == this.nome &&
          other.corpoJson == this.corpoJson &&
          other.versao == this.versao &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedContractTemplatesCompanion
    extends UpdateCompanion<CachedContractTemplate> {
  final Value<String> id;
  final Value<String> providerId;
  final Value<String> nome;
  final Value<String> corpoJson;
  final Value<int> versao;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const CachedContractTemplatesCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.nome = const Value.absent(),
    this.corpoJson = const Value.absent(),
    this.versao = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedContractTemplatesCompanion.insert({
    required String id,
    required String providerId,
    required String nome,
    required String corpoJson,
    this.versao = const Value.absent(),
    required DateTime updatedAt,
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       providerId = Value(providerId),
       nome = Value(nome),
       corpoJson = Value(corpoJson),
       updatedAt = Value(updatedAt);
  static Insertable<CachedContractTemplate> custom({
    Expression<String>? id,
    Expression<String>? providerId,
    Expression<String>? nome,
    Expression<String>? corpoJson,
    Expression<int>? versao,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (nome != null) 'nome': nome,
      if (corpoJson != null) 'corpo_json': corpoJson,
      if (versao != null) 'versao': versao,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedContractTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? providerId,
    Value<String>? nome,
    Value<String>? corpoJson,
    Value<int>? versao,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedContractTemplatesCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      nome: nome ?? this.nome,
      corpoJson: corpoJson ?? this.corpoJson,
      versao: versao ?? this.versao,
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
    if (corpoJson.present) {
      map['corpo_json'] = Variable<String>(corpoJson.value);
    }
    if (versao.present) {
      map['versao'] = Variable<int>(versao.value);
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
    return (StringBuffer('CachedContractTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('nome: $nome, ')
          ..write('corpoJson: $corpoJson, ')
          ..write('versao: $versao, ')
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
  late final $CachedProposalTemplatesTable cachedProposalTemplates =
      $CachedProposalTemplatesTable(this);
  late final $CachedContractsTable cachedContracts = $CachedContractsTable(
    this,
  );
  late final $CachedContractTemplatesTable cachedContractTemplates =
      $CachedContractTemplatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedProviders,
    cachedClients,
    cachedProducts,
    cachedProposals,
    cachedProposalTemplates,
    cachedContracts,
    cachedContractTemplates,
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
      Value<DateTime?> archivedAt,
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
      Value<DateTime?> archivedAt,
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

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
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

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
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

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

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
                Value<DateTime?> archivedAt = const Value.absent(),
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
                archivedAt: archivedAt,
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
                Value<DateTime?> archivedAt = const Value.absent(),
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
                archivedAt: archivedAt,
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
typedef $$CachedProposalTemplatesTableCreateCompanionBuilder =
    CachedProposalTemplatesCompanion Function({
      required String id,
      required String providerId,
      required String nome,
      required String corpoJson,
      Value<bool> ativo,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedProposalTemplatesTableUpdateCompanionBuilder =
    CachedProposalTemplatesCompanion Function({
      Value<String> id,
      Value<String> providerId,
      Value<String> nome,
      Value<String> corpoJson,
      Value<bool> ativo,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedProposalTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedProposalTemplatesTable> {
  $$CachedProposalTemplatesTableFilterComposer({
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

  ColumnFilters<String> get corpoJson => $composableBuilder(
    column: $table.corpoJson,
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

class $$CachedProposalTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedProposalTemplatesTable> {
  $$CachedProposalTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get corpoJson => $composableBuilder(
    column: $table.corpoJson,
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

class $$CachedProposalTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedProposalTemplatesTable> {
  $$CachedProposalTemplatesTableAnnotationComposer({
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

  GeneratedColumn<String> get corpoJson =>
      $composableBuilder(column: $table.corpoJson, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedProposalTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedProposalTemplatesTable,
          CachedProposalTemplate,
          $$CachedProposalTemplatesTableFilterComposer,
          $$CachedProposalTemplatesTableOrderingComposer,
          $$CachedProposalTemplatesTableAnnotationComposer,
          $$CachedProposalTemplatesTableCreateCompanionBuilder,
          $$CachedProposalTemplatesTableUpdateCompanionBuilder,
          (
            CachedProposalTemplate,
            BaseReferences<
              _$AppDatabase,
              $CachedProposalTemplatesTable,
              CachedProposalTemplate
            >,
          ),
          CachedProposalTemplate,
          PrefetchHooks Function()
        > {
  $$CachedProposalTemplatesTableTableManager(
    _$AppDatabase db,
    $CachedProposalTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProposalTemplatesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedProposalTemplatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedProposalTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerId = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> corpoJson = const Value.absent(),
                Value<bool> ativo = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProposalTemplatesCompanion(
                id: id,
                providerId: providerId,
                nome: nome,
                corpoJson: corpoJson,
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
                required String corpoJson,
                Value<bool> ativo = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProposalTemplatesCompanion.insert(
                id: id,
                providerId: providerId,
                nome: nome,
                corpoJson: corpoJson,
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

typedef $$CachedProposalTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedProposalTemplatesTable,
      CachedProposalTemplate,
      $$CachedProposalTemplatesTableFilterComposer,
      $$CachedProposalTemplatesTableOrderingComposer,
      $$CachedProposalTemplatesTableAnnotationComposer,
      $$CachedProposalTemplatesTableCreateCompanionBuilder,
      $$CachedProposalTemplatesTableUpdateCompanionBuilder,
      (
        CachedProposalTemplate,
        BaseReferences<
          _$AppDatabase,
          $CachedProposalTemplatesTable,
          CachedProposalTemplate
        >,
      ),
      CachedProposalTemplate,
      PrefetchHooks Function()
    >;
typedef $$CachedContractsTableCreateCompanionBuilder =
    CachedContractsCompanion Function({
      required String id,
      required String providerId,
      required String clientId,
      Value<String> status,
      Value<String?> textoFinal,
      Value<String?> proposalId,
      Value<String?> templateId,
      Value<DateTime?> vigenciaInicio,
      Value<DateTime?> vigenciaFim,
      Value<String?> shareToken,
      Value<String?> pdfUrl,
      Value<String?> hashDocumento,
      Value<int> totalSignatarios,
      Value<String?> linkAssinatura,
      Value<String?> clienteNome,
      Value<int?> assinaturasRealizadas,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedContractsTableUpdateCompanionBuilder =
    CachedContractsCompanion Function({
      Value<String> id,
      Value<String> providerId,
      Value<String> clientId,
      Value<String> status,
      Value<String?> textoFinal,
      Value<String?> proposalId,
      Value<String?> templateId,
      Value<DateTime?> vigenciaInicio,
      Value<DateTime?> vigenciaFim,
      Value<String?> shareToken,
      Value<String?> pdfUrl,
      Value<String?> hashDocumento,
      Value<int> totalSignatarios,
      Value<String?> linkAssinatura,
      Value<String?> clienteNome,
      Value<int?> assinaturasRealizadas,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedContractsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedContractsTable> {
  $$CachedContractsTableFilterComposer({
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

  ColumnFilters<String> get textoFinal => $composableBuilder(
    column: $table.textoFinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proposalId => $composableBuilder(
    column: $table.proposalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get vigenciaInicio => $composableBuilder(
    column: $table.vigenciaInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get vigenciaFim => $composableBuilder(
    column: $table.vigenciaFim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shareToken => $composableBuilder(
    column: $table.shareToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfUrl => $composableBuilder(
    column: $table.pdfUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hashDocumento => $composableBuilder(
    column: $table.hashDocumento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSignatarios => $composableBuilder(
    column: $table.totalSignatarios,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkAssinatura => $composableBuilder(
    column: $table.linkAssinatura,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clienteNome => $composableBuilder(
    column: $table.clienteNome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get assinaturasRealizadas => $composableBuilder(
    column: $table.assinaturasRealizadas,
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

class $$CachedContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedContractsTable> {
  $$CachedContractsTableOrderingComposer({
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

  ColumnOrderings<String> get textoFinal => $composableBuilder(
    column: $table.textoFinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proposalId => $composableBuilder(
    column: $table.proposalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get vigenciaInicio => $composableBuilder(
    column: $table.vigenciaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get vigenciaFim => $composableBuilder(
    column: $table.vigenciaFim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shareToken => $composableBuilder(
    column: $table.shareToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfUrl => $composableBuilder(
    column: $table.pdfUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hashDocumento => $composableBuilder(
    column: $table.hashDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSignatarios => $composableBuilder(
    column: $table.totalSignatarios,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkAssinatura => $composableBuilder(
    column: $table.linkAssinatura,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteNome => $composableBuilder(
    column: $table.clienteNome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get assinaturasRealizadas => $composableBuilder(
    column: $table.assinaturasRealizadas,
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

class $$CachedContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedContractsTable> {
  $$CachedContractsTableAnnotationComposer({
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

  GeneratedColumn<String> get textoFinal => $composableBuilder(
    column: $table.textoFinal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get proposalId => $composableBuilder(
    column: $table.proposalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get vigenciaInicio => $composableBuilder(
    column: $table.vigenciaInicio,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get vigenciaFim => $composableBuilder(
    column: $table.vigenciaFim,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shareToken => $composableBuilder(
    column: $table.shareToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfUrl =>
      $composableBuilder(column: $table.pdfUrl, builder: (column) => column);

  GeneratedColumn<String> get hashDocumento => $composableBuilder(
    column: $table.hashDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSignatarios => $composableBuilder(
    column: $table.totalSignatarios,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkAssinatura => $composableBuilder(
    column: $table.linkAssinatura,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clienteNome => $composableBuilder(
    column: $table.clienteNome,
    builder: (column) => column,
  );

  GeneratedColumn<int> get assinaturasRealizadas => $composableBuilder(
    column: $table.assinaturasRealizadas,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedContractsTable,
          CachedContract,
          $$CachedContractsTableFilterComposer,
          $$CachedContractsTableOrderingComposer,
          $$CachedContractsTableAnnotationComposer,
          $$CachedContractsTableCreateCompanionBuilder,
          $$CachedContractsTableUpdateCompanionBuilder,
          (
            CachedContract,
            BaseReferences<
              _$AppDatabase,
              $CachedContractsTable,
              CachedContract
            >,
          ),
          CachedContract,
          PrefetchHooks Function()
        > {
  $$CachedContractsTableTableManager(
    _$AppDatabase db,
    $CachedContractsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> textoFinal = const Value.absent(),
                Value<String?> proposalId = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<DateTime?> vigenciaInicio = const Value.absent(),
                Value<DateTime?> vigenciaFim = const Value.absent(),
                Value<String?> shareToken = const Value.absent(),
                Value<String?> pdfUrl = const Value.absent(),
                Value<String?> hashDocumento = const Value.absent(),
                Value<int> totalSignatarios = const Value.absent(),
                Value<String?> linkAssinatura = const Value.absent(),
                Value<String?> clienteNome = const Value.absent(),
                Value<int?> assinaturasRealizadas = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedContractsCompanion(
                id: id,
                providerId: providerId,
                clientId: clientId,
                status: status,
                textoFinal: textoFinal,
                proposalId: proposalId,
                templateId: templateId,
                vigenciaInicio: vigenciaInicio,
                vigenciaFim: vigenciaFim,
                shareToken: shareToken,
                pdfUrl: pdfUrl,
                hashDocumento: hashDocumento,
                totalSignatarios: totalSignatarios,
                linkAssinatura: linkAssinatura,
                clienteNome: clienteNome,
                assinaturasRealizadas: assinaturasRealizadas,
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
                Value<String?> textoFinal = const Value.absent(),
                Value<String?> proposalId = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<DateTime?> vigenciaInicio = const Value.absent(),
                Value<DateTime?> vigenciaFim = const Value.absent(),
                Value<String?> shareToken = const Value.absent(),
                Value<String?> pdfUrl = const Value.absent(),
                Value<String?> hashDocumento = const Value.absent(),
                Value<int> totalSignatarios = const Value.absent(),
                Value<String?> linkAssinatura = const Value.absent(),
                Value<String?> clienteNome = const Value.absent(),
                Value<int?> assinaturasRealizadas = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedContractsCompanion.insert(
                id: id,
                providerId: providerId,
                clientId: clientId,
                status: status,
                textoFinal: textoFinal,
                proposalId: proposalId,
                templateId: templateId,
                vigenciaInicio: vigenciaInicio,
                vigenciaFim: vigenciaFim,
                shareToken: shareToken,
                pdfUrl: pdfUrl,
                hashDocumento: hashDocumento,
                totalSignatarios: totalSignatarios,
                linkAssinatura: linkAssinatura,
                clienteNome: clienteNome,
                assinaturasRealizadas: assinaturasRealizadas,
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

typedef $$CachedContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedContractsTable,
      CachedContract,
      $$CachedContractsTableFilterComposer,
      $$CachedContractsTableOrderingComposer,
      $$CachedContractsTableAnnotationComposer,
      $$CachedContractsTableCreateCompanionBuilder,
      $$CachedContractsTableUpdateCompanionBuilder,
      (
        CachedContract,
        BaseReferences<_$AppDatabase, $CachedContractsTable, CachedContract>,
      ),
      CachedContract,
      PrefetchHooks Function()
    >;
typedef $$CachedContractTemplatesTableCreateCompanionBuilder =
    CachedContractTemplatesCompanion Function({
      required String id,
      required String providerId,
      required String nome,
      required String corpoJson,
      Value<int> versao,
      required DateTime updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$CachedContractTemplatesTableUpdateCompanionBuilder =
    CachedContractTemplatesCompanion Function({
      Value<String> id,
      Value<String> providerId,
      Value<String> nome,
      Value<String> corpoJson,
      Value<int> versao,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$CachedContractTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedContractTemplatesTable> {
  $$CachedContractTemplatesTableFilterComposer({
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

  ColumnFilters<String> get corpoJson => $composableBuilder(
    column: $table.corpoJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versao => $composableBuilder(
    column: $table.versao,
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

class $$CachedContractTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedContractTemplatesTable> {
  $$CachedContractTemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get corpoJson => $composableBuilder(
    column: $table.corpoJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versao => $composableBuilder(
    column: $table.versao,
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

class $$CachedContractTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedContractTemplatesTable> {
  $$CachedContractTemplatesTableAnnotationComposer({
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

  GeneratedColumn<String> get corpoJson =>
      $composableBuilder(column: $table.corpoJson, builder: (column) => column);

  GeneratedColumn<int> get versao =>
      $composableBuilder(column: $table.versao, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedContractTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedContractTemplatesTable,
          CachedContractTemplate,
          $$CachedContractTemplatesTableFilterComposer,
          $$CachedContractTemplatesTableOrderingComposer,
          $$CachedContractTemplatesTableAnnotationComposer,
          $$CachedContractTemplatesTableCreateCompanionBuilder,
          $$CachedContractTemplatesTableUpdateCompanionBuilder,
          (
            CachedContractTemplate,
            BaseReferences<
              _$AppDatabase,
              $CachedContractTemplatesTable,
              CachedContractTemplate
            >,
          ),
          CachedContractTemplate,
          PrefetchHooks Function()
        > {
  $$CachedContractTemplatesTableTableManager(
    _$AppDatabase db,
    $CachedContractTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedContractTemplatesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedContractTemplatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedContractTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> providerId = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> corpoJson = const Value.absent(),
                Value<int> versao = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedContractTemplatesCompanion(
                id: id,
                providerId: providerId,
                nome: nome,
                corpoJson: corpoJson,
                versao: versao,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String providerId,
                required String nome,
                required String corpoJson,
                Value<int> versao = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedContractTemplatesCompanion.insert(
                id: id,
                providerId: providerId,
                nome: nome,
                corpoJson: corpoJson,
                versao: versao,
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

typedef $$CachedContractTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedContractTemplatesTable,
      CachedContractTemplate,
      $$CachedContractTemplatesTableFilterComposer,
      $$CachedContractTemplatesTableOrderingComposer,
      $$CachedContractTemplatesTableAnnotationComposer,
      $$CachedContractTemplatesTableCreateCompanionBuilder,
      $$CachedContractTemplatesTableUpdateCompanionBuilder,
      (
        CachedContractTemplate,
        BaseReferences<
          _$AppDatabase,
          $CachedContractTemplatesTable,
          CachedContractTemplate
        >,
      ),
      CachedContractTemplate,
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
  $$CachedProposalTemplatesTableTableManager get cachedProposalTemplates =>
      $$CachedProposalTemplatesTableTableManager(
        _db,
        _db.cachedProposalTemplates,
      );
  $$CachedContractsTableTableManager get cachedContracts =>
      $$CachedContractsTableTableManager(_db, _db.cachedContracts);
  $$CachedContractTemplatesTableTableManager get cachedContractTemplates =>
      $$CachedContractTemplatesTableTableManager(
        _db,
        _db.cachedContractTemplates,
      );
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
