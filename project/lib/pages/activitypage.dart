import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project/models/walkDB.dart';
import 'package:project/pages/walkpage.dart';
import 'package:project/utils/formats.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  static const route = '/home/activity';
  static const routename = 'Activity Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ActivityPage.routename),
        centerTitle: true,
      ),
      body: Center(
        //Using a Consumer because we want the UI showing the list of walks to rebuild every time the walk DB updates.
        child: Consumer<WalkDB>(
          builder: (context, walkDB, child) {
            // If the list of walks is empty, show a simple Text, otherwise show the list of walks using a ListView.
            return walkDB.walks.isEmpty
                ? Text('The walk list is currently empty')
                : ListView.builder(
                    itemCount: walkDB.walks.length,
                    itemBuilder: (context, walkIndex) {
                      //1. Using the Card widget to wrap each ListTile;
                      //2. Using DateTime to manage dates;
                      //3. Using a custom DateFormats to format the DateTime (look at the utils/formats.dart file);
                      //4. Improving UX adding a leading and a trailing to the ListTile

                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(MdiIcons.walk),
                          trailing: Icon(MdiIcons.noteEdit),
                          title: Text('Metri : ${walkDB.walks[walkIndex].km}'),
                          subtitle: Text(
                              '${Formats.fullDateFormatNoSeconds.format(walkDB.walks[walkIndex].dateTime)}'),
                          //When a ListTile is tapped, the user is redirected to the WalkPage, where it will be able to edit it.
                          onTap: () => _toWalkPage(context, walkDB, walkIndex),
                        ),
                      );
                    });
          },
        ),
      ),
      //Using a FAB to let the user add new walks.
      //Rationale: Using -1 as mealIndex to let WalkPage know that we want to add a new walk.
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.plus),
        onPressed: () => _toWalkPage(
            context, Provider.of<WalkDB>(context, listen: false), -1),
      ),
    );
  } //build

  //Utility method to navigate to WalkPage
  void _toWalkPage(BuildContext context, WalkDB walkDB, int walkIndex) {
    Navigator.pushNamed(context, WalkPage.route,
        arguments: {'walkIndex': walkIndex, 'walkDB': walkDB});
  } //_toWalkPage
}
