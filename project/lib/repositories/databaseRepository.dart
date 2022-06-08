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

  Future<void> deleteAllHeart(List<Heart> hearts) async {
    await database.heartDao.deleteHeart(hearts);
    notifyListeners();
  } //removeHeart

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
      activitydata[0].step,
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

  Future<void> fetchAllData() async {
    // Authorize the app
    final sp = await SharedPreferences.getInstance();
    for (var i = 0; i < 200; i++) {
      if (sp.getBool('confirm') == true) {
        //___________________ FETCH SLEEP DATA ___________________//
        //Instantiate a proper data manager
        FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
          clientID: Strings.fitbitClientID,
          clientSecret: Strings.fitbitClientSecret,
        );

        //Fetch data
        final sleepData = await fitbitSleepDataManager
            .fetch(FitbitSleepAPIURL.withUserIDAndDay(
          date: DateTime.now(),
          userID: sp.getString('userid'),
        )) as List<FitbitSleepData>;
        final sleepDurMinutes = ManageSleepData(sleepData);
        final test1 = findAllSleep();
        if (test1 == null) {
          insertSleep(Sleep(1, sleepDurMinutes));
        } else {
          updateSleep(Sleep(1, sleepDurMinutes));
        }

        //_____________________________FETCH STEP DATA__________________________________
        FitbitActivityTimeseriesDataManager
            fitbitActivityTimeseriesDataManager =
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
        final stepsData = await fitbitActivityTimeseriesDataManager
                .fetch(fitbitActivityTimeseriesApiUrl)
            as List<FitbitActivityTimeseriesData>;

// _____________________________________________________________________________
//_____________________________FETCH ACTIVITY CALORIES DATA_____________________
        FitbitActivityTimeseriesDataManager
            fitbitActivityTimeseriesDataManager2 =
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
        final activitycalories = await fitbitActivityTimeseriesDataManager2
                .fetch(fitbitActivityTimeseriesApiUrl2)
            as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH CALORIES DATA______________________________
        FitbitActivityTimeseriesDataManager
            fitbitActivityTimeseriesDataManager3 =
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
        final calories = await fitbitActivityTimeseriesDataManager3
                .fetch(fitbitActivityTimeseriesApiUrl3)
            as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH MINUTES SEDEBTARY__________________________
        FitbitActivityTimeseriesDataManager
            fitbitActivityTimeseriesDataManager4 =
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
        final sedentary = await fitbitActivityTimeseriesDataManager4
                .fetch(fitbitActivityTimeseriesApiUrl4)
            as List<FitbitActivityTimeseriesData>;
        final activity = ActivityData(activitycalories, calories, sedentary);
        final steps = StepsData(stepsData);
        final test2 = findAllActivity();
        if (test2 == null) {
          insertActivity(
              Activity(1, steps[0], activity[0], activity[0], activity[0]));
          insertActivity(Activity(2, steps[1], null, null, null));
          insertActivity(Activity(3, steps[2], null, null, null));
          insertActivity(Activity(4, steps[3], null, null, null));
          insertActivity(Activity(5, steps[4], null, null, null));
          insertActivity(Activity(6, steps[5], null, null, null));
          insertActivity(Activity(7, steps[6], null, null, null));
        } else {
          updateActivity(
              Activity(1, steps[0], activity[0], activity[0], activity[0]));
          updateActivity(Activity(2, steps[1], null, null, null));
          updateActivity(Activity(3, steps[2], null, null, null));
          updateActivity(Activity(4, steps[3], null, null, null));
          updateActivity(Activity(5, steps[4], null, null, null));
          updateActivity(Activity(6, steps[5], null, null, null));
          updateActivity(Activity(7, steps[6], null, null, null));
        }

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
        final heart = HeartData(fitbitHeartData);
        final test3 = findAllHeart();
        if (test3 == null) {
          insertHeart(Heart(1, heart[0]));
          insertHeart(Heart(2, heart[1]));
          insertHeart(Heart(3, heart[2]));
          insertHeart(Heart(4, heart[3]));
        } else {
          updateHeart(Heart(1, heart[0]));
          updateHeart(Heart(2, heart[1]));
          updateHeart(Heart(3, heart[2]));
          updateHeart(Heart(4, heart[3]));
        }
        break;
      } else {
        await Future.delayed(Duration(seconds: 20));
        i = i + 1;
      }
    }
  }

  int ManageSleepData(List<FitbitSleepData> sleepData) {
    //Create a new Sleep object
    DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
    DateTime? startTime = sleepData[0].entryDateTime;
    //int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
    final sleepDurMinutes = endTime!.difference(startTime!).inMinutes % 60;

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
      fitbitHeartData[0].minutesPeak,
      fitbitHeartData[0].minutesCardio,
      fitbitHeartData[0].minimumFatBurn,
      fitbitHeartData[0].minutesCardio,
    ];

    return heart;
  }
}
