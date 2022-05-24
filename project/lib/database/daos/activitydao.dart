import 'package:floor/floor.dart';
import 'package:project/database/entities/accountdata.dart';
import 'package:project/database/entities/activityentity.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class ActivityDataDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM ActivityData')
  Future<List<ActivityData>> findAllActivityData();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertActivityData(ActivityData activityData);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteActivityData(ActivityData task);
}//TodoDao