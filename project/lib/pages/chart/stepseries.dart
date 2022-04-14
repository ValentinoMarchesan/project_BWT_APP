import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StepSeries {
  String day;
  int passes;
  final charts.Color color;
  StepSeries({
    required this.day,
    required this.passes,
    required this.color,
  });
}
