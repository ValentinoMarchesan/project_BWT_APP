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

  HeartDao? _heartDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Heart` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `minute` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HeartDao get heartDao {
    return _heartDaoInstance ??= _$HeartDao(database, changeListener);
  }
}

class _$HeartDao extends HeartDao {
  _$HeartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _heartInsertionAdapter = InsertionAdapter(
            database,
            'Heart',
            (Heart item) => <String, Object?>{
                  'id': item.id,
                  'minute': item.minute,
                }),
        _heartUpdateAdapter = UpdateAdapter(
            database,
            'Heart',
            ['id'],
            (Heart item) => <String, Object?>{
                  'id': item.id,
                  'minute': item.minute,
                }),
        _heartDeletionAdapter = DeletionAdapter(
            database,
            'Meal',
            ['id'],
            (Heart item) => <String, Object?>{
                  'id': item.id,
                  'minute': item.minute,
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Heart> _heartInsertionAdapter;

  final UpdateAdapter<Heart> _heartUpdateAdapter;

  final DeletionAdapter<Heart> _heartDeletionAdapter;

  @override
  Future<Heart?> findminutes(int id) async {
    return _queryAdapter.query('SELECT * FROM Heart  where id=id ',
        mapper: (Map<String, Object?> row) => Heart(
              row['id'] as int?,
              row['minute'] as int,
            ));
  }

  @override
  Future<void> insertHeart(Heart heart) async {
    await _heartInsertionAdapter.insert(heart, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateHeart(Heart heart) async {
    await _heartUpdateAdapter.update(heart, OnConflictStrategy.replace);
  }
}
