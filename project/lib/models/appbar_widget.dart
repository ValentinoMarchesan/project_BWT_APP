import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/chart/databaseRepository.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shared_preferences/shared_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: const Text(ProfilePage.routename),
    // leading: BackButton(),
    backgroundColor: Colors.orangeAccent,
    elevation: 0,
    actions: [
      IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Alert(
                context: context,
                title: 'LOGOUT',
                desc:
                    'Do you want logout from your account and delete the fetched data',
                style: const AlertStyle(
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
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  DialogButton(
                    radius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.orangeAccent,
                    child: const Text('Yes'),
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
  Consumer<DatabaseRepository>(builder: ((context, dbr, child) {
    dbr.deleteAllHeart();

    return Text('delete all thing');
  }));

  sp.remove('prova');
  sp.remove('username');
  sp.setBool('confirm', false);
  Navigator.of(context).pushReplacementNamed(LoginPage.route);
  //Navigator.pushNamed(context, LoginPage.route);
}
