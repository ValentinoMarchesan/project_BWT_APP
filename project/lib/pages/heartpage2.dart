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

//Homepage screen. It will show the list of meals.
class HeartPage2 extends StatelessWidget {
  HeartPage2({Key? key}) : super(key: key);

  static const route = '/home/heart2';
  static const routename = 'Heartpage2';
  //Heart? time_OutRange;
  //Heart? time_FatBurn;
  //Heart? time_Cardio;
  //Heart? time_Peak;
  //late
  //List<HeartSeries> data_series = [];
  //late List<Heart> data_heart;

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
            if (snapshot.hasData) {
              final data_heart = snapshot.data as List<Heart>;
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
      })),
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
              date: DateTime.now().subtract(Duration(days: 5)),
              userID: sp.getString('userid'));
          // userID: prova.getString('userid'));

          //STEP3: Get the data
          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;

          final snackBar = SnackBar(content: Text(' ${fitbitHeartData[0]} '));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fitbitHeartData[0].minutesOutOfRange);
/*
          // _metodoprova(context);
          await Provider.of<DatabaseRepository>(context, listen: false)
              .updateHeart(Heart(1, fitbitHeartData[0].minutesOutOfRange!));

          await Provider.of<DatabaseRepository>(context, listen: false)
              .updateHeart(Heart(2, fitbitHeartData[0].minutesFatBurn!));

          await Provider.of<DatabaseRepository>(context, listen: false)
              .updateHeart(Heart(3, fitbitHeartData[0].minutesCardio!));

          await Provider.of<DatabaseRepository>(context, listen: false)
              .updateHeart(Heart(4, fitbitHeartData[0].minutesPeak!));

          Heart? time_OutRange =
              await Provider.of<DatabaseRepository>(context, listen: false)
                  .findminutes(1);
          Heart? time_FatBurn =
              await Provider.of<DatabaseRepository>(context, listen: false)
                  .findminutes(2);
          Heart? time_Cardio =
              await Provider.of<DatabaseRepository>(context, listen: false)
                  .findminutes(3);
          Heart? time_Peak =
              await Provider.of<DatabaseRepository>(context, listen: false)
                  .findminutes(4);

          data_series = [
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
          ];

/////////////////////////DATABASE////////////////
          ///
          ///
          /*
          if (data_heart.length == 0) {
            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(Heart(1, fitbitHeartData[0].minutesOutOfRange!));

            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(Heart(2, fitbitHeartData[0].minutesFatBurn!));

            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(Heart(3, fitbitHeartData[0].minutesCardio!));

            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(Heart(4, fitbitHeartData[0].minutesPeak!));
          } else { */

          //insert fetched data into database

          //  setState(() {
          // we recreate the build method
          // flag = 1;
          // data = HeartPage.marameo(flag);
          /*
          data_series = [
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
          ];*/ */
        },
        child: Text('tap to fetch today hearth data'),
      ),
    );
  }

  void _metodoprova(BuildContext context) async {
    await Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(1, 0));

    await Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(2, 0));

    await Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(3, 0));

    await Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(4, 0));
  }

  List<HeartSeries> _ritornalista(
      BuildContext context, int? out, int? fat, int? cardio, int? peak) {
    final data = [
      HeartSeries.creation(
          'Out of Range', out, charts.ColorUtil.fromDartColor(Colors.red)),
      HeartSeries.creation(
          'Fat Burn', fat, charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
      HeartSeries.creation(
          'Cardio', cardio, charts.ColorUtil.fromDartColor(Colors.black12)),
      HeartSeries.creation(
          'Peak',
          // fitbitHeartData[0].minutesPeak,
          peak,
          charts.ColorUtil.fromDartColor(Colors.blue))
    ];
    return data;
  }
/*
  List<HeartSeries> _metodoprova2(BuildContext context) async {
  
    final data_series = [
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
    ];

    return data_series;
  }*/
} //Page
