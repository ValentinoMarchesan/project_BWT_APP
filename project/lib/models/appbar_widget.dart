import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/classes/UserPreferences.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/utils/strings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
            Alert(
                context: context,
                title: 'LOGOUT',
                desc: 'Do you want logout from your account',
                style: AlertStyle(
                  titleStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          color: Color.fromARGB(255, 210, 239, 244),
                          blurRadius: 2)
                    ],
                    letterSpacing: 2,
                  ),
                  descStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    shadows: [
                      Shadow(
                          color: Color.fromARGB(255, 210, 239, 244),
                          blurRadius: 2)
                    ],
                    letterSpacing: 2,
                  ),
                ),
                buttons: [
                  DialogButton(
                    radius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.orangeAccent,
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  DialogButton(
                    radius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.orangeAccent,
                    child: Text('Yes'),
                    onPressed: () {
                      _toLoginPage(context);
                    },
                  )
                ]).show();
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
  sp.setBool('confirm', false);
  Navigator.of(context).pushReplacementNamed(LoginPage.route);
  //Navigator.pushNamed(context, LoginPage.route);
}
