// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StepDao? _stepdaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Passi` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `passi` REAL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StepDao get stepdao {
    return _stepdaoInstance ??= _$StepDao(database, changeListener);
  }
}

class _$StepDao extends StepDao {
  _$StepDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _passiInsertionAdapter = InsertionAdapter(
            database,
            'Passi',
            (Passi item) =>
                <String, Object?>{'id': item.id, 'passi': item.passi},
            changeListener),
        _passiUpdateAdapter = UpdateAdapter(
            database,
            'Passi',
            ['id'],
            (Passi item) =>
                <String, Object?>{'id': item.id, 'passi': item.passi},
            changeListener),
        _passiDeletionAdapter = DeletionAdapter(
            database,
            'Passi',
            ['id'],
            (Passi item) =>
                <String, Object?>{'id': item.id, 'passi': item.passi},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Passi> _passiInsertionAdapter;

  final UpdateAdapter<Passi> _passiUpdateAdapter;

  final DeletionAdapter<Passi> _passiDeletionAdapter;

  @override
  Stream<List<Passi>> getAllStep() {
    return _queryAdapter.queryListStream('SELECT * FROM Employee',
        mapper: (Map<String, Object?> row) =>
            Passi(row['id'] as int?, row['passi'] as double?),
        queryableName: 'Passi',
        isView: false);
  }

  @override
  Stream<Passi?> getAllStepBYID(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Employee WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Passi(row['id'] as int?, row['passi'] as double?),
        arguments: [id],
        queryableName: 'Passi',
        isView: false);
  }

  @override
  Future<void> deleteAllStep() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Employee');
  }

  @override
  Future<void> insertStep(Passi steps) async {
    await _passiInsertionAdapter.insert(steps, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStep(Passi steps) async {
    await _passiUpdateAdapter.update(steps, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteStep(Passi steps) async {
    await _passiDeletionAdapter.delete(steps);
  }
}
