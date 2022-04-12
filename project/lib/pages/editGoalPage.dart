import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//cupertino package is unnecessary!

class EditGoalPage extends StatelessWidget {
  const EditGoalPage({Key? key}) : super(key: key);

  static const route = '/Goal/edit_event/';
  static const routename = 'EditGoalPage';

  @override
  Widget build(BuildContext context) {
    print('${EditGoalPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(EditGoalPage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('To the GoalPage'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  } //build

} //EditEventPage