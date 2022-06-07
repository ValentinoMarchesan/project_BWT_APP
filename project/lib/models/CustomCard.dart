import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  Text('HEART RATE'),
                  SizedBox(
                    width: 210,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    // parte per posizionare immagine
                    Ink.image(
                      image: const NetworkImage(
                          'https://image.shutterstock.com/image-illustration/cardio-exercise-increases-hearts-health-600w-173381630.jpg'),
                      // rendere la card schiacciabile
                      width: 200,
                      height: 100,
                      child: InkWell(onTap: () => _toHeartPage(context)),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 184.7,
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
                  Text('SLEEP MONITORING'),
                  SizedBox(
                    width: 165,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    // parte per posizionare immagine
                    Ink.image(
                      image: const NetworkImage(
                          'https://image.shutterstock.com/image-vector/sleep-cycle-labeled-night-stages-600w-1945387777.jpg'),
                      // rendere la card schiacciabile
                      width: 200,
                      height: 100,
                      child: InkWell(
                        onTap: () => _toSleepPage(context),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 184.7,
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
                        'Inserire Testo',
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
                  Text('STEPS MONITORING'),
                  SizedBox(
                    width: 160,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    // parte per posizionare immagine
                    Ink.image(
                      image: const NetworkImage(
                          'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                      // rendere la card schiacciabile
                      width: 200,
                      height: 100,
                      child: InkWell(
                        onTap: () => _toStepPage(context),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Container(
                  //colore interno
                  height: 100,
                  width: 184.7,
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
                        'Inserire Testo',
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
                  Text('BMI CALCULATOR'),
                  SizedBox(
                    width: 181,
                  ),
                  Icon(Icons.view_column),
                ],
              ),
            ),
            /*
          Row(
            children: [
              Stack(
                children: [
                  // parte per posizionare immagine
                  Ink.image(
                    image: NetworkImage(
                        'https://media.istockphoto.com/photos/sports-equipment-on-green-grass-top-view-picture-id905105146'),
                    // rendere la card schiacciabile
                    width: 150,
                    height: 100,
                    child: InkWell(
                      onTap: () => _toBmiPage(context),
                    ),
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              */
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
                    'In this section you can calculate the BMI index by entering the age, weight and height. You also receive a feedback on the physical state based on data collected on the activity carried out in the last seven days. ',
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
