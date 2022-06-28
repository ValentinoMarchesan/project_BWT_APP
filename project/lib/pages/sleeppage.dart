import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/databaseRepository.dart';
import '../utils/strings.dart';

//define the page where there is information about how many hours the subject's has slept

class SleepPage extends StatelessWidget {
  static const route = '/home/sleep';
  static const routename = 'SLEEP MONITORING';
  Sleep? sleep;

  int? data_sleep;
  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(SleepPage.routename,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Audiowide',
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
            //shade
            colors: [
              Color.fromARGB(255, 239, 65, 123),
              Color.fromARGB(255, 244, 190, 110)
            ],
            // direction of shade
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        )),
      ),
      body: Center(
        child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          // The logic is to query the DB for the entire list of sleep data using dbr.findAllSleep().
          // We need to use a FutureBuilder since the result of dbr.findAllSleep() is a Future.

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
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          height: 400,
                          width: MediaQuery.of(context).size.width - 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              //shade
                              colors: [
                                Color.fromARGB(255, 239, 65, 123),
                                Color.fromARGB(255, 244, 190, 110)
                              ],
                              //direction of shade
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                            color: Color.fromARGB(255, 244, 190, 110),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 140,
                          child: Column(
                            children: const [
                              Text('NO INFO ABOUT SLEEP!',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'Audiowide',
                                      color: Colors.white)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'In order to help you, you should open up a little bit more with me!',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      color: Colors.white),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    );
                  } else if (datasleep! >= 7) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          height: 400,
                          width: MediaQuery.of(context).size.width - 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              //shade
                              colors: [
                                Color.fromARGB(255, 239, 65, 123),
                                Color.fromARGB(255, 244, 190, 110)
                              ],
                              // direction of shade
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                            color: Color.fromARGB(255, 244, 190, 110),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 155,
                          child: Column(
                            children: [
                              Text('YOU HAVE SLEPT: $datasleep h',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Audiowide',
                                      color: Colors.white)),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                  'Having a good rest is important to face your day with the right energy, congrats!',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      color: Colors.white),
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
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          height: 400,
                          width: MediaQuery.of(context).size.width - 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              //shade
                              colors: [
                                Color.fromARGB(255, 239, 65, 123),
                                Color.fromARGB(255, 244, 190, 110)
                              ],
                              // direction of shade
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                            color: Color.fromARGB(255, 244, 190, 110),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 140,
                          child: Column(
                            children: [
                              Text('YOU HAVE SLEPT: $datasleep h',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Audiowide',
                                      color: Colors.white)),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                  'Next time remember to go to sleep earlier!',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'OpenSans',
                                      color: Colors.white),
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

// this method fetch the data if the authorization is done and if it is the first time we open the app, or if the hour is changed from the last fetch
  Future<void> _aggiungoSL(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    final now = DateTime.now().hour;

    final timelastfetch = sp.getInt("hour2");
    List test = [now, timelastfetch];
    // usefull test for developer for check the correct functioning of the automatic fetch
    print(
      test,
    );
    if ((sp.getBool('sleep') == false && sp.getBool('confirm') == true) ||
        (now != timelastfetch)) {
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
      } else {
        database.updateSleep(Sleep(1, 0));
      }
      final timefetch = DateTime.now().hour;
      sp.setInt('hour2', timefetch);
      sp.setBool('sleep', true);
    }
  }
} //sleep page
