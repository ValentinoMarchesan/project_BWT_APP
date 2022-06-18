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

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'AuthPage';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  /*
  void initState() {
    super.initState();
    //check if the user is already Logged in before rendering the loginpage
    _checkLogin();
  } //initstate

  void _checkLogin() async {
    //get the sharedpreferences instance and check
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('username') != null && sp.getBool('confirm') == true) {
      Navigator.of(context).pushReplacementNamed(HomePage.route);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    print('${AuthPage.routename} built');
    return Container(
      color: const Color.fromARGB(255, 244, 190, 110),
      child: SafeArea(
        child: AlertDialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60.0)),
          title: const Text(
            'AUTHORIZATION',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'To continue, you must authorize data sharing from the fitbit site'),
          actions: [
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.orangeAccent,
              child: const Text('No'),
              onPressed: () async {
                _toLoginPage(context);
                final sp = await SharedPreferences.getInstance();
                sp.setBool('confirm', false);
              },
            ),
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.orangeAccent,
              child: const Text('Yes'),
              onPressed: () async {
                _initializeDB(context);
                String? userId = await FitbitConnector.authorize(
                    context: context,
                    clientID: Strings.fitbitClientID,
                    clientSecret: Strings.fitbitClientSecret,
                    redirectUri: Strings.fitbitRedirectUri,
                    callbackUrlScheme: Strings.fitbitCallbackScheme);
                final sp = await SharedPreferences.getInstance();
                sp.setString('userid', userId!);
                sp.setBool('confirm', true);

                Navigator.of(context).pushReplacementNamed(HomePage.route);
              },
            )
          ],
        ),
      ),
    );
  }
} //Page

void _toLoginPage(BuildContext context) async {
  await FitbitConnector.unauthorize(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret);
  final sp = await SharedPreferences.getInstance();
  sp.remove('username');
  Navigator.of(context).pushReplacementNamed(LoginPage.route);
  //Navigator.pushNamed(context, LoginPage.route);
}

void _initializeDB(BuildContext context) async {
  final sp = await SharedPreferences.getInstance();
  sp.setBool('sleep', false);
  sp.setBool('activity', false);
  sp.setBool('heart',
      false); //this is for the hearthpage in the case the database is fill with the default values
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
