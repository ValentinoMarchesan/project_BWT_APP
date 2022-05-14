import 'package:charts_flutter/flutter.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/chart/heart_chart.dart';
import 'package:project/pages/chart/heartseries.dart';
import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chart/step_chart.dart';

class HeartPage extends StatelessWidget {
  HeartPage({Key? key}) : super(key: key);

  static const route = '/home/heart';
  static const routename = 'Heart Page';

  /*final List<HeartSeries> data = [
    HeartSeries(
        status: 'Out of Range',
        min: fitbitHeartData[0].minutesOutOfRange,
        color: charts.ColorUtil.fromDartColor(Colors.red)),
    HeartSeries(
        status: 'Fat Burn',
        min: fitbitHeartData[0].minutesFatBurn,
        color: charts.ColorUtil.fromDartColor(Colors.white)),
    HeartSeries(
        status: 'Cardio',
        min: fitbitHeartData[0].minutesCardio,
        color: charts.ColorUtil.fromDartColor(Colors.black12)),
    HeartSeries(
        status: 'Peak',
        min: fitbitHeartData[0].minutesPeak,
        color: charts.ColorUtil.fromDartColor(Colors.blue))
  ]; */

  static get fitbitHeartData => null;

  @override
  Widget build(BuildContext context) {
    print('${HeartPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HeartPage.routename),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          // Authorize the app
          String? userId = await FitbitConnector.authorize(
              context: context,
              clientID: Strings.fitbitClientID,
              clientSecret: Strings.fitbitClientSecret,
              redirectUri: Strings.fitbitRedirectUri,
              callbackUrlScheme: Strings.fitbitCallbackScheme);

          //STEP1: Instanciate a menager
          FitbitHeartDataManager fitbitHeartDataManager =
              FitbitHeartDataManager(
            clientID: Strings.fitbitClientID,
            clientSecret: Strings.fitbitClientSecret,
          );

          //STEP2: Create the request url
          FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
            date: DateTime.now().subtract(Duration(days: 1)),
            userID: userId,
          );

          //STEP3: Get the data
          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;

          //Using them
          // Use them as you want
          final snackBar = SnackBar(content: Text(' ${fitbitHeartData[0]} '));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fitbitHeartData[0].minutesOutOfRange);
        },
        child: Text('Tap to authorize and fetch data'),
      ),
      /* body: Center(
        child: HeartChart(
          data: data,
        ),
      ), */
    );
  } //build

} //Page
