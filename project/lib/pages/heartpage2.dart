import 'package:fitbitter/fitbitter.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:project/chart/databaseRepository.dart';
import 'package:project/chart/heart.dart';
import 'package:project/chart/heart_chart.dart';
import 'package:project/chart/heartseries.dart';
import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'heartpage2.dart';

//Homepage screen. It will show the list of meals.
/*
class HeartPage2 extends StatefulWidget {
  HeartPage2({Key? key}) : super(key: key);

  static const route = '/home/heart2';
  static const routename = 'Heartpage2';
  static get fitbitHeartData => null;

  @override
  State<HeartPage2> createState() => _HeartPage2State();
}

class _HeartPage2State extends State<HeartPage2> {
  @override
  void initState() {
    super.initState();
    final data_series = [HeartSeries.empty()];
  }
  */

class HeartPage2 extends StatelessWidget {
  HeartPage2({Key? key}) : super(key: key);

  static const route = '/home/heart2';
  static const routename = 'Heartpage2';
  static get fitbitHeartData => null;

  //Heart? time_OutRange;
  @override
  Widget build(BuildContext context) {
    print('${HeartPage2.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(HeartPage2.routename),
        ),
        body: Center(
            child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          return FutureBuilder(
            initialData: null,
            future: dbr.findAllHeart(),
            builder: (context, snapshot) {
              // _aggiungo(dbr);
              if (snapshot.hasData) {
                _aggiungo(dbr);
                final data_heart = snapshot.data as List<Heart>;
                if (data_heart.length == 0) {
                  _aggiungo(dbr);
                }

                final data_series = [
                  HeartSeries.creation(
                      'Out of Range',
                      //fitbitHeartData[0].minutesOutOfRange,
                      data_heart[0].minute,
                      charts.ColorUtil.fromDartColor(Colors.red)),
                  HeartSeries.creation(
                      'Fat Burn',
                      // fitbitHeartData[0].minutesFatBurn,
                      data_heart[1].minute,
                      charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
                  HeartSeries.creation(
                      'Cardio',
                      // fitbitHeartData[0].minutesCardio,
                      data_heart[2].minute,
                      charts.ColorUtil.fromDartColor(Colors.black12)),
                  HeartSeries.creation(
                      'Peak',
                      // fitbitHeartData[0].minutesPeak,
                      data_heart[3].minute,
                      charts.ColorUtil.fromDartColor(Colors.blue))
                ];

                return HeartChart(data: data_series);
                // _metodoprova(context);
                // return data_heart.length == 0
                //    ? Text('maracaibo', textAlign: TextAlign.center)
                //     : HeartChart(data: data_series);
                // if (data_heart.length == 0) {
                //  List<HeartSeries> data_series = [HeartSeries.empty()];
                //_metodoprova(context);
                //  return HeartChart(data: data_series);
                //   } else {
                // final data_series = _metodoprova2(context);
                // final data_series = _ritornalista(
                // context,
                //time_OutRange!.minute,
                //  time_FatBurn!.minute,
                //  time_Cardio!.minute,
                //   time_Peak!.minute);

                //    return HeartChart(data: data_series);
              }
              /*     final data_series = [
            HeartSeries.creation(
                'Out of Range',
                //fitbitHeartData[0].minutesOutOfRange,
                time_OutRange!.minute,
                charts.ColorUtil.fromDartColor(Colors.red)),
            HeartSeries.creation(
                'Fat Burn',
                // fitbitHeartData[0].minutesFatBurn,
                time_FatBurn!.minute,
                charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
            HeartSeries.creation(
                'Cardio',
                // fitbitHeartData[0].minutesCardio,
                time_Cardio!.minute,
                charts.ColorUtil.fromDartColor(Colors.black12)),
            HeartSeries.creation(
                'Peak',
                // fitbitHeartData[0].minutesPeak,
                time_Peak!.minute,
                charts.ColorUtil.fromDartColor(Colors.blue))
          ];*/
              //  return HeartChart(data: data_series);
              else {
                // _metodoprova(context);
                return CircularProgressIndicator();
              }
            },
          );
        })));
  }
}
/*
  Future<void> _aggiungo(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();

    if ((sp.getBool('prova') == false &&
        sp.getBool('confirm') == true &&
        sp.getBool('deleteall') == true)) {
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
      database.insertHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
      database.insertHeart(Heart(2, fitbitHeartData[0].minutesFatBurn));
      database.insertHeart(Heart(3, fitbitHeartData[0].minutesCardio));
      database.insertHeart(Heart(4, fitbitHeartData[0].minutesPeak));
      sp.setBool('prova', true);
      sp.remove('deleteall');
    } else if (sp.getBool('prova') == false && sp.getBool('confirm') == true) {
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

      database.updateHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
      database.updateHeart(Heart(2, fitbitHeartData[0].minutesFatBurn));
      database.updateHeart(Heart(3, fitbitHeartData[0].minutesCardio));
      database.updateHeart(Heart(4, fitbitHeartData[0].minutesPeak));
      sp.setBool('prova', true);
    }
  }
} //Page */

Future<void> _aggiungo(DatabaseRepository database) async {
  final sp = await SharedPreferences.getInstance();
  if (sp.getBool('prova') == false && sp.getBool('confirm') == true) {
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

    database.updateHeart(Heart(1, fitbitHeartData[0].minimumOutOfRange));
    database.updateHeart(Heart(2, fitbitHeartData[0].minutesFatBurn));
    database.updateHeart(Heart(3, fitbitHeartData[0].minutesCardio));
    database.updateHeart(Heart(4, fitbitHeartData[0].minutesPeak));
    sp.setBool('prova', true);
  }
}
 //Page