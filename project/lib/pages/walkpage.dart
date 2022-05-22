import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/models/walk.dart';
import 'package:project/models/walkDB.dart';
import 'package:project/widgets/formTiles.dart';
import 'package:project/widgets/formSeparator.dart';
import 'package:project/utils/formats.dart';

// Class that implement the page to be used to edit existing walks and add new walks.
// It's a StatefulWidget since it needs to rebuild when the form fields change.
class WalkPage extends StatefulWidget {
  // WalkPage needs to know the index of the walk we are editing (it is equal to -1 if the walk is new)
  final int walkIndex;
  // Passing the instance of WalkDB --> is not mandatory and maybe redundant, but it will allow to initialize easily the form values.
  final WalkDB walkDB;

  // WalkPage constructor
  WalkPage({Key? key, required this.walkDB, required this.walkIndex})
      : super(key: key);

  static const route = '/home/activity/walk'; // controlla
  static const routeDisplayName = 'Walk page';

  @override
  State<WalkPage> createState() => _WalkPageState();
} //WalkPage

//Class that manages the state of WalkPage
class _WalkPageState extends State<WalkPage> {
  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _kmController = TextEditingController();
  TextEditingController _litriController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  //Here, we are using initState() to initialize the form fields values.
  //Rationale: Walk km and time are not known if the walk is new (walkIndex == -1).
  //  In this case, initilize them to empty and now(), respectively, otherwise set them to the respective values.
  @override
  void initState() {
    _kmController.text = widget.walkIndex == -1
        ? ''
        : widget.walkDB.walks[widget.walkIndex].km.toString();
    _selectedDate = widget.walkIndex == -1
        ? DateTime.now()
        : widget.walkDB.walks[widget.walkIndex].dateTime;
    _litriController.text = widget.walkIndex == -1
        ? ''
        : widget.walkDB.walks[widget.walkIndex].litri.toString();
    super.initState();
  } // initState

  //Remember that form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _kmController.dispose();
    _litriController.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {
    print(
        '${WalkPage.routeDisplayName} built'); //route display name for debugging

    //The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    //A FAB is showed to provide the "delete" functinality. It is showed only if the walk already exists.
    return Scaffold(
      appBar: AppBar(
        title: Text(WalkPage.routeDisplayName),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _validateAndSave(context),
              icon: Icon(Icons.done))
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.walkIndex == -1
          ? null
          : FloatingActionButton(
              onPressed: () => _deleteAndPop(context),
              child: Icon(Icons.delete),
            ),
    );
  } //build

  //Utility method used to build the form:
  //1. implement a Form;
  //2. Define custom-made FormTiles (look at the widgets/formSeparator.dart and widgets/formTiles.dart files);
  //3. Implement a Date+Time picker (look at the _selectDate utility method).
  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FormSeparator(label: 'My walk'),
            FormNumberTile(
              labelText: 'Km',
              controller: _kmController,
              icon: MdiIcons.walk,
            ),
            FormSeparator(label: 'Walk date and time'),
            FormDateTile(
              labelText: 'Walk date and time',
              date: _selectedDate,
              icon: MdiIcons.clockTimeFourOutline,
              onPressed: () {
                _selectDate(context);
              },
              dateFormat: Formats.fullDateFormatNoSeconds,
            ),
            FormSeparator(label: 'Litri bevuti'),
            FormNumberTile(
              labelText: 'Litri',
              controller: _litriController,
              icon: MdiIcons.walk,
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
  } //_selectDate

  //Utility method that validate the form and, if it is valid, save the new meal information.
  void _validateAndSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Walk newWalk = Walk(
          km: double.parse(_kmController.text),
          dateTime: _selectedDate,
          litri: int.parse(_litriController.text));
      widget.walkIndex == -1
          ? widget.walkDB.addWalk(newWalk)
          : widget.walkDB.editWalk(widget.walkIndex, newWalk);
      Navigator.pop(context);
    }
  } // _validateAndSave

  //Utility method that deletes a walk entry.
  void _deleteAndPop(BuildContext context) {
    widget.walkDB.deleteWalk(widget.walkIndex);
    Navigator.pop(context);
  } //_deleteAndPop

} //WalkPage
