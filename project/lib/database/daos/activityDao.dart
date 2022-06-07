import 'package:project/database/entities/activity.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:floor/floor.dart';

// classe che definisce i DAO
@dao
abstract class ActivityDao {
  //Query #1: SELECT
  @Query('SELECT * FROM Activity')
  Future<List<Activity>> findAllActivity();
  @Query('SELECT step FROM Activity')
  Future<List<Activity>> findstep();
  @Query('SELECT actcalories FROM Activity')
  Future<List<Activity>> findActCalories();
  @Query('SELECT calories FROM Activity')
  Future<List<Activity>> findCalories();
  @Query('SELECT * FROM Activity')
  Future<List<Activity>> findMinSedentary();

  //Query #2: INSERT
  @Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> insertActivity(Activity activity);

  //Query #3: DELETE
  @delete
  Future<void> deleteActivity(List<Activity> task);

  //Query #4: UPDATE
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateActivity(Activity activity);
} 

/*
final double? step;
  final double? actcalories;
  final double? calories;
  final double? minsedentary;
*/