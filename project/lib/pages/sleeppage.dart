import 'dart:io';

import 'package:fitbitter/fitbitter.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
            style: TextStyle(
                fontSize: 20, fontFamily: 'Audiowide', color: Colors.black)),
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
                  if (datasleep == 0) {
                    return Column(
                      children: [
                        const SizedBox(
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
                          child: Lottie.asset(
                            'assets/sleep3.json',
                            height: 400,
                            width: MediaQuery.of(context).size.width - 70,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 140,
                          child: Column(
                            children: const [
                              Text('NO INFO ABOUT SLEEP!',
                                  style: TextStyle(
                                      fontSize: 19, fontFamily: 'Audiowide')),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Per poterti aiutare dovresti aprirti un pò di più con me!!',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Audiowide'),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    );
                  } else if (datasleep! >= 8) {
                    return Column(
                      children: [
                        const SizedBox(
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
                          child: Lottie.asset(
                            'assets/sleep2.json',
                            height: 400,
                            width: MediaQuery.of(context).size.width - 70,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 155,
                          child: Column(
                            children: [
                              Text('HAI DORMITO: $datasleep ORE',
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: 'Audiowide')),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                  'Essere riposati è importante per affrontare la giornata con la carica giusta, complimenti!!',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Audiowide'),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(
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
                          child: Lottie.asset(
                            'assets/sleep.json',
                            height: 400,
                            width: MediaQuery.of(context).size.width - 70,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 140,
                          child: Column(
                            children: [
                              Text('HAI DORMITO: $datasleep ORE',
                                  style: const TextStyle(
                                      fontSize: 20, fontFamily: 'Audiowide')),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                  'Ricordati di andare a dormire prima la prossima volta!!',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Audiowide'),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        } // Consumer-builder
            ),
      ),
    );
  }

  Future<void> _aggiungoSL(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    final now = DateTime.now().hour;
    if ((sp.getBool('sleep') == false && sp.getBool('confirm') == true) ||
        (now != sp.getInt("hour2"))) {
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

      if (sleepData.length > 0) {
        DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
        DateTime? startTime = sleepData[0].entryDateTime;
        int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
        database.updateSleep(Sleep(1, sleepDurHourse));
        sp.setBool('sleep', true);
      } else {
        database.updateSleep(Sleep(1, 0));
        sp.setBool('sleep', true);
      }
      final timefetch = DateTime.now().hour;
      sp.setInt('hour2', timefetch);
    }
  }
}
