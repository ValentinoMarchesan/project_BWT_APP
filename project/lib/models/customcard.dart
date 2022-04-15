import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CardHR() => Card(
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
                    child: InkWell(
                      onTap: () {},
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

Widget CardSleepM() => Card(
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
                      onTap: () {},
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

Widget Cardsteps() => Card(
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
                      onTap: () {},
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

Widget CardActivity() => Card(
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
                Icon(Icons.fitness_center),
                SizedBox(
                  height: 1,
                  width: 10,
                ),
                Text('ACTIVITY'),
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
                      onTap: () {},
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
