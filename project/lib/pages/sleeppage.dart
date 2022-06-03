import 'package:fitbitter/fitbitter.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:project/database/entities/sleep.dart';
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
  String? levelController;
  @override
  void initState() {
    levelController =
        widget.sleep == null ? '' : widget.sleep!.level.toString();

    super.initState();
  } // initState

  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text(SleepPage.routename),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              delete(context);
            },
            child: const Icon(Icons.delete),
            heroTag: 'delete',
          ),
          SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () async {
              // Authorize the app
              final sp = await SharedPreferences.getInstance();

              //Instantiate a proper data manager
              FitbitSleepDataManager fitbitSleepDataManager =
                  FitbitSleepDataManager(
                clientID: Strings.fitbitClientID,
                clientSecret: Strings.fitbitClientSecret,
              );

              //Fetch data
              final sleepData = await fitbitSleepDataManager
                  .fetch(FitbitSleepAPIURL.withUserIDAndDay(
                date: DateTime.now().subtract(const Duration(days: 1)),
                userID: sp.getString('userid'),
              )) as List<FitbitSleepData>;

              Save(context, sleepData);
            },
            heroTag: 'save',
            child: const Text('FETCH'),
          ),
        ],
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
                return data.length == 0
                    ? Text(
                        'NO REFERENCE ABOUT SLEEP FOUND',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, sleepIndex) {
                          //Here, we are using a Card to show a Annotation
                          return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(
                                  MdiIcons.bookOpenPageVariant,
                                  color: Colors.deepOrangeAccent,
                                ),

                                title: Text(
                                    '\n SLEEP LEVEL = ${data[sleepIndex].level}'),
                                subtitle: Text(
                                    '${Formats.fullDateFormatNoSeconds.format(data[sleepIndex].dateTime)}'),
                                // When a ListTile is tapped, the user is redirected to the AnnotationPage where he can edit it.
                              ));
                        });
              } // if
              else {
                return CircularProgressIndicator();
              } // else
            },
          );
        } // Consumer-builder
            ),
      ),
    );
  }

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