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

  static List<HeartSeries> marameo(int flag) {
    List<HeartSeries> data;

    if (flag == 1) {
      return data = [
        HeartSeries(
            status: 'Out of Range',
            // min: fitbitHeartData[0].minutesOutOfRange,
            min: 5,
            color: charts.ColorUtil.fromDartColor(Colors.red)),
        HeartSeries(
            status: 'Fat Burn',
            // min: fitbitHeartData[0].minutesFatBurn,
            min: 6,
            color: charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
        HeartSeries(
            status: 'Cardio',
            // min: fitbitHeartData[0].minutesCardio,
            min: 8,
            color: charts.ColorUtil.fromDartColor(Colors.black12)),
        HeartSeries(
            status: 'Peak',
            //min: fitbitHeartData[0].minutesPeak,
            min: 9,
            color: charts.ColorUtil.fromDartColor(Colors.blue))
      ];
    } else
      return data = [HeartSeries.empty()];
  }
}

class _HeartPageState extends State<HeartPage> {
  late List<HeartSeries> data;
  late int flag;

  @override
  void initState() {
    super.initState();
    flag = 0;
    data = HeartPage.marameo(flag);
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
          // Authorize the app
          /*
          String? userId = await FitbitConnector.authorize(
              context: context,
              clientID: Strings.fitbitClientID,
              clientSecret: Strings.fitbitClientSecret,
              redirectUri: Strings.fitbitRedirectUri,
              callbackUrlScheme: Strings.fitbitCallbackScheme);
              */

          //STEP1: Instanciate a menager
          FitbitHeartDataManager fitbitHeartDataManager =
              FitbitHeartDataManager(
            clientID: Strings.fitbitClientID,
            clientSecret: Strings.fitbitClientSecret,
          );

          //STEP2: Create the request url
          FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
            date: DateTime.now().subtract(Duration(days: 1)),
            userID: sp.getString('userid'),
          );

          //STEP3: Get the data
          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;
          setState(() {
            // we recreate the build method
            flag = 1;
            data = HeartPage.marameo(flag);
          });

          final snackBar = SnackBar(content: Text(' ${fitbitHeartData[0]} '));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fitbitHeartData[0].minutesOutOfRange);
        },
        child: Text('tap to fetch data'),
      ),
      body: Center(
        child: HeartChart(
          data: data,
        ),
      ),
    );
  }
} //Page

