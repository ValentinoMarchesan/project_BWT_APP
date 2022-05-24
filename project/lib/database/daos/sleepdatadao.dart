import 'package:floor/floor.dart';
import 'package:project/database/entities/sleepentity.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class SleepDataDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM SleepData')
  Future<List<SleepData>> findAllSleepData();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertSleepData(SleepData sleepData);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteSleepData(SleepData task);
}//TodoDao