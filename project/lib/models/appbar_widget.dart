import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/classes/UserPreferences.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(ProfilePage.routename),
    // leading: BackButton(),
    backgroundColor: Colors.orangeAccent,
    elevation: 0,
    actions: [
      IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            _toLoginPage(context);
          })
    ],
  );
}

void _toLoginPage(BuildContext context) async {
  await FitbitConnector.unauthorize(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret);
  final sp = await SharedPreferences.getInstance();
  sp.remove('username');
  Navigator.of(context).pushReplacementNamed(LoginPage.route);
  //Navigator.pushNamed(context, LoginPage.route);
}
