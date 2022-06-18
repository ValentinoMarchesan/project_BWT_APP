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
  DatabaseRepository({required this.database}) {}

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

  //This method wraps the findAllSleeps() method of the DAO
  Future<List<Heart>> findAllHeart() async {
    final results = await database.heartDao.findAllHeart();
    return results;
  } //findAllSleeps

  Future<void> insertHeart(Heart heart) async {
    await database.heartDao.insertHeart(heart);
    notifyListeners();
  } //insert heart

  Future<void> updateHeart(Heart heart) async {
    await database.heartDao.updateHeart(heart);
    notifyListeners();
  } //update heart

  Future<void> deleteHeart(List<Heart> hearts) async {
    await database.heartDao.deleteHeart(hearts);
    notifyListeners();
  } //removeHeart

  Future<void> deleteAllHeart() async {
    await database.heartDao.deleteAllHeart();
    notifyListeners();
  } //removeHeart

  Future<void> deleteAllAnnotation() async {
    await database.annotationDao.deleteAllAnnotation();
    notifyListeners();
  } //insert activity

  Future<List<Sleep>> findAllSleep() async {
    final results = await database.sleepDao.findAllSleep();
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

  Future<void> deleteSleep(List<Sleep> sleeps) async {
    await database.sleepDao.deleteSleep(sleeps);
    notifyListeners();
  } //removeSleep

  Future<void> deleteAllSleep() async {
    await database.sleepDao.deleteAllSleep();
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

  Future<void> deleteActivity(List<Activity> activities) async {
    await database.activityDao.deleteActivity(activities);
    notifyListeners();
  } //removeActivity

  Future<void> deleteAllActivity() async {
    await database.activityDao.deleteAllActivity();
    notifyListeners();
  } //removeActivity

  Future<List<Activity>> findAllActivity() async {
    final results = await database.activityDao.findAllActivity();
    return results;
  } //findAllActivity

  List<double?> findstep(List<Activity> stepsdata) {
    //final stepsdata = findstep() as List<Activity>;
    final results = [
      stepsdata[0].step,
      stepsdata[1].step,
      stepsdata[2].step,
      stepsdata[3].step,
      stepsdata[4].step,
      stepsdata[5].step,
      stepsdata[6].step
    ];

    return results;
  } //findstep

  List<double?> findActivity(List<Activity> activitydata) {
    // final activitydata = findAllActivity() as List<Activity>;
    final results = [
      activitydata[0].calories,
      activitydata[0].actcalories,
      activitydata[0].minsedentary,
    ];
    return results;
  } //findAllActivity

  int? findminutsleep(List<Sleep> sleep) {
    // final sleep = findAllSleep() as List<Sleep>;
    final results = sleep[0].sleepduration;

    return results;
  }

  List<int?> findMinHeart(List<Heart> heart) {
    //final heart = findAllHeart() as List<Heart>;
    final results = [
      heart[0].minutesheart,
      heart[1].minutesheart,
      heart[2].minutesheart,
      heart[3].minutesheart,
    ];
    return results;
  } //findAllSleeps

  //_____________________________________________________________________________
  //_____________________________________________________________________________
  //_____________________________________________________________________________
  //_____________________________________________________________________________
  //_____________________________________________________________________________

  Future<void> deleteAllData() async {
    deleteAllActivity();
    deleteAllHeart();
    deleteAllSleep();
    deleteAllAnnotation();
    final sp = await SharedPreferences.getInstance();
    sp.remove('sleep');
    sp.remove('heart');
    sp.remove('activity');
  }
}

int ManageSleepData(List<FitbitSleepData> sleepData) {
  //Create a new Sleep object
  DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
  DateTime? startTime = sleepData[0].entryDateTime;
  int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
  final sleepDurMinutes = endTime.difference(startTime).inMinutes % 60;

  return sleepDurHourse;
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
  List<FitbitActivityTimeseriesData> sedentary,
) {
  List<double?> activity = [
    activitycalories[0].value,
    calories[0].value,
    sedentary[0].value
  ];

  return activity;
}

List<int?> HeartData(List<FitbitHeartData> fitbitHeartData) {
  List<int?> heart = [
    fitbitHeartData[0].minutesOutOfRange,
    fitbitHeartData[0].minutesFatBurn,
    fitbitHeartData[0].minutesCardio,
    fitbitHeartData[0].minutesPeak,
  ];

  return heart;
}
