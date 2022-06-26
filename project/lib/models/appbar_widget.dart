import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/pages/heartpage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/repositories/databaseRepository.dart';
import 'package:project/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shared_preferences/shared_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: const Text(
      'MY PROFILE',
      style: TextStyle(fontFamily: 'Audiowide'),
      textAlign: TextAlign.center,
    ),
    // leading: BackButton(),
    backgroundColor: const Color.fromARGB(255, 254, 183, 77),
    elevation: 0,
    actions: [
      IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Alert(
                context: context,
                title: 'LOGOUT',
                desc: 'Do you want to logout from your account?',
                style: const AlertStyle(
                  titleStyle: TextStyle(
                    fontFamily: 'Audiowide',
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
                    color: const Color.fromARGB(255, 254, 183, 77),
                    child: const Text(
                      'NO',
                      style: TextStyle(
                          fontFamily: 'Audiowide',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  DialogButton(
                    radius: const BorderRadius.all(Radius.circular(30)),
                    color: const Color.fromARGB(255, 254, 183, 77),
                    child: const Text(
                      'YES',
                      style: TextStyle(
                          fontFamily: 'Audiowide',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      _toLoginPage_DeleteAll(context);
                    },
                  )
                ]).show();
          })
    ],
  );
}

AppBar buildAppBarHeartPage(BuildContext context) {
  return AppBar(
    title: const Text(
      HeartPage.routename,
      style: TextStyle(
        fontFamily: 'Audiowide',
      ),
    ),
    centerTitle: true,
    // leading: BackButton(),
    flexibleSpace: Container(
        decoration: BoxDecoration(
      gradient: LinearGradient(
        //sfumatura
        colors: [
          Color.fromARGB(255, 239, 65, 123),
          Color.fromARGB(255, 244, 190, 110)
        ],
        // direzione della sfumatura
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    )),
    elevation: 0,
    actions: [
      IconButton(
          icon: const Icon(FontAwesomeIcons.info),
          onPressed: () {
            Alert(
                context: context,
                title: 'INFO',
                //esc:

                content: SizedBox(
                  child: Column(children: const [
                    Text(
                        'Fitbit identifies three heart rate zones: Peak, cardio, and fat burn. These zones are based on your maximum heart rate (maximum heart rate can be custom inserted or computed by the formula 220-age).\n'
                        '\n•	Peak zone is where the most intense portion of your workouts happen, and you are at 80 to 100 percent of your maximum heart rate.\n '
                        '\n•	The cardio zone, which is 70 to 84 percent of your max heart rate, is where the hard work is done when you’re training for a big event. You can usually sustain it for about 30 minutes.\n '
                        '\n•	 In the fat burn zone, moderate workouts use 50 to 69 percent of your maximum heart rate.\n',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                        ))
                  ]),
                ),
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
                    color: const Color.fromARGB(255, 254, 183, 77),
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ]).show();
          })
    ],
  );
}

void _toLoginPage_DeleteAll(BuildContext context) async {
  await FitbitConnector.unauthorize(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret);
  final sp = await SharedPreferences.getInstance();
  await Provider.of<DatabaseRepository>(context, listen: false).deleteAllData();
  //await Provider.of<DatabaseRepository>(context, listen: false).deleteAllData();
  sp.remove('username');
  sp.setBool('confirm', false);
  Navigator.of(context).pushReplacementNamed(LoginPage.route);

  //Navigator.pushNamed(context, LoginPage.route);
}
