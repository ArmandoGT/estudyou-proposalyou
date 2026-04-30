// lib/data/drift/app_database.dart
//
// Banco SQLite offline-first via Drift para cache local de
// clientes, providers, produtos e propostas (rascunhos).

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Definição das tabelas para cache offline
// ─────────────────────────────────────────────────────────────────────────────

/// Cache local de providers (empresas).
class CachedProviders extends Table {
  TextColumn get id => text()();
  TextColumn get empresa => text()();
  TextColumn get razaoSocial => text().named('razao_social')();
  TextColumn get cnpj => text()();
  TextColumn get logoUrl => text().nullable().named('logo_url')();
  TextColumn get corMarca => text().nullable().named('cor_marca')();
  TextColumn get dataJson => text().nullable().named('data_json')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  DateTimeColumn get syncedAt => dateTime().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cache local de clientes.
class CachedClients extends Table {
  TextColumn get id => text()();
  TextColumn get providerId => text().named('provider_id')();
  TextColumn get nome => text()();
  TextColumn get cpfCnpj => text().named('cpf_cnpj')();
  TextColumn get email => text().nullable()();
  TextColumn get telefone => text().nullable()();
  TextColumn get enderecoJson => text().nullable().named('endereco_json')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  DateTimeColumn get archivedAt => dateTime().nullable().named('archived_at')();
  DateTimeColumn get syncedAt => dateTime().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cache local de produtos/serviços.
class CachedProducts extends Table {
  TextColumn get id => text()();
  TextColumn get providerId => text().named('provider_id')();
  TextColumn get nome => text()();
  TextColumn get descricao => text().nullable()();
  RealColumn get preco => real().withDefault(const Constant(0))();
  TextColumn get tipo => text().withDefault(const Constant('produto'))();
  TextColumn get unidade => text().nullable()();
  BoolColumn get ativo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  DateTimeColumn get syncedAt => dateTime().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cache local de propostas (rascunhos e enviadas).
class CachedProposals extends Table {
  TextColumn get id => text()();
  TextColumn get providerId => text().named('provider_id')();
  TextColumn get clientId => text().named('client_id')();
  TextColumn get status => text().withDefault(const Constant('rascunho'))();
  TextColumn get itensJson => text().withDefault(const Constant('[]')).named('itens_json')();
  RealColumn get total => real().withDefault(const Constant(0))();
  RealColumn get desconto => real().withDefault(const Constant(0))();
  TextColumn get observacoes => text().nullable()();
  DateTimeColumn get validade => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
  DateTimeColumn get syncedAt => dateTime().nullable().named('synced_at')();

  @override
  Set<Column> get primaryKey => {id};
}

// ─────────────────────────────────────────────────────────────────────────────
// Database principal
// ─────────────────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [CachedProviders, CachedClients, CachedProducts, CachedProposals])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Construtor para testes com executor customizado.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // ─────────────────────────────────────────────────────────────────
  // Métodos utilitários de sync
  // ─────────────────────────────────────────────────────────────────

  /// Limpa todos os dados de cache (ex: ao trocar de empresa).
  Future<void> clearAllCaches() async {
    await delete(cachedProviders).go();
    await delete(cachedClients).go();
    await delete(cachedProducts).go();
    await delete(cachedProposals).go();
  }

  /// Verifica se um registro precisa de sync comparando updated_at.
  /// Retorna `true` se o registro remoto é mais recente (last-write-wins).
  bool shouldSync(DateTime? localUpdatedAt, DateTime remoteUpdatedAt) {
    if (localUpdatedAt == null) return true;
    return remoteUpdatedAt.isAfter(localUpdatedAt);
  }
}

/// Abre a conexão nativa com o SQLite.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'proposal_you.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider Riverpod para o banco Drift (singleton keepAlive)
// ─────────────────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
