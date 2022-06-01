import 'dart:core';
import 'package:floor/floor.dart';
import 'package:project/database/stepentity.dart';

@dao
abstract class StepDao {
  @Query('SELECT * FROM Employee')
  Stream<List<Passi>> getAllStep();

  @Query('SELECT * FROM Employee WHERE id = :id')
  Stream<Passi?> getAllStepBYID(int id);

  @Query('DELETE FROM Employee')
  Future<void> deleteAllStep();

  @insert
  Future<void> insertStep(Passi steps);

  @update
  Future<void> updateStep(Passi steps);

  @delete
  Future<void> deleteStep(Passi steps);
}
