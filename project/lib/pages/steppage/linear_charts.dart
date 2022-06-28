import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as elements;
import 'package:charts_flutter/src/text_style.dart' as styles;
import 'package:shared_preferences/shared_preferences.dart';

import 'Stepseries.dart';

//Class that create the linearcharts for the steppage
class LinearCharts extends StatelessWidget {
  final List<Steps> data;
  LinearCharts({required this.data});

  static String? pointerAmount;
  static String? pointerDay;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Steps, int>> series = [
      charts.Series<Steps, int>(
        id: 'Lineal',
        domainFn: (v, i) => v.day,
        measureFn: (v, i) => v.step,
        data: data,
      )
    ];

    return Center(
      child: SizedBox(
        height: 350.0,
        child: charts.LineChart(
          series,
          selectionModels: [
            charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model) {
              // manage the interaction with the graph
              if (model.hasDatumSelection) {
                pointerAmount = model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index)
                    ?.toStringAsFixed(2);
                pointerDay = model.selectedSeries[0]
                    .domainFn(model.selectedDatum[0].index)
                    ?.toString();
              }
            })
          ],
          behaviors: [
            charts.LinePointHighlighter(symbolRenderer: MySymbolRenderer()),
          ],
          animate: true,
          defaultRenderer: charts.LineRendererConfig(
            includeArea: true,
            includePoints: true,
            includeLine: true,
            stacked: true,
          ),
        ),
      ),
    );
  }
}

//class that manages the graph of the weekly steps
class MySymbolRenderer extends charts.CircleSymbolRenderer {
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      fillPattern: fillPattern,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );
    canvas.drawRRect(
      Rectangle(
        bounds.left - 25,
        bounds.top - 30,
        bounds.width + 48,
        bounds.height + 18,
      ),
      fill: charts.ColorUtil.fromDartColor(Color.fromARGB(255, 235, 198, 131)),
    );

    var myStyle = styles.TextStyle();
    myStyle.fontSize = 10;

    canvas.drawText(
        elements.TextElement(
            'Day ${LinearCharts.pointerDay} \n${LinearCharts.pointerAmount}',
            style: myStyle),
        (bounds.left - 20).round(),
        (bounds.top - 26).round());
  }
}
