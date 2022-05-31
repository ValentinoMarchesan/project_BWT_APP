import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/sleeppage/sleepchart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/strings.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({Key? key}) : super(key: key);

  static const route = '/home/sleep';
  static const routename = 'SleepPage';

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(SleepPage.routename),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              // Authorize the app
              final sp = await SharedPreferences.getInstance();

              //Instantiate a proper data manager
              FitbitSleepDataManager fitbitSleepDataManager =
                  FitbitSleepDataManager(
                clientID: Strings.fitbitClientID,
                clientSecret: Strings.fitbitClientSecret,
              );

              //Fetch data
              final sleepData = await fitbitSleepDataManager
                  .fetch(FitbitSleepAPIURL.withUserIDAndDay(
                date: DateTime.now(),
                userID: sp.getString('userid'),
              )) as List<FitbitSleepData>;

              print(sleepData);
              setState(() {
                sp.setString('sleepdata', sleepData[0].level!);
              });
            },
            child: const Text('FETCH'),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'sleepchart remove buttom',
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.remove('sleepdata');
              setState(() {});
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: LineChartSample2(),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final sp = snapshot.data as SharedPreferences;
                if (sp.getString('sleepdata') == null) {
                  return Text(
                    'no data',
                    style: TextStyle(fontSize: 15),
                  );
                } else {
                  final data = sp.getString('sleepdata')!;
                  return Text(
                    'LAST DAY STEPS = $data',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  );
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
          ),
        ],
      ),
    );
  }
} //Page