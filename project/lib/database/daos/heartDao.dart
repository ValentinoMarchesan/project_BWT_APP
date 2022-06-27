import 'package:project/chart/heartseries.dart';
import 'package:project/database/entities/heart.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:floor/floor.dart';

//class that defines the DAO of Heart entity
@dao
abstract class HeartDao {
  //Query #1: SELECT
  @Query('SELECT * FROM Heart')
  Future<List<Heart>> findAllHeart();
  @Query('SELECT minutesheart FROM Heart WHERE id = :id')
  Future<List<Heart>> findminutsHeart(int id);
  @Query('DELETE FROM Heart')
  Future<void> deleteAllHeart();
  //Query #2: INSERT
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insertHeart(Heart heart);

  //Query #3: DELETE
  @delete
  Future<void> deleteHeart(List<Heart> task);

  //Query #4: UPDATE
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateHeart(Heart heart);
}
