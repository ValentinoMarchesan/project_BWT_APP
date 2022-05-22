import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/models/annotation.dart';
import 'package:project/widgets/formTiles.dart';
import 'package:project/widgets/formSeparator.dart';
import 'package:project/utils/formats.dart';
import '../models/annotationDB.dart';

// Class that implement the page to be used to edit existing "annotations" on diary page and add new annotations.
// It's a StatefulWidget since it needs to rebuild when the form fields change.

class AnnotationPage extends StatefulWidget {
  // AnnotationPage needs to know the index of the annotation that we are editing (it is equal to -1 if the annotation is new)
  final int annotationIndex;
  // Passing the instance of AnnotationDB --> is not mandatory and maybe redundant, but it will allow to initialize easily the form values.
  final AnnotationDB annotationDB;

  // AnnotationPage constructor
  AnnotationPage(
      {Key? key, required this.annotationDB, required this.annotationIndex})
      : super(key: key);

  static const route = '/home/diary/annotation'; // controlla!!!
  static const routeDisplayName = 'Annotation';

  @override
  State<AnnotationPage> createState() => _AnnotationState();
} // AnnotationPage

// Class that manages the state of AnnotationPage
class _AnnotationState extends State<AnnotationPage> {
  final formKey = GlobalKey<
      FormState>(); // Form globalkey: this is required to validate the form fields.

  // Variables that maintain the current form fields values in memory.
  TextEditingController _minController = TextEditingController();
  TextEditingController _mlController = TextEditingController();
  TextEditingController _moodController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  // Here, we are using initState() to initialize the form fields values.
  // Rationale: Annotation ml,min,time ecc. are not known if the annotatino is new (annotationIndex == -1).
  // In this case, initilize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _minController.text = widget.annotationIndex == -1
        ? ''
        : widget.annotationDB.annotations[widget.annotationIndex].min
            .toString();
    _mlController.text = widget.annotationIndex == -1
        ? ''
        : widget.annotationDB.annotations[widget.annotationIndex].ml.toString();
    _moodController.text = widget.annotationIndex == -1
        ? ''
        : widget.annotationDB.annotations[widget.annotationIndex].mood
            .toString();
    _selectedDate = widget.annotationIndex == -1
        ? DateTime.now()
        : widget.annotationDB.annotations[widget.annotationIndex].dateTime;
    super.initState();
  } // initState

  // Remember that form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _minController.dispose(); //dispose i min (di meditazione)
    _mlController.dispose(); //dispose i ml (idratazione)
    _moodController.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    print(
        '${AnnotationPage.routeDisplayName} built'); // route display name for DEBUGGING

    // The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    // A FAB (floating action button) is showed to provide the "delete" functinality. It is showed only if the walk already exists.
    return Scaffold(
      appBar: AppBar(
        title: Text(AnnotationPage.routeDisplayName),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () => _validateAndSave(context),
              icon: Icon(Icons.done))
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.annotationIndex == -1
          ? null
          : FloatingActionButton(
              onPressed: () => _deleteAndPop(context),
              child: Icon(Icons.delete),
            ),
    );
  } //build

  // Utility method used to build the form:
  //   1. implement a Form;
  //   2. Define custom-made FormTiles (look at the widgets/formSeparator.dart and widgets/formTiles.dart files);
  //   3. Implement a Date+Time picker (look at the _selectDate utility method).

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FormSeparator(label: 'Meditation'),
            FormNumberTile(
              labelText: 'min',
              controller: _minController,
              icon: MdiIcons.meditation,
            ),
            FormSeparator(label: 'Water intake'),
            FormNumberTile(
              labelText: 'ml',
              controller: _mlController,
              icon: MdiIcons.water,
            ),
            FormSeparator(label: 'Mood'),
            FormTextTile(
              labelText: 'Mood',
              icon: MdiIcons.stickerEmoji,
              controller: _moodController,
            ),
            FormSeparator(label: 'Current date and time'),
            FormDateTile(
              labelText: 'Date and time',
              date: _selectedDate,
              icon: MdiIcons.clockTimeFourOutline,
              onPressed: () {
                _selectDate(context);
              },
              dateFormat: Formats.fullDateFormatNoSeconds,
            ),
          ],
        ),
      ),
    );
  } // _buildForm

  //Utility method that implements a Date+Time picker.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(2010),
            lastDate: DateTime(2101))
        .then((value) async {
      if (value != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime:
              TimeOfDay(hour: _selectedDate.hour, minute: _selectedDate.minute),
        );
        return pickedTime != null
            ? value.add(
                Duration(hours: pickedTime.hour, minutes: pickedTime.minute))
            : null;
      }
      return null;
    });
    if (picked != null && picked != _selectedDate)
      //Using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
  } // select Date

  //Utility method that validate the form and, if it is valid, save the new annotation information.
  void _validateAndSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Annotation newAnnotation = Annotation(
        min: int.parse(_minController.text),
        ml: int.parse(_mlController.text),
        mood: _moodController.text,
        dateTime: _selectedDate,
      );
      widget.annotationIndex == -1
          ? widget.annotationDB.addAnnotation(newAnnotation)
          : widget.annotationDB
              .editAnnotation(widget.annotationIndex, newAnnotation);
      Navigator.pop(context);
    }
  } // Validate and save

  //Utility method that deletes a walk entry.
  void _deleteAndPop(BuildContext context) {
    widget.annotationDB.deleteAnnotation(widget.annotationIndex);
    Navigator.pop(context);
  } //_deleteAndPop

} //Annotation State
