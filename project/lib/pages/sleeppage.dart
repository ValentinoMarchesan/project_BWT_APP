import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../utils/strings.dart';

class SleepPage extends StatelessWidget {
  SleepPage({Key? key}) : super(key: key);

  static const route = '/home/sleep';
  static const routename = 'SleepPage';

  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(SleepPage.routename),
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

          //Instantiate a proper data manager
          FitbitSleepDataManager fitbitSleepDataManager =
              FitbitSleepDataManager(
            clientID: Strings.fitbitClientID,
            clientSecret: Strings.fitbitClientSecret,
          );

          //Fetch data
          final sleepData = await fitbitSleepDataManager
              .fetch(FitbitSleepAPIURL.withUserIDAndDay(
            date: DateTime.now().subtract(Duration(days: 1)),
            userID: userId,
          )) as List<FitbitSleepData>;

          // Use them as you want
          final snackBar = SnackBar(
              content: Text('Yesterday sleep activity ${sleepData[0]}'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(sleepData);
        },
        child: Text('Tap to authorize and fetch data'),
      ),
    );
  } //build

} //Page