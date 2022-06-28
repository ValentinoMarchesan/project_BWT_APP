import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'heartseries.dart';

//Class that define HeartChart as a BarCharts
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
      height: 600,
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              const Text("TODAY HEART ACTIVITY",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                  )),
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
