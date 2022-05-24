import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'heartseries.dart';

class HeartChart extends StatelessWidget {
  final List<HeartSeries> data;

  HeartChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HeartSeries, String>> series = [
      charts.Series(
          id: "heart",
          data: data,
          domainFn: (HeartSeries series, _) => series.status,
          measureFn: (HeartSeries series, _) => series.min,
          colorFn: (HeartSeries series, _) => series.color)
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text("Heart activity in a day",
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
