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

  AnnotationDao? _annotationDaoInstance;

  SleepDao? _sleepDaoInstance;

  HeartDao? _heartDaoInstance;

  ActivityDao? _activityDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Annotation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `min` INTEGER NOT NULL, `ml` INTEGER NOT NULL, `mood` TEXT NOT NULL, `dateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sleep` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sleepduration` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Heart` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `minutesheart` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Activity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `step` REAL, `actcalories` REAL, `calories` REAL, `minsedentary` REAL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AnnotationDao get annotationDao {
    return _annotationDaoInstance ??= _$AnnotationDao(database, changeListener);
  }

  @override
  SleepDao get sleepDao {
    return _sleepDaoInstance ??= _$SleepDao(database, changeListener);
  }

  @override
  HeartDao get heartDao {
    return _heartDaoInstance ??= _$HeartDao(database, changeListener);
  }

  @override
  ActivityDao get activityDao {
    return _activityDaoInstance ??= _$ActivityDao(database, changeListener);
  }
}

class _$AnnotationDao extends AnnotationDao {
  _$AnnotationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _annotationInsertionAdapter = InsertionAdapter(
            database,
            'Annotation',
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'min': item.min,
                  'ml': item.ml,
                  'mood': item.mood,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _annotationUpdateAdapter = UpdateAdapter(
            database,
            'Annotation',
            ['id'],
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'min': item.min,
                  'ml': item.ml,
                  'mood': item.mood,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                }),
        _annotationDeletionAdapter = DeletionAdapter(
            database,
            'Annotation',
            ['id'],
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'min': item.min,
                  'ml': item.ml,
                  'mood': item.mood,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Annotation> _annotationInsertionAdapter;

  final UpdateAdapter<Annotation> _annotationUpdateAdapter;

  final DeletionAdapter<Annotation> _annotationDeletionAdapter;

  @override
  Future<List<Annotation>> findAllAnnotations() async {
    return _queryAdapter.queryList('SELECT * FROM Annotation',
        mapper: (Map<String, Object?> row) => Annotation(
            row['id'] as int?,
            row['min'] as int,
            row['ml'] as int,
            row['mood'] as String,
            _dateTimeConverter.decode(row['dateTime'] as int)));
  }

  @override
  Future<void> insertAnnotation(Annotation annotation) async {
    await _annotationInsertionAdapter.insert(
        annotation, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAnnotation(Annotation annotation) async {
    await _annotationUpdateAdapter.update(
        annotation, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAnnotation(Annotation task) async {
    await _annotationDeletionAdapter.delete(task);
  }
}

class _$SleepDao extends SleepDao {
  _$SleepDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sleepInsertionAdapter = InsertionAdapter(
            database,
            'Sleep',
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'sleepduration': item.sleepduration
                }),
        _sleepUpdateAdapter = UpdateAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'sleepduration': item.sleepduration
                }),
        _sleepDeletionAdapter = DeletionAdapter(
            database,
            'Sleep',
            ['id'],
            (Sleep item) => <String, Object?>{
                  'id': item.id,
                  'sleepduration': item.sleepduration
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sleep> _sleepInsertionAdapter;

  final UpdateAdapter<Sleep> _sleepUpdateAdapter;

  final DeletionAdapter<Sleep> _sleepDeletionAdapter;

  @override
  Future<List<Sleep>> findAllSleep() async {
    return _queryAdapter.queryList('SELECT * FROM Sleep',
        mapper: (Map<String, Object?> row) =>
            Sleep(row['id'] as int?, row['sleepduration'] as int?));
  }

  @override
  Future<List<Sleep>> findSleepDuration(int id) async {
    return _queryAdapter.queryList(
        'SELECT sleepduration FROM Sleep WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Sleep(row['id'] as int?, row['sleepduration'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllSleep() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Sleep');
  }

  @override
  Future<void> insertSleep(Sleep sleep) async {
    await _sleepInsertionAdapter.insert(sleep, OnConflictStrategy.rollback);
  }

  @override
  Future<void> updateSleep(Sleep sleep) async {
    await _sleepUpdateAdapter.update(sleep, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSleep(List<Sleep> sleep) async {
    await _sleepDeletionAdapter.deleteList(sleep);
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
                  'minutesheart': item.minutesheart
                }),
        _heartUpdateAdapter = UpdateAdapter(
            database,
            'Heart',
            ['id'],
            (Heart item) => <String, Object?>{
                  'id': item.id,
                  'minutesheart': item.minutesheart
                }),
        _heartDeletionAdapter = DeletionAdapter(
            database,
            'Heart',
            ['id'],
            (Heart item) => <String, Object?>{
                  'id': item.id,
                  'minutesheart': item.minutesheart
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Heart> _heartInsertionAdapter;

  final UpdateAdapter<Heart> _heartUpdateAdapter;

  final DeletionAdapter<Heart> _heartDeletionAdapter;

  @override
  Future<List<Heart>> findAllHeart() async {
    return _queryAdapter.queryList('SELECT * FROM Heart',
        mapper: (Map<String, Object?> row) =>
            Heart(row['id'] as int?, row['minutesheart'] as int?));
  }

  @override
  Future<List<Heart>> findminutsHeart(int id) async {
    return _queryAdapter.queryList(
        'SELECT minutesheart FROM Heart WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Heart(row['id'] as int?, row['minutesheart'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllHeart() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Heart');
  }

  @override
  Future<void> insertHeart(Heart heart) async {
    await _heartInsertionAdapter.insert(heart, OnConflictStrategy.rollback);
  }

  @override
  Future<void> updateHeart(Heart heart) async {
    await _heartUpdateAdapter.update(heart, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteHeart(List<Heart> task) async {
    await _heartDeletionAdapter.deleteList(task);
  }
}

class _$ActivityDao extends ActivityDao {
  _$ActivityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityInsertionAdapter = InsertionAdapter(
            database,
            'Activity',
            (Activity item) => <String, Object?>{
                  'id': item.id,
                  'step': item.step,
                  'actcalories': item.actcalories,
                  'calories': item.calories,
                  'minsedentary': item.minsedentary
                }),
        _activityUpdateAdapter = UpdateAdapter(
            database,
            'Activity',
            ['id'],
            (Activity item) => <String, Object?>{
                  'id': item.id,
                  'step': item.step,
                  'actcalories': item.actcalories,
                  'calories': item.calories,
                  'minsedentary': item.minsedentary
                }),
        _activityDeletionAdapter = DeletionAdapter(
            database,
            'Activity',
            ['id'],
            (Activity item) => <String, Object?>{
                  'id': item.id,
                  'step': item.step,
                  'actcalories': item.actcalories,
                  'calories': item.calories,
                  'minsedentary': item.minsedentary
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Activity> _activityInsertionAdapter;

  final UpdateAdapter<Activity> _activityUpdateAdapter;

  final DeletionAdapter<Activity> _activityDeletionAdapter;

  @override
  Future<List<Activity>> findAllActivity() async {
    return _queryAdapter.queryList('SELECT * FROM Activity',
        mapper: (Map<String, Object?> row) => Activity(
            row['id'] as int?,
            row['step'] as double?,
            row['actcalories'] as double?,
            row['calories'] as double?,
            row['minsedentary'] as double?));
  }

  @override
  Future<List<Activity>> findstep() async {
    return _queryAdapter.queryList('SELECT step FROM Activity',
        mapper: (Map<String, Object?> row) => Activity(
            row['id'] as int?,
            row['step'] as double?,
            row['actcalories'] as double?,
            row['calories'] as double?,
            row['minsedentary'] as double?));
  }

  @override
  Future<List<Activity>> findActCalories() async {
    return _queryAdapter.queryList('SELECT actcalories FROM Activity',
        mapper: (Map<String, Object?> row) => Activity(
            row['id'] as int?,
            row['step'] as double?,
            row['actcalories'] as double?,
            row['calories'] as double?,
            row['minsedentary'] as double?));
  }

  @override
  Future<List<Activity>> findCalories() async {
    return _queryAdapter.queryList('SELECT calories FROM Activity',
        mapper: (Map<String, Object?> row) => Activity(
            row['id'] as int?,
            row['step'] as double?,
            row['actcalories'] as double?,
            row['calories'] as double?,
            row['minsedentary'] as double?));
  }

  @override
  Future<List<Activity>> findMinSedentary() async {
    return _queryAdapter.queryList('SELECT * FROM Activity',
        mapper: (Map<String, Object?> row) => Activity(
            row['id'] as int?,
            row['step'] as double?,
            row['actcalories'] as double?,
            row['calories'] as double?,
            row['minsedentary'] as double?));
  }

  @override
  Future<void> deleteAllActivity() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Activity');
  }

  @override
  Future<void> insertActivity(Activity activity) async {
    await _activityInsertionAdapter.insert(
        activity, OnConflictStrategy.rollback);
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    await _activityUpdateAdapter.update(activity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteActivity(List<Activity> task) async {
    await _activityDeletionAdapter.deleteList(task);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
