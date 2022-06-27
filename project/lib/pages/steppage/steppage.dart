import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:project/database/entities/activity.dart';

import 'package:project/pages/steppage/linear_charts.dart';
import 'package:project/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/databaseRepository.dart';
import 'Stepseries.dart';

//this class define the stepPage in which you can see the weekly steps
class StepPage extends StatefulWidget {
  StepPage({Key? key}) : super(key: key);

  static const route = '/home/Step';
  static const routename = 'STEPS MONITORING';

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  late List<Steps> data_step = [];

  @override
  Widget build(BuildContext context) {
    print('${StepPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            StepPage.routename,
            style: TextStyle(fontFamily: 'Audiowide'),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              //sfumatura
              colors: [
                Color.fromARGB(255, 239, 65, 123),
                Color.fromARGB(255, 244, 190, 110)
              ],
              // direzione della sfumatura
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          )),
        ),
        body: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          return FutureBuilder(
            initialData: null,
            future: dbr.findAllActivity(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _aggiungoAC(dbr);
                final data = snapshot.data as List<Activity>;
                final datastep = dbr.findstep(data);
                final dataactivity = dbr.findActivity(data);
                double? means = meanstep(datastep);
                double? maxsteps = maxstep(datastep);
                double? minsteps = minstep(datastep);

                data_step = [
                  Steps.creation(7, datastep[0]),
                  Steps.creation(6, datastep[1]),
                  Steps.creation(5, datastep[2]),
                  Steps.creation(4, datastep[3]),
                  Steps.creation(3, datastep[4]),
                  Steps.creation(2, datastep[5]),
                  Steps.creation(1, datastep[6]),
                ];
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: LinearCharts(data: data_step)),
                    SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          //shade
                          colors: [
                            Color.fromARGB(255, 244, 190, 110),
                            Color.fromARGB(255, 243, 178, 82)
                          ],
                          // direction of shade
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('  GENERAL INFORMATION:',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Audiowide',
                                  color: Color.fromARGB(255, 255, 255, 255))),
                          const SizedBox(height: 15),
                          Text(
                              '   - Last day step: ${datastep[0]!.toInt()} steps ',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 5),
                          Text(
                              '   - Means steps of the week: ${means!.toInt()} steps',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 5),
                          Text(
                              '   - Max steps in the week: ${maxsteps!.toInt()} steps',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 5),
                          Text(
                              '   - Min steps of the week: ${minsteps.toInt()} steps',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 5),
                          Text(
                              '   - Calories of activity burn:${dataactivity[1]!.toInt()}Kcal',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 5),
                          Text(
                              '   - Minutes sedentary: ${dataactivity[2]!.toInt()} min',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 5),
                          Text(
                              '   - hours sedentary: ${(dataactivity[2]! / 60).toInt()} h',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                //A CircularProgressIndicator is shown while the list of Todo is loading.
                return CircularProgressIndicator();
              } //else
            }, //builder of FutureBuilder
          );
        }));
  }
} //StepPage

//this method fetch the data if no date has already fetched or if the hour is changed from the last fecth. the authorization must be done.
//the method also update the data in the database
Future<void> _aggiungoAC(DatabaseRepository database) async {
  final sp = await SharedPreferences.getInstance();
  final now = DateTime.now().hour;
  if (sp.getInt('hour3') == null) {
    sp.setInt('hour3', DateTime.now().hour);
  }
  final timelastfetch = sp.getInt("hour3");
  List test = [now, timelastfetch];
  print(
    test,
  );
  if ((sp.getBool('activity') == false && sp.getBool('confirm') == true) ||
      (now != timelastfetch)) {
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
    final activity = ActivityData(activitycalories, calories, sedentary);
    final steps = StepsData(stepsData);

    database.updateActivity(
        Activity(1, steps[0], activity[0], activity[1], activity[2]));
    database.updateActivity(Activity(2, steps[1], null, null, null));
    database.updateActivity(Activity(3, steps[2], null, null, null));
    database.updateActivity(Activity(4, steps[3], null, null, null));
    database.updateActivity(Activity(5, steps[4], null, null, null));
    database.updateActivity(Activity(6, steps[5], null, null, null));
    database.updateActivity(Activity(7, steps[6], null, null, null));
    sp.setBool('activity', true);
    final timefetch = DateTime.now().hour;
    sp.setInt('hour3', timefetch);
  }
}

//mean of weekly steps
double? meanstep(datastep) {
  double sum = 0;

  datastep.forEach((e) {
    sum += e!;
  });
  double res = sum / 7;
  return res;
}

//max of weekly steps
double? maxstep(datastep) {
  double max = 0;
  datastep.forEach((e) {
    if (e! > max) {
      max = e!;
    }
  });

  return max;
}

//min of weekly step
double minstep(datastep) {
  double min = datastep[0];
  datastep.forEach((e) {
    if (e! < min) {
      min = e!;
    }
  });

  return min;
}
