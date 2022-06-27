import 'package:project/database/entities/sleep.dart';
import 'package:floor/floor.dart';

//class that defines the DAO of Sleep entity
@dao
abstract class SleepDao {
  //Query #1: SELECT
  @Query('SELECT * FROM Sleep')
  Future<List<Sleep>> findAllSleep();
  @Query('SELECT sleepduration FROM Sleep WHERE id = :id')
  Future<List<Sleep>> findSleepDuration(int id);
  @Query('DELETE FROM Sleep')
  Future<void> deleteAllSleep();
  //Query #2: INSERT
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insertSleep(Sleep sleep);

  //Query #3: DELETE
  @delete
  Future<void> deleteSleep(List<Sleep> sleep);

  //Query #4: UPDATE
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSleep(Sleep sleep);
} //AnnotationDao
