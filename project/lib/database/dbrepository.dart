import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/database/stepentity.dart';
import 'package:project/pages/steppage/Stepseries.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method is used to get the list of steps from the database
  Future<Stream<List<Passi>>> getSteps() async {
    return await database.stepdao.getAllStep();
  }

  //This method wraps the insertTodo() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertStep(Passi passi) async {
    await database.stepdao.insertStep(passi);
    notifyListeners();
  } //insertTodo

  //This method wraps the deleteTodo() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteStep(Passi passi) async {
    await database.stepdao.deleteStep(passi);
    notifyListeners();
  } //deleteTodo
  //deleteTodo

  //This method wraps the updateTodo() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateStep(Passi passi) async {
    await database.stepdao.updateStep(passi);
    notifyListeners();
  } //updateTodo

  //This method wraps the deleteAllTodos() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteAllSteps() async {
    await database.stepdao.deleteAllStep();
    notifyListeners();
  } //deleteAllTodos

} //DatabaseRepository
