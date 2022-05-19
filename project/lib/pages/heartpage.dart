import 'package:charts_flutter/flutter.dart';
import 'package:fitbitter/fitbitter.dart';

import 'package:flutter/material.dart';
import 'package:project/pages/chart/heart_chart.dart';
import 'package:project/pages/chart/heartseries.dart';

import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class HeartPage extends StatefulWidget {
  static const route = '/home/heart';
  static const routename = 'Heart Page';

  static get fitbitHeartData => null;

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  late List<HeartSeries> data;
  // late int flag;

  @override
  void initState() {
    super.initState();
    data = [HeartSeries.empty()];
  }

  @override
  Widget build(BuildContext context) {
    print('${HeartPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HeartPage.routename),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          final sp = await SharedPreferences.getInstance();

          //STEP1: Instanciate a menager
          FitbitHeartDataManager fitbitHeartDataManager =
              FitbitHeartDataManager(
            clientID: Strings.fitbitClientID,
            clientSecret: Strings.fitbitClientSecret,
          );

          //STEP2: Create the request url
          FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
            date: DateTime.now(),
            userID: sp.getString('userid'),
          );

          //STEP3: Get the data
          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;

          final snackBar = SnackBar(content: Text(' ${fitbitHeartData[0]} '));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fitbitHeartData[0].minutesOutOfRange);

          setState(() {
            // we recreate the build method
            // flag = 1;
            // data = HeartPage.marameo(flag);
            data = [
              HeartSeries.creation(
                  'Out of Range',
                  fitbitHeartData[0].minutesOutOfRange,
                  charts.ColorUtil.fromDartColor(Colors.red)),
              HeartSeries.creation(
                  'Fat Burn',
                  fitbitHeartData[0].minutesFatBurn,
                  charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
              HeartSeries.creation('Cardio', fitbitHeartData[0].minutesCardio,
                  charts.ColorUtil.fromDartColor(Colors.black12)),
              HeartSeries.creation('Peak', fitbitHeartData[0].minutesPeak,
                  charts.ColorUtil.fromDartColor(Colors.blue))
            ];
          });
        },
        child: Text('tap to fetch today hearth data'),
      ),
      body: Center(
        child: HeartChart(
          data: data,
        ),
      ),
    );
  }
} //Page

