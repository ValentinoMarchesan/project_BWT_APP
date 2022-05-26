import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HeartSeries {
  String status;
  int min;
  final charts.Color color;
  HeartSeries({
    required this.status,
    required this.min,
    required this.color,
  });

  static HeartSeries empty() => HeartSeries(
      status: '', min: 0, color: charts.ColorUtil.fromDartColor(Colors.white));

  static HeartSeries creation(String status, int? time, charts.Color color) {
    if (time == null) {
      time = 0;
    }
    if (status == null) {
      status = 'null';
    }

    if (color == null) {
      color = charts.ColorUtil.fromDartColor(Colors.white);
    }

    return HeartSeries(status: status, min: time, color: color);
  }
}
