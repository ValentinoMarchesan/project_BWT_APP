import 'package:flutter/material.dart';
import 'package:project/pages/classes/UserPreferences.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';

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

void _toLoginPage(BuildContext context) {
  Navigator.pushNamed(context, LoginPage.route);
}
