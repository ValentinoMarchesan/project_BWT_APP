import 'package:flutter/material.dart';
import 'package:project/pages/activitypage.dart';
import 'package:project/pages/editGoalPage.dart';
import 'package:project/pages/editProfilePage.dart';
import 'package:project/pages/goalPage.dart';
import 'package:project/pages/heartpage.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/pages/sleeppage.dart';
import 'package:project/pages/steppage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (context) => LoginPage(),
        HomePage.route: (context) => HomePage(),
        ProfilePage.route: (context) => ProfilePage(),
        GoalPage.route: (context) => GoalPage(),
        EditGoalPage.route: (context) => EditGoalPage(),
        EditProfilePage.route: (context) => EditProfilePage(),
        ActivityPage.route: (context) => ActivityPage(),
        StepPage.route: (context) => StepPage(),
        HeartPage.route: (context) => HeartPage(),
        SleepPage.route: (context) => SleepPage(),
      },
    );
  } //build
}//MyApp