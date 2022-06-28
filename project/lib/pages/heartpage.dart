import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/chart/heart_chart.dart';
import 'package:project/chart/heartseries.dart';
import 'package:project/database/entities/heart.dart';
import 'package:project/models/appbar_widget.dart';
import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/databaseRepository.dart';

//define the page in which there is the graph on heart data
/*
class HeartPage extends StatefulWidget {
  static const route = '/home/heart';
  static const routename = 'HEART MONITORING';

  const HeartPage({Key? key}) : super(key: key);


  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  @override
  */
class HeartPage extends StatelessWidget {
  static const route = '/home/heart';
  static const routename = 'HEART MONITORING';

  @override
  Widget build(BuildContext context) {
    print('${HeartPage.routename} built');
    return Scaffold(
      appBar: buildAppBarHeartPage(context),
      body: Center(
          child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
        return FutureBuilder(
          initialData: null,
          future: dbr.findAllHeart(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _aggiungoHR(dbr);
              final data = snapshot.data as List<Heart>;
              final data_heart = dbr.findMinHeart(data);

              final data_series = [
                HeartSeries.creation(
                    'Out of Range',
                    data_heart[0],
                    charts.ColorUtil.fromDartColor(
                        Color.fromARGB(219, 221, 59, 113))),
                HeartSeries.creation('Fat Burn', data_heart[1],
                    charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
                HeartSeries.creation('Cardio', data_heart[2],
                    charts.ColorUtil.fromDartColor(Colors.greenAccent)),
                HeartSeries.creation(
                    'Peak',
                    data_heart[3],
                    charts.ColorUtil.fromDartColor(
                        Color.fromARGB(230, 107, 160, 252)))
              ];

              return Column(
                children: [
                  Container(height: 460, child: HeartChart(data: data_series)),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          const SizedBox(
                            height: 11,
                          ),
                          const Text('    GENERAL INFORMATION',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Audiowide',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              '  Minutes out of range: ${data_heart[0]} / 1440 min,'
                              '  \n  where: ',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 2),
                          Text('  -  Minutes fat burn: ${data_heart[1]} min',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 2),
                          Text('  -  Minutes cardio: ${data_heart[2]} min',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 2),
                          Text('  -  Minutes peak: ${data_heart[3]} min',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      })),
    );
  }

  //method for fetching heart data if the authorization is done and or is the first time that the data are fetched or if the hour is changed from the last fetch
  //the method also upload the data in the database

  Future<void> _aggiungoHR(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    final now = DateTime.now().hour;

    final timelastfetch = sp.getInt("hour1");
    List test = [now, timelastfetch];
    print(
      test,
    );
    if ((sp.getBool('heart') == false && sp.getBool('confirm') == true) ||
        (now != timelastfetch)) {
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
      database.updateHeart(Heart(1, heart[0]));
      database.updateHeart(Heart(2, heart[1]));
      database.updateHeart(Heart(3, heart[2]));
      database.updateHeart(Heart(4, heart[3]));
      sp.setBool('heart', true);
      final timefetch = DateTime.now().hour;
      sp.setInt('hour1', timefetch);
    }
  }
} //HeartPage

