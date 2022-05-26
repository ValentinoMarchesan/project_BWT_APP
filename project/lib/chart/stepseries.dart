import 'package:charts_flutter/flutter.dart' as charts;

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
