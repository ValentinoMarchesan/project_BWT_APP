import 'package:flutter/material.dart';
import 'package:project/pages/annotationpage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/utils/formats.dart';
import 'package:provider/provider.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:project/repositories/databaseRepository.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  static const route = '/home/diary';
  static const routename = 'MY DAILY DIARY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DiaryPage.routename),
        centerTitle: true,
        backgroundColor: Colors.orange,
        shadowColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          // The logic is to query the DB for the entire list of Annotation using dbr.findAllAnnotations() and then populate the ListView accordingly.
          // We need to use a FutureBuilder since the result of dbr.findAllAnnotations() is a Future.

          return FutureBuilder(
            initialData: null,
            future: dbr.findAllAnnotations(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<Annotation>;

                // If the Annotation table is empty, show a simple Text, otherwise show the list of Annotations using a ListView.

                return data.length == 0
                    ? Text(
                        'The annotation list is currently empty. \n You can note down your daily: water intake, mood ecc.',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, annotationIndex) {
                          //Here, we are using a Card to show a Annotation
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: Icon(
                                MdiIcons.bookOpenPageVariant,
                                color: Colors.deepOrangeAccent,
                              ),
                              trailing: Icon(MdiIcons.noteEdit),
                              title: Text(
                                  '\nWater intake (ml): ${data[annotationIndex].ml} \n\nMeditation (min): ${data[annotationIndex].min} \n\nMood: ${data[annotationIndex].mood}\n'),
                              subtitle: Text(
                                  '${Formats.fullDateFormatNoSeconds.format(data[annotationIndex].dateTime)}'),
                              // When a ListTile is tapped, the user is redirected to the AnnotationPage where he can edit it.
                              onTap: () => _toAnnotationPage(
                                  context, data[annotationIndex]),
                            ),
                          );
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

      // Using a FAB to let the user add new annotations.
      // Rationale: I'm using null as annotation to let AnnotationPage know that we want to add a new annotation.
      floatingActionButton: FloatingActionButton(
        child: const Icon(MdiIcons.plus),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () => _toAnnotationPage(context, null),
      ),
    );
  } //build

  // Utility method to navigate to AnnotationPage
  void _toAnnotationPage(BuildContext context, Annotation? annotation) {
    Navigator.pushNamed(context, AnnotationPage.route,
        arguments: {'annotation': annotation});
  } //_toAnnotationPage
}

// VECCHIO CODICE 
/* Center(
        // Using a Consumer because we want the UI showing the list of annotations to rebuild every time the annotationDB updates.
        child: Consumer<AnnotationDB>(
          builder: (context, annotationDB, child) {
            // If the list of annotatinos is empty, show a simple Text, otherwise show the list of annotations using a ListView.
            return annotationDB.annotations.isEmpty
                ? const Text(
                    'The annotation list is currently empty. \n You can note down your daily: water intake, mood ecc.',
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemCount: annotationDB.annotations.length,
                    itemBuilder: (context, annotationIndex) {
                      //1. Using the Card widget to wrap each ListTile;
                      //2. Using DateTime to manage dates;
                      //3. Using a custom DateFormats to format the DateTime (look at the utils/formats.dart file);
                      //4. Improving UX adding a leading and a trailing to the ListTile

                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: const Icon(
                            MdiIcons.bookOpenPageVariant,
                            color: Colors.deepOrangeAccent,
                          ),
                          trailing: const Icon(MdiIcons.noteEdit),
                          title: Text(
                            '\nWater intake (ml): ${annotationDB.annotations[annotationIndex].ml} \n\nMeditation (min): ${annotationDB.annotations[annotationIndex].min} \n\nMood: ${annotationDB.annotations[annotationIndex].mood}\n',
                          ),
                          subtitle: Text(
                              '${Formats.fullDateFormatNoSeconds.format(annotationDB.annotations[annotationIndex].dateTime)}'),
                          // When a ListTile is tapped, the user is redirected to the AnnotationPage, where it will be able to edit it.
                          onTap: () => _toAnnotationPage(
                              context, annotationDB, annotationIndex),
                        ),
                      );
                    });
          },
        ),
      ), */