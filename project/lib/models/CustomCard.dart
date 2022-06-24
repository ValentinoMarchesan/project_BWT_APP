import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:project/pages/bmipage.dart';
import 'package:project/pages/heartpage.dart';
import 'package:project/pages/sleeppage.dart';
import 'package:project/pages/steppage/steppage.dart';

//______________________________________________________________________________
//_______________ HEART RATE CARD ______________________________________________
//______________________________________________________________________________
class CardHR extends StatelessWidget {
  const CardHR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // forma dei bordi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      // contenuto
      child: GestureDetector(
        onTap: () => _toHeartPage(context),
        child: Column(
          children: [
            Container(
              //colore interno
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  //sfumatura
                  colors: [
                    const Color.fromARGB(255, 239, 65, 123),
                    const Color.fromARGB(255, 244, 190, 110)
                  ],
                  // direzione della sfumatura
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.heart_broken,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text(
                    'HEART MONITORING',
                    style:
                        TextStyle(fontFamily: 'Audiowide', color: Colors.white),
                  ),
                  SizedBox(
                    width: 132,
                  ),
                  Icon(
                    Icons.view_column,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/homepage/heart_home.png',
                      scale: 80, fit: BoxFit.scaleDown),
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 284.7,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    /*gradient: LinearGradient(
                    //sfumatura
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    // direzione della sfumatura
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  */
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Through the data acquired by your device, it provides an overview of your cardiac activity',
                        style: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toHeartPage(BuildContext context) {
    Navigator.pushNamed(context, HeartPage.route);
  } //_toStepPage
}

//______________________________________________________________________________
//_______________ SLEEP MONITORING CARD ________________________________________
//______________________________________________________________________________

class CardSM extends StatelessWidget {
  const CardSM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // forma dei bordi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      // contenuto
      child: GestureDetector(
        onTap: () => _toSleepPage(context),
        child: Column(
          children: [
            Container(
              //colore interno
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  //sfumatura
                  colors: [
                    const Color.fromARGB(255, 239, 65, 123),
                    const Color.fromARGB(255, 244, 190, 110)
                  ],
                  // direzione della sfumatura
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.dark_mode, color: Colors.white),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text('SLEEP MONITORING',
                      style: TextStyle(
                          fontFamily: 'Audiowide', color: Colors.white)),
                  SizedBox(
                    width: 132,
                  ),
                  Icon(Icons.view_column, color: Colors.white),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 100,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                Container(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/homepage/sleep_home.png',
                      scale: 5, fit: BoxFit.none),
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 274.7,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    /*gradient: LinearGradient(
                    //sfumatura
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    // direzione della sfumatura
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  */
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Through the data acquired by your device, it provides an overview of your sleep activity',
                        style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'OpenSans'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toSleepPage(BuildContext context) {
    Navigator.pushNamed(context, SleepPage.route);
  } //_toStepPage
}

//______________________________________________________________________________
//_______________ STEP MONITORING CARD ________________________________________
//______________________________________________________________________________

class CardSteep extends StatelessWidget {
  const CardSteep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // forma dei bordi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      // contenuto
      child: GestureDetector(
        onTap: () => _toStepPage(context),
        child: Column(
          children: [
            Container(
              //colore interno
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  //sfumatura
                  colors: [
                    const Color.fromARGB(255, 239, 65, 123),
                    const Color.fromARGB(255, 244, 190, 110)
                  ],
                  // direzione della sfumatura
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.run_circle, color: Colors.white),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text('STEPS MONITORING',
                      style: TextStyle(
                          fontFamily: 'Audiowide', color: Colors.white)),
                  SizedBox(
                    width: 128,
                  ),
                  Icon(Icons.view_column, color: Colors.white),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 100,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                Container(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    height: 100,
                    width: 80,
                    child: Image.asset('assets/homepage/walk_home.png',
                        scale: 15, fit: BoxFit.none)),
                Container(
                  //colore interno
                  height: 100,
                  width: 264.7,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    /*gradient: LinearGradient(
                    //sfumatura
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    // direzione della sfumatura
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  */
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Through the data acquired by your device, it provides an overview of your step activity',
                        style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'OpenSans'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toStepPage(BuildContext context) {
    Navigator.pushNamed(context, StepPage.route);
  } //_toStepPage
}

//______________________________________________________________________________
//_______________________ ACTIVITY CARD ________________________________________
//______________________________________________________________________________

class Cardbmi extends StatelessWidget {
  const Cardbmi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // forma dei bordi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      // contenuto
      child: GestureDetector(
        onTap: () => _toBmiPage(context),
        child: Column(
          children: [
            Container(
              //colore interno
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  //sfumatura
                  colors: [
                    const Color.fromARGB(255, 239, 65, 123),
                    const Color.fromARGB(255, 244, 190, 110)
                  ],
                  // direzione della sfumatura
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(FontAwesomeIcons.weightScale, color: Colors.white),
                  SizedBox(
                    height: 1,
                    width: 15,
                  ),
                  Text(
                    'BMI CALCULATOR',
                    style:
                        TextStyle(fontFamily: 'Audiowide', color: Colors.white),
                  ),
                  SizedBox(
                    width: 145,
                  ),
                  Icon(Icons.view_column, color: Colors.white),
                ],
              ),
            ),
            Container(
              //colore interno
              height: 100,
              //width: 234.7,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                /*gradient: LinearGradient(
                                //sfumatura
                                colors: [Colors.orangeAccent, Colors.deepOrange],
                                // direzione della sfumatura
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                ),
                              */
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Calculate your BMI, it is very simple! Just enter your age, weight and height and you will receive a feedback on your physical state',
                    style: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'OpenSans'),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
        //],
      ),
    );
  }

  void _toBmiPage(BuildContext context) {
    Navigator.pushNamed(context, BmiPage.route);
  }
}
