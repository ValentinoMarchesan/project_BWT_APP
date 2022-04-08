import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/editGoalPage.dart';

//GoalPage
class GoalPage extends StatelessWidget {
  const GoalPage({Key? key}) : super(key: key);

  static const route = '/goal/';
  static const routename = 'GoalPage';

  @override
  Widget build(BuildContext context) {
    print('${GoalPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(GoalPage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('To the HomePage'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('To the EditEventPage'),
              onPressed: () {
                _toEditGoalPage(context);
              },
            ),
          ],
        ),
      ),
    );
  } //Build

  void _toEditGoalPage(BuildContext context) {
    //Push the EditEventPage
    Navigator.pushNamed(context, EditGoalPage.route);
  } //_toEditEventPage

} //GoalPage
