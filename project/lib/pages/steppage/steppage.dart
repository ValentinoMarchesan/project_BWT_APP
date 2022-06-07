import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:project/pages/steppage/linear_charts.dart';
import 'package:project/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/databaseRepository.dart';
import 'Stepseries.dart';

class StepPage extends StatefulWidget {
  StepPage({Key? key}) : super(key: key);

  static const route = '/home/Step';
  static const routename = 'StepPage';

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  late List<Steps> data_step = [];

  @override
  Widget build(BuildContext context) {
    print('${StepPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(StepPage.routename),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          //The logic is to query the DB for the entire list of Todo using dbr.findAllTodos()
          //and then populate the ListView accordingly.
          //We need to use a FutureBuilder since the result of dbr.findAllTodos() is a Future.
          return FutureBuilder(
            initialData: null,
            future: dbr.findstep(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<double?>;
                data_step = [
                  Steps.creation(1, data[0]),
                  Steps.creation(2, data[0]),
                  Steps.creation(3, data[0]),
                  Steps.creation(4, data[0]),
                  Steps.creation(5, data[0]),
                  Steps.creation(6, data[0]),
                  Steps.creation(7, data[0]),
                ];
                return LinearCharts(data: data_step);
              } else {
                //A CircularProgressIndicator is shown while the list of Todo is loading.
                return CircularProgressIndicator();
              } //else
            }, //builder of FutureBuilder
          );
        }));
  }
} //Page



