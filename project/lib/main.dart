import 'package:flutter/material.dart';

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
        GoalPage.route: (context) => CalendarPage(),
        EditEventPage.route: (context) => EditEventPage(),
        EditProfilePage.route: (context) => EditProfilePage(),
      },
    );
  } //build
}//MyApp