import 'package:floor/floor.dart';
import 'package:project/database/entities/stepentity.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepsDataDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM StepData')
  Future<List<StepData>> findAllStepData();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertStepData(StepData stepData);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteStepData(StepData task);
}//TodoDao