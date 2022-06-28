import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/widgets/formTiles.dart';
import 'package:project/widgets/formSeparator.dart';
import 'package:project/utils/formats.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:project/repositories/databaseRepository.dart';
import 'package:provider/provider.dart';

// Class that implement the page to be used to edit existing annotations and add new annotations.
// This is a StatefulWidget since it needs to rebuild when the form fields change.
class AnnotationPage extends StatefulWidget {
  // We are passing the Annotation to be edited. If it is null, the business logic will know that we are adding a new Annotation instead.
  final Annotation? annotation;

  // AnnotationPage constructor
  AnnotationPage({Key? key, required this.annotation}) : super(key: key);

  static const route = '/home/diary/annotation';
  static const routeDisplayName = 'ANNOTATION';

  @override
  State<AnnotationPage> createState() => _AnnotationPageState();
} //AnnotationPage

// Class that manages the state of AnnotationPage
class _AnnotationPageState extends State<AnnotationPage> {
  final formKey = GlobalKey<
      FormState>(); //Form globalkey: this is required to validate the form fields.

  // Variables that maintain the current form fields values in memory.
  TextEditingController _minController = TextEditingController();
  TextEditingController _mlController = TextEditingController();
  TextEditingController _moodController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  // Using initState() to initialize the form fields values.
  // Rationale: Annotation content and time are not known is the annnotation is new (annnotation == null).
  // In this case, initilize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _minController.text =
        widget.annotation == null ? '' : widget.annotation!.min.toString();
    _mlController.text =
        widget.annotation == null ? '' : widget.annotation!.ml.toString();
    _moodController.text =
        widget.annotation == null ? '' : widget.annotation!.mood.toString();
    _selectedDate = widget.annotation == null
        ? DateTime.now()
        : widget.annotation!.dateTime;
    super.initState();
  } // initState

  // Remember that form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _minController.dispose();
    _mlController.dispose();
    _moodController.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    print(
        '${AnnotationPage.routeDisplayName} built'); //Print the route display name for debugging

    // AppBar is used to validate and save the information provided by the user.
    // A FAB is showed to provide the "delete" functinality. It is showed only if the meal already exists.
    return Scaffold(
      appBar: AppBar(
        title: Text(AnnotationPage.routeDisplayName,
            style: TextStyle(
                fontFamily: 'Audiowide', fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 254, 183, 77),
        actions: [
          IconButton(
            onPressed: () => _validateAndSave(context),
            icon: Icon(Icons.done),
          )
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.annotation == null
          ? null
          : FloatingActionButton(
              onPressed: () => _deleteAndPop(context),
              child: Icon(Icons.delete),
              backgroundColor: Colors.deepOrange,
            ),
    );
  } //build

  // Utility method used to build the form.
  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FormSeparator(label: 'Water intake'),
            FormNumberTile(
              labelText: 'ml',
              controller: _mlController,
              icon: MdiIcons.water,
            ),
            FormSeparator(label: 'Meditation'),
            FormNumberTile(
              labelText: 'min',
              controller: _minController,
              icon: MdiIcons.meditation,
            ),
            FormSeparator(label: 'Your thoughts'),
            FormTextTile(
              labelText: 'A penny for your thoughts!',
              icon: MdiIcons.stickerEmoji,
              controller: _moodController,
            ),
            FormSeparator(label: 'Current date and time'),
            FormDateTile(
              labelText: 'Meal Time',
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
      //Here, I'm using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
  } //_selectDate

  // Utility method that validate the form and, if it is valid, save the new annotation information.
  void _validateAndSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // If the original Annotation passed to the AnnotationPage was null, then add a new Annotation...
      if (widget.annotation == null) {
        Annotation newMeal = Annotation(
            null,
            int.parse(_minController.text),
            int.parse(_mlController.text),
            _moodController.text,
            _selectedDate); //!
        await Provider.of<DatabaseRepository>(context, listen: false)
            .insertAnnotation(newMeal);
      } //if
      //...otherwise, edit it.
      else {
        Annotation updatedAnnotation = Annotation(
            widget.annotation!.id,
            int.parse(_minController.text),
            int.parse(_mlController.text),
            _moodController.text,
            _selectedDate); //!!
        await Provider.of<DatabaseRepository>(context, listen: false)
            .updateAnnotation(updatedAnnotation);
      } //else
      Navigator.pop(context);
    } //if
  } // _validateAndSave

  //Utility method that deletes a Annotation entry.
  void _deleteAndPop(BuildContext context) async {
    await Provider.of<DatabaseRepository>(context, listen: false)
        .removeAnnotation(widget.annotation!);
    Navigator.pop(context);
  } //_deleteAndPop

} //AnnotationPage

