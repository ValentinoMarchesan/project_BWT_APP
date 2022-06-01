import 'package:flutter/foundation.dart';
import 'package:project/chart/database.dart';
import 'package:project/chart/heart.dart';

class DatabaseRepository extends ChangeNotifier {
  //the state of the app is just the AppDatabase
  final AppDatabase database;

  //default constructor

  DatabaseRepository({required this.database});

  //this methods wraps insertHeart() method of the dao

  Future<void> insertHeart(Heart heart) async {
    await database.heartDao.insertHeart(heart);
    notifyListeners();
  } //insert heart

  Future<void> updateHeart(Heart heart) async {
    await database.heartDao.updateHeart(heart);
    notifyListeners();
  } //update heart

  Future<Heart?> findminutes(int id) async {
    final results = await database.heartDao.findminutes(id);
    return results;
  } //findminutes

  Future<void> deleteAllHeart(List<Heart> hearts) async {
    await database.heartDao.deleteAllHeart(hearts);
    notifyListeners();
  } //removeHeart

  //This method wraps the findAllHearts() method of the DAO
  Future<List<Heart>> findAllHeart() async {
    final results = await database.heartDao.findAllHeart();
    return results;
  } //findAllMeals

}//databaseRepository
