import 'package:project/database/entities/sleep.dart';
import 'package:floor/floor.dart';

// classe che definisce i DAO
@dao
abstract class SleepDao {
  //Query #1: SELECT
  @Query('SELECT * FROM Sleep')
  Future<List<Sleep>> findAllSleep();
  @Query('SELECT sleepduration FROM Sleep WHERE id = :id')
  Future<List<Sleep>> findSleepDuration(int id);

  //Query #2: INSERT
  @insert
  Future<void> insertSleep(Sleep sleep);

  //Query #3: DELETE
  @delete
  Future<void> deleteSleep(List<Sleep> sleep);

  //Query #4: UPDATE
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleep(Sleep sleep);
} //AnnotationDao
