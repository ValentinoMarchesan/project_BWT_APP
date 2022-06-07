import 'dart:io';

import 'package:fitbitter/fitbitter.dart';
import 'package:project/database/database.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:flutter/material.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/entities/activity.dart';
import '../database/entities/heart.dart';
import '../utils/strings.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database}) {
    fetchAllData();
  }

  //This method wraps the findAllAnnotations() method of the DAO
  Future<List<Annotation>> findAllAnnotations() async {
    final results = await database.annotationDao.findAllAnnotations();
    return results;
  } //findAllAnnotations

  //This method wraps the insertAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertAnnotation(Annotation annotation) async {
    await database.annotationDao.insertAnnotation(annotation);
    notifyListeners();
  } //insertAnnotation

  //This method wraps the deleteAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeAnnotation(Annotation annotation) async {
    await database.annotationDao.deleteAnnotation(annotation);
    notifyListeners();
  } //removeAnnotation

  //This method wraps the updateAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateAnnotation(Annotation annotation) async {
    await database.annotationDao.updateAnnotation(annotation);
    notifyListeners();
  } //updateAnnotation

  Future<void> insertHeart(Heart heart) async {
    await database.heartDao.insertHeart(heart);
    notifyListeners();
  } //insert heart

  Future<void> updateHeart(Heart heart) async {
    await database.heartDao.updateHeart(heart);
    notifyListeners();
  } //update heart

  Future<List<Heart>> findminutsHeart(int id) async {
    final results = await database.heartDao.findminutsHeart(id);
    return results;
  } //findminutes

  Future<void> deleteAllHeart(List<Heart> hearts) async {
    await database.heartDao.deleteHeart(hearts);
    notifyListeners();
  } //removeHeart

  Future<List<Sleep>> findminutsleep(int id) async {
    final results = await database.sleepDao.findSleepDuration(id);
    return results;
  }

  Future<void> insertSleep(Sleep sleep) async {
    await database.sleepDao.insertSleep(sleep);
    notifyListeners();
  } //insert sleep

  Future<void> updateSleep(Sleep sleep) async {
    await database.sleepDao.updateSleep(sleep);
    notifyListeners();
  } //update sleep

  Future<void> deleteAllSleep(List<Sleep> sleeps) async {
    await database.sleepDao.deleteSleep(sleeps);
    notifyListeners();
  } //removeSleep

  Future<void> insertActivity(Activity activity) async {
    await database.activityDao.insertActivity(activity);
    notifyListeners();
  } //insert activity

  Future<void> updateActivity(Activity activity) async {
    await database.activityDao.updateActivity(activity);
    notifyListeners();
  } //update activity

  Future<void> deleteAllActivity(List<Activity> activities) async {
    await database.activityDao.deleteActivity(activities);
    notifyListeners();
  } //removeActivity

  Future<List<Activity>> findAllActivity() async {
    final results = await database.activityDao.findAllActivity();
    return results;
  } //findAllActivity

  Future<List<Activity>> findstep() async {
    final results = await database.activityDao.findstep();
    return results;
  } //findstep

  Future<List<Activity>> findActCalories() async {
    final results = await database.activityDao.findActCalories();
    return results;
  } //findActCalories

  Future<List<Activity>> findCalories() async {
    final results = await database.activityDao.findCalories();
    return results;
  } //findCalories

  Future<List<Activity>> findMinSedentary() async {
    final results = await database.activityDao.findMinSedentary();
    return results;
  } //findMinSedentary

  //_____________________________________________________________________________
  //_____________________________________________________________________________
  //_____________________________________________________________________________
  //_____________________________________________________________________________
  //_____________________________________________________________________________

  Future<void> fetchAllData() async {
    // Authorize the app
    final sp = await SharedPreferences.getInstance();

//___________________ FETCH SLEEP DATA ___________________//
    //Instantiate a proper data manager
    FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
    );

    //Fetch data
    final sleepData =
        await fitbitSleepDataManager.fetch(FitbitSleepAPIURL.withUserIDAndDay(
      date: DateTime.now().subtract(const Duration(days: 1)),
      userID: sp.getString('userid'),
    )) as List<FitbitSleepData>;

    //_____________________________FETCH STEP DATA__________________________________
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'steps',
    );

    FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl =
        FitbitActivityTimeseriesAPIURL.weekWithResource(
      baseDate: DateTime.now(),
      userID: sp.getString('userid'),
      resource: fitbitActivityTimeseriesDataManager.type,
    );
    final stepsData = await fitbitActivityTimeseriesDataManager.fetch(
        fitbitActivityTimeseriesApiUrl) as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH ACTIVITY CALORIES DATA_____________________
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager2 =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'activityCalories',
    );
    FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl2 =
        FitbitActivityTimeseriesAPIURL.weekWithResource(
            baseDate: DateTime.now(),
            userID: sp.getString('userid'),
            resource: fitbitActivityTimeseriesDataManager2.type);
    final activitycalories = await fitbitActivityTimeseriesDataManager2.fetch(
        fitbitActivityTimeseriesApiUrl2) as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH CALORIES DATA______________________________
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager3 =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'calories',
    );
    FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl3 =
        FitbitActivityTimeseriesAPIURL.dayWithResource(
            date: DateTime.now(),
            userID: sp.getString('userid'),
            resource: fitbitActivityTimeseriesDataManager3.type);
    final calories = await fitbitActivityTimeseriesDataManager3.fetch(
        fitbitActivityTimeseriesApiUrl3) as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH MINUTES SEDEBTARY__________________________
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager4 =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'minutesSedentary',
    );
    FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl4 =
        FitbitActivityTimeseriesAPIURL.dayWithResource(
            date: DateTime.now(),
            userID: sp.getString('userid'),
            resource: fitbitActivityTimeseriesDataManager4.type);
    final sedentary = await fitbitActivityTimeseriesDataManager4.fetch(
        fitbitActivityTimeseriesApiUrl4) as List<FitbitActivityTimeseriesData>;

// _____________________________________________________________________________
//_____________________________FETCH HEART DATA  _______________________________
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

    int manageSleepData(List<FitbitSleepData> sleepData) {
      //Create a new Sleep object
      DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
      DateTime? startTime = sleepData[0].entryDateTime;
      int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
      int sleepDurMinutes = endTime.difference(startTime).inMinutes % 60;
      return sleepDurMinutes;
    }

    List<double?> StepsData(List<FitbitActivityTimeseriesData> stepsData) {
      //Create a new Sleep object
      List<double?> steps = [
        stepsData[0].value,
        stepsData[1].value,
        stepsData[2].value,
        stepsData[3].value,
        stepsData[4].value,
        stepsData[5].value,
        stepsData[6].value
      ];

      return steps;
    }

    List<double?> ActivityData(
        List<FitbitActivityTimeseriesData> activitycalories,
        List<FitbitActivityTimeseriesData> calories,
        List<FitbitActivityTimeseriesData> sedentary) {
      List<double?> activity = [
        activitycalories[0].value,
        calories[0].value,
        sedentary[0].value
      ];

      return activity;
    }

    List<int?> HeartData(List<FitbitHeartData> fitbitHeartData) {
      //Create a new Sleep object
      List<int?> heart = [
        fitbitHeartData[0].minutesPeak,
        fitbitHeartData[0].minutesCardio,
        fitbitHeartData[0].minimumFatBurn,
        fitbitHeartData[0].minutesCardio,
      ];

      return heart;
    }
  }

  //___________________________________________________________________________
  //___________________________________________________________________________
  //___________________________________________________________________________
  //___________________________________________________________________________

  //updateAnnotation
}
