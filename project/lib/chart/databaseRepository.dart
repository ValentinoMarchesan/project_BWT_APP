import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/foundation.dart';
import 'package:project/chart/database.dart';
import 'package:project/chart/heart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/strings.dart';

class DatabaseRepository extends ChangeNotifier {
  //the state of the app is just the AppDatabase
  final AppDatabase database;

  //default constructor

  DatabaseRepository({required this.database}) {
    final fitbitHeartData = _fetchhearthdata(); //as List<FitbitHeartData>;
    final lista = findAllHeart() as List<Heart>;
    if (lista.isEmpty) {
      insertHeart(Heart(1, 0));
      insertHeart(Heart(2, 0));
      insertHeart(Heart(3, 0));
      insertHeart(Heart(4, 0));
    }
    /* else {
      updateHeart(Heart(1, fitbitHeartData[0].minutesOutOfRange));
      updateHeart(Heart(2, fitbitHeartData[0].minutesFatBurn));
      updateHeart(Heart(3, fitbitHeartData[0].minutesCardio));
      updateHeart(Heart(4, fitbitHeartData[0].minutesPeak)); */
  }

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

  Future<List<FitbitHeartData>> _fetchhearthdata() async {
    //authorize the app
    final sp = await SharedPreferences.getInstance();

    FitbitHeartDataManager fitbitHeartDataManager = FitbitHeartDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
    );

    //STEP2: Create the request url
    FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
        date: DateTime.now(), userID: sp.getString('userid'));

    //STEP3: Get the data
    final fitbitHeartData = await fitbitHeartDataManager
        .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;
    return fitbitHeartData;
    //fetch heart data
  }
}//databaseRepository
