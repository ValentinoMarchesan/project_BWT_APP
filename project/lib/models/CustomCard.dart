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
                  colors: [Colors.orangeAccent, Colors.deepOrange],
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
                  Icon(Icons.heart_broken),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text('HEART RATE', style: TextStyle(fontFamily: 'Audiowide')),
                  SizedBox(
                    width: 190,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  color: Color.fromARGB(255, 236, 200, 145),
                  height: 100,
                  width: 100,
                  child: Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_l09h6eer.json'),
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 284.7,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 236, 200, 145),
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
                    children: const [
                      Text(
                        'Through the data acquired by the device, it provides an overview of cardiac activity',
                        style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Audiowide'),
                        textAlign: TextAlign.justify,
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
                  colors: [Colors.orangeAccent, Colors.deepOrange],
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
                    Icons.dark_mode,
                  ),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text('SLEEP MONITORING',
                      style: TextStyle(fontFamily: 'Audiowide')),
                  SizedBox(
                    width: 132,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 100,
                  color: Color.fromARGB(
                    255,
                    236,
                    200,
                    145,
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 236, 200, 145),
                  height: 100,
                  width: 100,
                  child: Lottie.network(
                      'https://assets10.lottiefiles.com/packages/lf20_jy3vmooe.json'),
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 274.7,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 236, 200, 145),
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
                    children: const [
                      Text(
                        'Through the data acquired by the device, it provides an overview of sleep activity',
                        style: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Audiowide'),
                        textAlign: TextAlign.justify,
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
//_______________ STEEP MONITORING CARD ________________________________________
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
                  colors: [Colors.orangeAccent, Colors.deepOrange],
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
                  Icon(Icons.run_circle),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text('STEPS MONITORING',
                      style: TextStyle(fontFamily: 'Audiowide')),
                  SizedBox(
                    width: 128,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 100,
                  color: Color.fromARGB(
                    255,
                    236,
                    200,
                    145,
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 236, 200, 145),
                  height: 100,
                  width: 100,
                  child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_umwjpnnn.json'),
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 264.7,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 236, 200, 145),
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
                    children: const [
                      Text(
                        'Through the data acquired by the device, it provides an overview of steps activity',
                        style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Audiowide'),
                        textAlign: TextAlign.justify,
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
                  colors: [Colors.orangeAccent, Colors.deepOrange],
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
                  Icon(FontAwesomeIcons.weightScale),
                  SizedBox(
                    height: 1,
                    width: 10,
                  ),
                  Text('BMI CALCULATOR',
                      style: TextStyle(fontFamily: 'Audiowide')),
                  SizedBox(
                    width: 145,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Container(
              //colore interno
              height: 100,
              //width: 234.7,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 236, 200, 145),
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
                children: const [
                  Text(
                    'In this section you can calculate the BMI index by entering the age, weight and height. You also receive a feedback on the physical state.',
                    style: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Audiowide'),
                    textAlign: TextAlign.justify,
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
