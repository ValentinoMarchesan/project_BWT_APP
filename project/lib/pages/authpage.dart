import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/entities/activity.dart';
import '../database/entities/heart.dart';
import '../database/entities/sleep.dart';
import '../repositories/databaseRepository.dart';

//define the page that makes the authorizization

class AuthPage extends StatelessWidget {
  static const route = '/login/';
  static const routename = 'AuthPage';
  @override
  Widget build(BuildContext context) {
    print('${AuthPage.routename} built');
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          //shade
          colors: [
            const Color.fromARGB(255, 239, 65, 123),
            const Color.fromARGB(255, 244, 190, 110)
          ],
          // direction of shade
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        //create the box for the authorization
        child: AlertDialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60.0)),
          title: const Text(
            'AUTHORIZATION',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 150, 201, 157),
                fontFamily: 'Audiowide'),
            textAlign: TextAlign.center,
            textScaleFactor: 1.2,
          ),
          content: const Text(
            'To continue, you must authorize data sharing from the Fitbit site.',
            style: TextStyle(fontFamily: 'OpenSans', fontSize: 17),
            textAlign: TextAlign.center,
          ),
          actions: [
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Color.fromARGB(219, 221, 59, 113),
              child: const Text(
                'NO',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
              ),
              //if you not authorize you come back to login page
              onPressed: () async {
                _toLoginPage(context);
                final sp = await SharedPreferences.getInstance();
                sp.setBool('confirm', false);
              },
            ),
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Color.fromARGB(255, 149, 222, 144),
              child: const Text(
                'YES',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
              ),
              onPressed: () async {
                _initializeDB(context);
                String? userId = await FitbitConnector.authorize(
                    context: context,
                    clientID: Strings.fitbitClientID,
                    clientSecret: Strings.fitbitClientSecret,
                    redirectUri: Strings.fitbitRedirectUri,
                    callbackUrlScheme: Strings.fitbitCallbackScheme);
                final sp = await SharedPreferences.getInstance();
                if (userId == null) {
                  Navigator.of(context).pushReplacementNamed(LoginPage.route);
                } else {
                  sp.setString('userid', userId);
                  sp.setBool('confirm', true);
                  sp.setInt('hour', DateTime.now().hour);
                  sp.setInt('hour1', DateTime.now().hour);
                  sp.setInt('hour2', DateTime.now().hour);

                  Navigator.of(context).pushReplacementNamed(HomePage.route);
                }
              },
            )
          ],
        ),
      ),
    );
  }
} //AuthPage

//come back to login page from authorization page
void _toLoginPage(BuildContext context) async {
  await FitbitConnector.unauthorize(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret);
  final sp = await SharedPreferences.getInstance();
  sp.remove('username');
  Navigator.of(context).pushReplacementNamed(LoginPage.route);
}

//inizialize the database if it is empty
void _initializeDB(BuildContext context) async {
  final sp = await SharedPreferences.getInstance();
  //series of control data for the sleep,activity, heart and game page
  sp.setBool('sleep', false);
  sp.setBool('activity', false);
  sp.setBool('heart', false);
  sp.setBool('game', false);

  final lista = await Provider.of<DatabaseRepository>(context, listen: false)
      .findAllHeart();
  final lista2 = await Provider.of<DatabaseRepository>(context, listen: false)
      .findAllActivity();
  final lista3 = await Provider.of<DatabaseRepository>(context, listen: false)
      .findAllSleep();
  if (lista.isEmpty && lista2.isEmpty && lista3.isEmpty) {
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(1, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(2, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(3, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertHeart(Heart(4, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(1, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(2, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(3, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(4, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(5, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(6, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertActivity(Activity(7, 0, 0, 0, 0));
    Provider.of<DatabaseRepository>(context, listen: false)
        .insertSleep(Sleep(1, 0));
  }
}
