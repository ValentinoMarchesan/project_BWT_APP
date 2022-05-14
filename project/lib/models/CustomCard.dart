import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/activitypage.dart';
import 'package:project/pages/caloriespage.dart';
import 'package:project/pages/heartpage.dart';
import 'package:project/pages/sleeppage.dart';
import 'package:project/pages/steppage.dart';

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
      child: Column(
        children: [
          Container(
            //colore interno
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //sfumatura
                colors: [Colors.orangeAccent, Colors.deepOrange],
                // direzione della sfumatura
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
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
                    image: NetworkImage(
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
                decoration: BoxDecoration(
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
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
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
      child: Column(
        children: [
          Container(
            //colore interno
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //sfumatura
                colors: [Colors.orangeAccent, Colors.deepOrange],
                // direzione della sfumatura
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.dark_mode),
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
                    image: NetworkImage(
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
                decoration: BoxDecoration(
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
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
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
      child: Column(
        children: [
          Container(
            //colore interno
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //sfumatura
                colors: [Colors.orangeAccent, Colors.deepOrange],
                // direzione della sfumatura
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
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
                    image: NetworkImage(
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
                decoration: BoxDecoration(
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
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
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
    );
  }

  void _toStepPage(BuildContext context) {
    Navigator.pushNamed(context, StepPage.route);
  } //_toStepPage
}

//______________________________________________________________________________
//_______________________ ACTIVITY CARD ________________________________________
//______________________________________________________________________________

class CardActivity extends StatelessWidget {
  const CardActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // forma dei bordi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      // contenuto
      child: Column(
        children: [
          Container(
            //colore interno
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //sfumatura
                colors: [Colors.orangeAccent, Colors.deepOrange],
                // direzione della sfumatura
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.no_meals),
                SizedBox(
                  height: 1,
                  width: 10,
                ),
                Text('CALORIES'),
                SizedBox(
                  width: 230,
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
                    image: NetworkImage(
                        'https://media.istockphoto.com/photos/sports-equipment-on-green-grass-top-view-picture-id905105146'),
                    // rendere la card schiacciabile
                    width: 200,
                    height: 100,
                    child: InkWell(
                      onTap: () => _toCaloriesPage(context),
                    ),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Container(
                //colore interno
                height: 100,
                width: 184.7,
                decoration: BoxDecoration(
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
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
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
    );
  }

  void _toCaloriesPage(BuildContext context) {
    Navigator.pushNamed(context, CaloriesPage.route);
  }
}
