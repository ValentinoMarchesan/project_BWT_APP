import 'dart:io';

import 'package:fitbitter/fitbitter.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:project/pages/steppage/Stepseries.dart';
import 'package:project/pages/steppage/linear_charts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/databaseRepository.dart';
import '../utils/formats.dart';
import '../utils/strings.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key}) : super(key: key);

  static const route = '/home/sleep';
  static const routename = 'SLEEPPAGE';
  Sleep? sleep;

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  // initState
  int? data_sleep;
  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(SleepPage.routename,
            style: TextStyle(fontSize: 20, fontFamily: 'Audiowide')),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          // The logic is to query the DB for the entire list of Annotation using dbr.findAllAnnotations() and then populate the ListView accordingly.
          // We need to use a FutureBuilder since the result of dbr.findAllAnnotations() is a Future.

          return FutureBuilder(
              initialData: null,
              future: dbr.findAllSleep(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _aggiungoSL(dbr);

                  final data = snapshot.data as List<Sleep>;
                  final datasleep = dbr.findminutsleep(data);
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        height: 400,
                        width: MediaQuery.of(context).size.width - 70,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'GRAFICO',
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'Audiowide',
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width - 70,
                        height: 100,
                        child: Text('HAI DORMITO: $datasleep ORE',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Audiowide')),
                        alignment: Alignment.center,
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                } // if
                // else
              });
        } // Consumer-builder
            ),
      ),
    );
  }

  Future<void> _aggiungoSL(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool('sleep') == false && sp.getBool('confirm') == true) {
      FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
      );

      //Fetch data
      final sleepData =
          await fitbitSleepDataManager.fetch(FitbitSleepAPIURL.withUserIDAndDay(
        date: DateTime.now(),
        userID: sp.getString('userid'),
      )) as List<FitbitSleepData>;

      DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
      DateTime? startTime = sleepData[0].entryDateTime;
      int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
      final sleepDurMinutes = endTime.difference(startTime).inMinutes % 60;

      //database.updateSleep(Sleep(1, sleepDurHourse));

      database.updateSleep(Sleep(1, sleepDurHourse));

      sp.setBool('sleep', true);
    }
  }
}
