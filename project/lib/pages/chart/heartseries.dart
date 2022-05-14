import 'package:flutter/cupertino.dart';
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
}
