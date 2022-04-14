import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:project/pages/chart/stepseries.dart';

class StepChart extends StatelessWidget {
  final List<StepSeries> data;

  StepChart({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<StepSeries, String>> series = [
      charts.Series(
          id: "steps",
          data: data,
          domainFn: (StepSeries series, _) => series.day,
          measureFn: (StepSeries series, _) => series.passes,
          colorFn: (StepSeries series, _) => series.color)
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text("Step in a day",
                  style: Theme.of(context).textTheme.bodyMedium),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
