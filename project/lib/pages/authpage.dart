import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/utils/strings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'AuthPage';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static late SharedPreferences prova;
  void initState() async {
    prova = await SharedPreferences.getInstance();
    super.initState();
    //check if the user is already Logged in before rendering the loginpage
    _checkLogin();
  } //initstate

  void _checkLogin() async {
    //get the sharedpreferences instance and check
    final sp = await SharedPreferences
        .getInstance(); //---------------questo commentato
    //if username is set push homepage

    //if (prova.getstring .............)
    if (sp.getString('username') != null && sp.getBool('confirm') == true) {
      Navigator.of(context).pushReplacementNamed(HomePage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${AuthPage.routename} built');
    return Container(
      color: Color.fromARGB(255, 244, 190, 110),
      child: SafeArea(
        child: AlertDialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60.0)),
          title: Text(
            'AUTHORIZATION',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
              'To continue, you must authorize data sharing from the fitbit site'),
          actions: [
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.orangeAccent,
              child: Text('No'),
              onPressed: () async {
                _toLoginPage(context);
                final sp = await SharedPreferences.getInstance();
                sp.setBool('confirm', false);
              },
            ),
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.orangeAccent,
              child: Text('Yes'),
              onPressed: () async {
                String? userId = await FitbitConnector.authorize(
                    context: context,
                    clientID: Strings.fitbitClientID,
                    clientSecret: Strings.fitbitClientSecret,
                    redirectUri: Strings.fitbitRedirectUri,
                    callbackUrlScheme: Strings.fitbitCallbackScheme);
                final sp = await SharedPreferences
                    .getInstance(); //---------questo commentato
                sp.setString('userid', userId!); //prova.setstring.......
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
