import 'package:floor/floor.dart';
import 'package:project/chart/heart.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class HeartDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Meal table
  @Query('SELECT * FROM Heart  where id=id ')
  Future<Heart?> findminutes(int id); //(int id);

  //Query #2: INSERT -> this allows to add a Heart in the table
  @insert
  Future<void> insertHeart(Heart heart);

  //Query #3: DELETE -> this allows to delete a Meal from the table
  // @delete
//  Future<void> deleteMeal(Meal task);

  //Query #4: UPDATE -> this allows to update a Meal entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateHeart(Heart heart);
}//MealDao