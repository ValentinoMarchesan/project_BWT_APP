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
  late List<HeartSeries> data_series;

  // late int flag;

  @override
  void initState() {
    super.initState();
    data_series = [HeartSeries.empty()];
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
              final data = snapshot.data as List<Heart>;
              final data_heart = dbr.findMinHeart(data);
              if (data_heart.isEmpty) {
                data_series = [HeartSeries.empty()];
              } else {
                data_series = [
                  HeartSeries.creation('Out of Range', data_heart[0],
                      charts.ColorUtil.fromDartColor(Colors.red)),
                  HeartSeries.creation('Fat Burn', data_heart[1],
                      charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
                  HeartSeries.creation('Cardio', data_heart[2],
                      charts.ColorUtil.fromDartColor(Colors.black12)),
                  HeartSeries.creation('Peak', data_heart[3],
                      charts.ColorUtil.fromDartColor(Colors.blue))
                ];
              }
              return HeartChart(data: data_series);
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      })),
    );
  }
} //Page

