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
        title: const Text(HeartPage.routename),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          // prova = await SharedPreferences.getInstance();
          final sp = await SharedPreferences.getInstance();

          //STEP1: Instanciate a menager
          FitbitHeartDataManager fitbitHeartDataManager =
              FitbitHeartDataManager(
            clientID: Strings.fitbitClientID,
            clientSecret: Strings.fitbitClientSecret,
          );

          //STEP2: Create the request url
          FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
              date: DateTime.now().subtract(Duration(days: 2)),
              userID: sp.getString('userid'));
          // userID: prova.getString('userid'));

          //STEP3: Get the data
          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;

          final snackBar = SnackBar(content: Text(' ${fitbitHeartData[0]} '));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fitbitHeartData[0].minutesOutOfRange);

          //  await Provider.of<DatabaseRepository>(context, listen: false)
          //      .insertHeart(Heart(1, fitbitHeartData[0].minutesOutOfRange!));

          await Provider.of<DatabaseRepository>(context, listen: false)
              .updateHeart(Heart(2, fitbitHeartData[0].minutesFatBurn!));

          await Provider.of<DatabaseRepository>(context, listen: false)
              .updateHeart(Heart(3, fitbitHeartData[0].minutesCardio!));

          //   await Provider.of<DatabaseRepository>(context, listen: false)
          //     .insertHeart(Heart(4, fitbitHeartData[0].minutesPeak!));

          //  Heart? time_OutRange =
          //      await Provider.of<DatabaseRepository>(context, listen: false)
          //         .findminutes(1);
          Heart? time_FatBurn =
              await Provider.of<DatabaseRepository>(context, listen: false)
                  .findminutes(2);
          Heart? time_Cardio =
              await Provider.of<DatabaseRepository>(context, listen: false)
                  .findminutes(3);
          //  Heart? time_Peak =
          //      await Provider.of<DatabaseRepository>(context, listen: false)
          //          .findminutes(4);

          //insert fetched data into database

          setState(() {
            // we recreate the build method
            // flag = 1;
            // data = HeartPage.marameo(flag);
            data = [
              HeartSeries.creation(
                  'Out of Range',
                  fitbitHeartData[0].minutesOutOfRange,
                  //time_OutRange!.minute,
                  charts.ColorUtil.fromDartColor(Colors.red)),
              HeartSeries.creation(
                  'Fat Burn',
                  // fitbitHeartData[0].minutesFatBurn,
                  time_FatBurn!.minute,
                  charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
              HeartSeries.creation(
                  'Cardio',
                  //fitbitHeartData[0].minutesCardio,
                  time_Cardio!.minute,
                  charts.ColorUtil.fromDartColor(Colors.black12)),
              HeartSeries.creation(
                  'Peak',
                  fitbitHeartData[0].minutesPeak,
                  //time_Peak!.minute,
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

