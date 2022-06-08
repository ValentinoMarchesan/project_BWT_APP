import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/chart/database.dart';
import 'package:project/chart/heart.dart';
import 'package:project/chart/heart_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../utils/strings.dart';
import 'heartseries.dart';

class DatabaseRepository extends ChangeNotifier {
  //the state of the app is just the AppDatabase
  final AppDatabase database;

  //default constructor

  DatabaseRepository({required this.database}) {
    _fetchHearthdata();

    //final fitbitHeartData = _fetchhearthdata(); //as List<FitbitHeartData>;
    //final lista = findAllHeart() as List<Heart>;
    // if (lista.isEmpty) {
    //   insertHeart(Heart(1, 0));
    //   insertHeart(Heart(2, 0));
    //   insertHeart(Heart(3, 0));
    //   insertHeart(Heart(4, 0));
    // }
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

  /*

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
  */

  Future<void> _fetchHearthdata() async {
    // int i = 1;
    // while (i == 1) {
    //   final sp = await SharedPreferences.getInstance();
    //   if (sp.getBool('confirm') == true) {
    //     i = 0;
    //  }
    //  }
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool('confirm') == true) {
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

      sp.setBool('prova',
          true); //this is for the hearthpage in the case the database is fill with the fetched values

      final lista = await findAllHeart();
      if (lista.isEmpty) {
        insertHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
        insertHeart(Heart(2, fitbitHeartData[0].minutesFatBurn));
        insertHeart(Heart(3, fitbitHeartData[0].minutesCardio));
        insertHeart(Heart(4, fitbitHeartData[0].minutesPeak));
      } else {
        updateHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
        updateHeart(Heart(2, fitbitHeartData[0].minutesFatBurn));
        updateHeart(Heart(3, fitbitHeartData[0].minutesCardio));
        updateHeart(Heart(4, fitbitHeartData[0].minutesPeak));
      }
/*
      FutureBuilder(
          initialData: null,
          future: findAllHeart(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final lista = snapshot.data as List<Heart>;
              if (lista.length == 0) {
                insertHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
                insertHeart(Heart(1, fitbitHeartData[0].minutesFatBurn));
                insertHeart(Heart(1, fitbitHeartData[0].minutesCardio));
                insertHeart(Heart(1, fitbitHeartData[0].minutesOutOfRange));
              } else {
                updateHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
                updateHeart(Heart(1, fitbitHeartData[0].minutesFatBurn));
                updateHeart(Heart(1, fitbitHeartData[0].minutesCardio));
                updateHeart(Heart(1, fitbitHeartData[0].minutesOutOfRange));
              }
              final data_series = [
                HeartSeries.creation(
                    'Out of Range',
                    fitbitHeartData[0].minutesOutOfRange,
                    charts.ColorUtil.fromDartColor(Colors.red)),
                HeartSeries.creation(
                    'Fat Burn',
                    fitbitHeartData[0].minutesFatBurn,
                    charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
                HeartSeries.creation('Cardio', fitbitHeartData[0].minutesCardio,
                    charts.ColorUtil.fromDartColor(Colors.black12)),
                HeartSeries.creation('Peak', fitbitHeartData[0].minutesPeak,
                    charts.ColorUtil.fromDartColor(Colors.blue))
              ];
              return HeartChart(data: data_series);
            } else {
              return CircularProgressIndicator();
            }
          });
      //final heart = HeartData(fitbitHeartData);

    }*/
    } else {
      final sp = await SharedPreferences.getInstance();
      sp.setBool('prova',
          false); //this is for the hearthpage in the case the database is fill with the default values
      final lista = await findAllHeart();
      if (lista.isEmpty) {
        insertHeart(Heart(1, 0));
        insertHeart(Heart(2, 0));
        insertHeart(Heart(3, 0));
        insertHeart(Heart(4, 0));
      }
    }
  } //databaseRepository
}
