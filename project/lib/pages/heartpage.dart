import 'package:charts_flutter/flutter.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/chart/heart_chart.dart';
import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'chart/step_chart.dart';

class HeartPage extends StatelessWidget {
  HeartPage({Key? key}) : super(key: key);

  static const route = '/home/heart';
  static const routename = 'Heart Page';

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
            date: DateTime.now(),
            userID: userId,
          );

          //STEP3: Get the data
          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;

          //Using them
          // Use them as you want
          final snackBar = SnackBar(
              content: Text(
                  ' ${fitbitHeartData[0]} ')); //fitbitHeartData[0].---- printo solo quel dato della lista
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fitbitHeartData);
        },
        child: Text('fetch data'),
      ),
    );
  } //build

} //Page
