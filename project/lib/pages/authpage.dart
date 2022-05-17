import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'AuthPage';

  @override
  Widget build(BuildContext context) {
    print('${AuthPage.routename} built');
    return Container(
      color: Color.fromARGB(255, 254, 183, 77),
      child: ElevatedButton(
        onPressed: () async {
          // Authorize the app
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
        child: Text('AUTHORIZATION'),
      ),
    );
  } //build

} //Page