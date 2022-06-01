import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:project/pages/steppage/linear_charts.dart';
import 'package:project/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Stepseries.dart';

class StepPage extends StatefulWidget {
  StepPage({Key? key}) : super(key: key);

  static const route = '/home/Step';
  static const routename = 'StepPage';

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  late List<Steps> data = [];

  late final int? daycalories = 0;

  @override
  void initState() {
    super.initState();
    data = [Steps.empty()];
  }

  @override
  Widget build(BuildContext context) {
    print('${StepPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(StepPage.routename),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();

// _____________________________________________________________________________
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
                final activitycalories =
                    await fitbitActivityTimeseriesDataManager2
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

                final lastdaystep = stepsData[0].value;
                final activitycalories1 = activitycalories[0].value;
                final lastdaycalories = calories[0].value;
                final lastdaysedentary = sedentary[0].value;
                setState(() {
                  sp.setDouble('activitycalories', activitycalories1!);
                  sp.setDouble('lastdaystep', lastdaystep!);
                  sp.setDouble('lastdaycalories', lastdaycalories!);
                  sp.setDouble('lastdaysedentary', lastdaysedentary!);
                  data = [
                    Steps.creation(1, stepsData[0].value),
                    Steps.creation(2, stepsData[1].value),
                    Steps.creation(3, stepsData[2].value),
                    Steps.creation(4, stepsData[3].value),
                    Steps.creation(5, stepsData[4].value),
                    Steps.creation(6, stepsData[5].value),
                    Steps.creation(7, stepsData[6].value),
                  ];
                });
              },
              child: const Text('FETCH'),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: 'btn1',
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.remove('activitycalories');
                sp.remove('lastdaystep');
                sp.remove('lastdaycalories');
                sp.remove('lastdaysedentary');
                setState(() {});
              },
              child: Icon(Icons.delete),
              backgroundColor: Colors.orange,
            ),
          ],
        ),
        body: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 400,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      LinearCharts(
                        data: data,
                      ),
                      /*Consumer<DatabaseRepository>(
                      builder: (context, dbr, child) {
                    //The logic is to query the DB for the entire list of Todo using dbr.findAllTodos()
                    //and then populate the ListView accordingly.
                    //We need to use a FutureBuilder since the result of dbr.findAllTodos() is a Future.
                    return FutureBuilder(
                      initialData: null,
                      future: dbr.getSteps(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data as List<Passi>;

                          return LinearCharts(data: data);
                        } else {
                          //A CircularProgressIndicator is shown while the list of Todo is loading.
                          return CircularProgressIndicator();
                        } //else
                      }, //builder of FutureBuilder
                    );
                  }),*/
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 247, 166, 45),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GENERAL INFORMATION',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final sp = snapshot.data as SharedPreferences;
                            if (sp.getDouble('lastdaystep') == null) {
                              return Text(
                                'LAST DAY STEP = 0',
                                style: TextStyle(fontSize: 15),
                              );
                            } else {
                              final counts = sp.getDouble('lastdaystep')!;
                              return Text(
                                'LAST DAY STEPS = $counts',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                      ),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final sp = snapshot.data as SharedPreferences;
                            if (sp.getDouble('activitycalories') == null) {
                              return Text(
                                'ACTIVITY CALORIES = 0KCAL',
                                style: TextStyle(fontSize: 15),
                              );
                            } else {
                              final count = sp.getDouble('activitycalories')!;
                              return Text(
                                'ACTIVITY CALORIES = $count KCAL',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                      ),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final sp = snapshot.data as SharedPreferences;
                            if (sp.getDouble('lastdaycalories') == null) {
                              return Text(
                                'LAST DAY CALORIES = 0 KCAL',
                                style: TextStyle(fontSize: 15),
                              );
                            } else {
                              final countf = sp.getDouble('lastdaycalories')!;
                              return Text(
                                'LAST DAY CALORIES = $countf KCAL',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                      ),
                      FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final sp = snapshot.data as SharedPreferences;
                            if (sp.getDouble('lastdaysedentary') == null) {
                              return Text(
                                'LAST DAY SEDENTARY = 0 minutes',
                                style: TextStyle(fontSize: 15),
                              );
                            } else {
                              final counts = sp.getDouble('lastdaysedentary')!;
                              return Text(
                                'LAST DAY SEDENTARY = $counts minutes',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
} //Page



