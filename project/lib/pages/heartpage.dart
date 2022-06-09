import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/chart/heart_chart.dart';
import 'package:project/chart/heartseries.dart';
import 'package:project/database/entities/heart.dart';
import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/databaseRepository.dart';

class HeartPage extends StatefulWidget {
  static const route = '/home/heart';
  static const routename = 'Heart Page';

  const HeartPage({Key? key}) : super(key: key);

  static get fitbitHeartData => null;

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  //static late SharedPreferences prova;

  // late int flag;

  @override
  void initState() {
    super.initState();
    final data_series = [HeartSeries.empty()];
  }

  @override
  Widget build(BuildContext context) {
    print('${HeartPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(HeartPage.routename),
      ),
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
                HeartSeries.creation('Out of Range', data_heart[0],
                    charts.ColorUtil.fromDartColor(Colors.red)),
                HeartSeries.creation('Fat Burn', data_heart[1],
                    charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
                HeartSeries.creation('Cardio', data_heart[2],
                    charts.ColorUtil.fromDartColor(Colors.black12)),
                HeartSeries.creation('Peak', data_heart[3],
                    charts.ColorUtil.fromDartColor(Colors.blue))
              ];

              return HeartChart(data: data_series);
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      })),
    );
  }

  Future<void> _aggiungoHR(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool('heart') == false && sp.getBool('confirm') == true) {
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
    }
  }
} //Page
 //Page


