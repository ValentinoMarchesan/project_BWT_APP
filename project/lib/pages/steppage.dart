import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'chart/step_chart.dart';
import 'chart/stepseries.dart';

class StepPage extends StatelessWidget {
  StepPage({Key? key}) : super(key: key);

  static const route = '/home/Step';
  static const routename = 'StepPage';
  //al posto di data e la lista scritta ci saranno i dati raccolti dal fitband
  final List<StepSeries> data = [
    StepSeries(
        day: '10',
        passes: 4000,
        color: charts.ColorUtil.fromDartColor(Colors.red)),
    StepSeries(
        day: '11',
        passes: 5000,
        color: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 6, 2, 245))),
    StepSeries(
        day: '12',
        passes: 6000,
        color: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 10, 230, 10)))
  ];

  @override
  Widget build(BuildContext context) {
    print('${StepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(StepPage.routename),
      ),
      body: Center(
        child: StepChart(
          data: data,
        ),
      ),
    );
  } //build

} //Page