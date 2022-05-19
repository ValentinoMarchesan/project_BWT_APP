import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/utils/strings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'AuthPage';

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
              'To continue, you must authorise the sharing of data from fitbit site'),
          actions: [
            DialogButton(
              radius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.orangeAccent,
              child: Text('No'),
              onPressed: () => _toLoginPage(context),
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
                final sp = await SharedPreferences.getInstance();
                sp.setString('userid', userId!);
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
