import 'package:floor/floor.dart';
import 'package:project/database/entities/heartentity.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class HeartDataDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM HeartData')
  Future<List<HeartData>> findAllHeartdata();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertHeartData(HeartData heartData);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> deleteHeartData(HeartData task);
}//TodoDao