import 'package:flutter/material.dart';
import 'package:project/pages/annotationpage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/utils/formats.dart';
import 'package:provider/provider.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:project/repositories/databaseRepository.dart';

//define the diary page
class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  static const route = '/home/diary';
  static const routename = 'MY DAILY DIARY';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          DiaryPage.routename,
          style:
              TextStyle(fontFamily: 'Audiowide', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 254, 183, 77),
        shadowColor: const Color.fromARGB(255, 254, 183, 77),
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
                    ? const Text(
                        'Your annotation list is currently empty! \n You can note down your daily: water intake, minutes of meditation and mood. Try now!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontFamily: 'OpenSans'),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, annotationIndex) {
                          //Here, we are using a Card to show an Annotation
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: const Icon(
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
        backgroundColor: Color.fromARGB(255, 243, 175, 73),
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
