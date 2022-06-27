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

  // for gamepage (no usato)
  List<double?> findGame(List<Activity> stepsdata, List<Sleep> sleep) {
    final result = [
      stepsdata[0].step,
      sleep[0].sleepduration!.toDouble(),
    ];
    return result;
  }

  // for gamepage (no usato)
  Future<void> findallGame() async {
    findAllActivity();
    findAllSleep();
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

  //This method wraps the findAllHeart() method of the DAO
  Future<List<Heart>> findAllHeart() async {
    final results = await database.heartDao.findAllHeart();
    return results;
  } //findAllSleeps

//This method wraps the insertHeart() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertHeart(Heart heart) async {
    await database.heartDao.insertHeart(heart);
    notifyListeners();
  } //insert heart

//This method wraps the updateHeart() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateHeart(Heart heart) async {
    await database.heartDao.updateHeart(heart);
    notifyListeners();
  } //update heart

  Future<void> deleteHeart(List<Heart> hearts) async {
    await database.heartDao.deleteHeart(hearts);
    notifyListeners();
  } //removeHeart

//This method wraps the deleteHeart() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteAllHeart() async {
    await database.heartDao.deleteAllHeart();
    notifyListeners();
  } //removeHeart

//This method wraps the deleteAllAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteAllAnnotation() async {
    await database.annotationDao.deleteAllAnnotation();
    notifyListeners();
  } //insert activity

//This method wraps the findAllsleep() method of the DAO
  Future<List<Sleep>> findAllSleep() async {
    final results = await database.sleepDao.findAllSleep();
    return results;
  }

//This method wraps the insertsleep() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertSleep(Sleep sleep) async {
    await database.sleepDao.insertSleep(sleep);
    notifyListeners();
  } //insert sleep

//This method wraps the updateSleep() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateSleep(Sleep sleep) async {
    await database.sleepDao.updateSleep(sleep);
    notifyListeners();
  } //update sleep

//This method wraps the deleteSleep() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteSleep(List<Sleep> sleeps) async {
    await database.sleepDao.deleteSleep(sleeps);
    notifyListeners();
  } //removeSleep

//This method wraps the deleteAllsleep() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteAllSleep() async {
    await database.sleepDao.deleteAllSleep();
    notifyListeners();
  } //removeSleep

//This method wraps the insertActivity() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertActivity(Activity activity) async {
    await database.activityDao.insertActivity(activity);
    notifyListeners();
  } //insert activity

//This method wraps the updateActivity() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateActivity(Activity activity) async {
    await database.activityDao.updateActivity(activity);
    notifyListeners();
  } //update activity

//This method wraps the deleteActivity() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteActivity(List<Activity> activities) async {
    await database.activityDao.deleteActivity(activities);
    notifyListeners();
  } //removeActivity

//This method wraps the deleteAllactivity() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteAllActivity() async {
    await database.activityDao.deleteAllActivity();
    notifyListeners();
  } //removeActivity

//This method wraps the findAllActivity() method of the DAO
  Future<List<Activity>> findAllActivity() async {
    final results = await database.activityDao.findAllActivity();
    return results;
  } //findAllActivity

  List<double?> findstep(List<Activity> stepsdata) {
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
    final results = [
      activitydata[0].calories,
      activitydata[0].actcalories,
      activitydata[0].minsedentary,
    ];
    return results;
  } //findAllActivity

  int? findminutsleep(List<Sleep> sleep) {
    final results = sleep[0].sleepduration;

    return results;
  }

  List<int?> findMinHeart(List<Heart> heart) {
    final results = [
      heart[0].minutesheart,
      heart[1].minutesheart,
      heart[2].minutesheart,
      heart[3].minutesheart,
    ];
    return results;
  } //findAllSleeps

//Methods that implement all delete
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

// Methods that manage sleepdata for obtain sleep duration
int ManageSleepData(List<FitbitSleepData> sleepData) {
  //Create a new Sleep object
  if (sleepData.length == 0) {
    const sleepDurHourse = 0;
    return sleepDurHourse;
  } else {
    DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
    DateTime? startTime = sleepData[0].entryDateTime;
    int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
    final sleepDurMinutes = endTime.difference(startTime).inMinutes % 60;

    return sleepDurHourse;
  }
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
