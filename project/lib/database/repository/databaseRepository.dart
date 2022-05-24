import 'package:flutter/material.dart';
import 'package:project/database/database.dart';
import 'package:project/database/entities/accountdata.dart';
import 'package:project/database/entities/activityentity.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllTodos() method of the DAO
  Future<List<AccountData>> findAllTodos() async {
    final results = await database.accountdataDao.findAllAccountData();
    return results;
  } //findAllTodos

  //This method wraps the insertTodo() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertTodo(AccountData accountData) async {
    await database.accountdataDao.insertAccountData(accountData);
    notifyListeners();
  } //insertTodo

  //This method wraps the deleteTodo() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeTodo(AccountData todo) async {
    await database.accountdataDao.deleteAccountData(todo);
    notifyListeners();
  } //removeTodo

} //DatabaseRepository