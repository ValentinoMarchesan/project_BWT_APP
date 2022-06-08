import 'package:fitbitter/fitbitter.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:project/pages/steppage/Stepseries.dart';
import 'package:project/pages/steppage/linear_charts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/databaseRepository.dart';
import '../utils/formats.dart';
import '../utils/strings.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key}) : super(key: key);

  static const route = '/home/sleep';
  static const routename = 'SLEEPPAGE';
  Sleep? sleep;

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  // initState
  int? data_sleep;
  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(SleepPage.routename,
            style: TextStyle(fontSize: 20, fontFamily: 'Audiowide')),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          // The logic is to query the DB for the entire list of Annotation using dbr.findAllAnnotations() and then populate the ListView accordingly.
          // We need to use a FutureBuilder since the result of dbr.findAllAnnotations() is a Future.

          return FutureBuilder(
              initialData: null,
              future: dbr.findAllSleep(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<Sleep>;
                  final datasleep = dbr.findminutsleep(data);
                  if (datasleep == null) {
                    int? datasleep = 0;
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        height: 400,
                        width: MediaQuery.of(context).size.width - 70,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'GRAFICO',
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'Audiowide',
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width - 70,
                        height: 100,
                        child: Text('HAI DORMITO: $datasleep ORE',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Audiowide')),
                        alignment: Alignment.center,
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                } // if
                // else
              });
        } // Consumer-builder
            ),
      ),
    );
  }
}
/*
  void Save(BuildContext context, sleepData) async {
    levelController = sleepData[0].level;

    // If the original Annotation passed to the AnnotationPage was null, then add a new Annotation...
    if (widget.sleep == null) {
      Sleep newSleep = Sleep(1, levelController!, DateTime.now());
      await Provider.of<DatabaseRepository>(context, listen: false)
          .insertSleep(newSleep);
    } //if
    //...otherwise, edit it.
    else {
      Sleep updateSleep =
          Sleep(widget.sleep!.id, levelController!, DateTime.now());
      await Provider.of<DatabaseRepository>(context, listen: false)
          .updateSleep(updateSleep);
    } //else
    //if
  } // _validateAndSave

  //Utility method that deletes a Annotation entry.
  void delete(BuildContext context) async {
    await Provider.of<DatabaseRepository>(context, listen: false)
        .removeSleep(widget.sleep!);
  } //_deleteAndPop

} //AnnotationPage
//Page
*/