import 'package:confetti/confetti.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/database/entities/activity.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:project/pages/infopage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../repositories/databaseRepository.dart';
import '../utils/strings.dart';

/*
define the page in which you can see the MECO avatar
Inside that is applied the concept of Gamefication.
In particular is a combination of 'funny feedback' and 'Educational information'
*/
class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  static const route = '/home/game';
  static const routename = 'GAMEPAGE';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeCo',
            style: TextStyle(
              fontFamily: 'Goldman',
              fontSize: 50,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
            //shade
            colors: [
              Color.fromARGB(255, 239, 65, 123),
              Color.fromARGB(255, 244, 190, 110)
            ],
            // direction of shade
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        )),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.greenAccent,
                      height: 100,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        //shade
                        colors: [
                          Color.fromARGB(255, 239, 65, 123),
                          Color.fromARGB(255, 244, 190, 110)
                        ],
                        // direction of shade
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    height: 80,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 300,
            child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
              _aggiungoGM(dbr);
              return FutureBuilder(
                  initialData: null,
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final sp = snapshot.data as SharedPreferences;
                      if (sp.getBool('demo') == false) {
                        return FutureBuilder(
                            initialData: null,
                            future: dbr.findAllActivity(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data as List<Activity>;

                                final datastep = dbr.findstep(data);

                                final datasteps = datastep[0];
                                if (datasteps == null) {
                                  return CircularProgressIndicator();
                                } else if (datasteps > 6000) {
                                  return FutureBuilder(
                                      initialData: null,
                                      future: dbr.findAllSleep(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final data =
                                              snapshot.data as List<Sleep>;

                                          final datasleep =
                                              dbr.findminutsleep(data);

                                          if (datasleep == null) {
                                            return CircularProgressIndicator();
                                          } else if (datasleep >= 7 &&
                                              datasleep <= 9) {
                                            return FutureBuilder(
                                                initialData: null,
                                                future:
                                                    dbr.findAllAnnotations(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    final data = snapshot.data
                                                        as List<Annotation>;
//we associates different mood of MECO avatar based on steps done, hour of sleep, water drunk and minutes of meditation
//this is saved in status parameter, while statusinfo need to associate an info page to a mood of MECO
                                                    if (data.length == 0) {
                                                      sp.setInt(
                                                          'statusinfo', 1);
                                                      return Column(
                                                        children: [
                                                          Container(
                                                            child: Image.asset(
                                                                'assets/MeCo/happy.png'),
                                                            width: 400,
                                                            height: 300,
                                                          ),
                                                        ],
                                                      );
                                                    } else if (data[data.length -
                                                                    1]
                                                                .ml >
                                                            2000 &&
                                                        data[data.length - 1]
                                                                .min >
                                                            10) {
                                                      return AnimationWidget(
                                                        child: Container(
                                                          height: 300,
                                                          width: 400,
                                                          child: Image.asset(
                                                              'assets/MeCo/superhappy.png'),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container(
                                                        height: 300,
                                                        width: 400,
                                                        child: Image.asset(
                                                            'assets/MeCo/happy.png'),
                                                      );
                                                    }
                                                  } else {
                                                    return CircularProgressIndicator();
                                                  }
                                                });
                                          } else {
                                            sp.setInt('statusinfo', 2);
                                            return Container(
                                              height: 300,
                                              width: 400,
                                              child: Image.asset(
                                                  'assets/MeCo/sleepy.png'),
                                            );
                                          }
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      });
                                } else {
                                  return FutureBuilder(
                                      initialData: null,
                                      future: dbr.findAllSleep(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final data =
                                              snapshot.data as List<Sleep>;

                                          final datasleep =
                                              dbr.findminutsleep(data);

                                          if (datasleep == null) {
                                            return CircularProgressIndicator();
                                          } else if (datasleep >= 7 &&
                                              datasleep <= 9) {
                                            sp.setInt('statusinfo', 3);
                                            return Container(
                                              height: 300,
                                              width: 400,
                                              child: Image.asset(
                                                  'assets/MeCo/meh.png'),
                                            );
                                          } else {
                                            sp.setInt('statusinfo', 4);
                                            return Container(
                                              height: 300,
                                              width: 400,
                                              child: Image.asset(
                                                  'assets/MeCo/sad.png'),
                                            );
                                          }
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      });
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      } else {
                        //  STATUS ONLY FOR DEMO
                        return FutureBuilder(
                            initialData: null,
                            future: SharedPreferences.getInstance(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final sp = snapshot.data as SharedPreferences;
                                if (sp.getInt('status') == 1) {
                                  sp.setInt('statusinfo', 1);
                                  return Container(
                                      height: 300,
                                      width: 400,
                                      child:
                                          Image.asset('assets/MeCo/happy.png'));
                                } else if (sp.getInt('status') == 2) {
                                  sp.setInt('statusinfo', 2);
                                  return Container(
                                      height: 300,
                                      width: 400,
                                      child: Image.asset(
                                          'assets/MeCo/sleepy.png'));
                                } else if (sp.getInt('status') == 3) {
                                  sp.setInt('statusinfo', 3);
                                  return Container(
                                      height: 300,
                                      width: 400,
                                      child:
                                          Image.asset('assets/MeCo/meh.png'));
                                } else if (sp.getInt('status') == 4) {
                                  sp.setInt('statusinfo', 4);
                                  return Container(
                                      height: 300,
                                      width: 400,
                                      child:
                                          Image.asset('assets/MeCo/sad.png'));
                                } else if (sp.getInt('status') == 5) {
                                  sp.setInt('statusinfo', 5);
                                  return AnimationWidget(
                                    child: Container(
                                      height: 300,
                                      width: 400,
                                      child: Image.asset(
                                          'assets/MeCo/superhappy.png'),
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
          ),
          const SizedBox(
            height: 7,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  //shade
                  colors: [
                    Color.fromARGB(255, 239, 65, 123),
                    Color.fromARGB(255, 244, 190, 110)
                  ],
                  // direction of shade
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: 185,
              width: 360,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Hi, I\'m MeCo! By the end of this day, try to make me as happy as you can through your daily actions! Are you curious about how your current lifestyle affects me?',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontFamily: 'OpenSans',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SlideAction(
                      elevation: 8,
                      innerColor: Colors.white,
                      outerColor: Color.fromARGB(255, 149, 231, 201),
                      sliderButtonIcon: const Icon(FontAwesomeIcons.info,
                          color: Color.fromARGB(255, 149, 231, 201)),
                      text: '     SLIDE TO KNOW MORE',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Goldman',
                        color: Colors.white,
                      ),
                      onSubmit: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const InfoPage()),
                        );
                        //await the re build of our UI
                      }),
                    ),
                  ),
                ],
              )),
        ],
      ),
      // DEMO BUTTON
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment(-1, -0.75),
          ringColor: Colors.white.withAlpha(0),
          ringDiameter: 300.0,
          ringWidth: 80,
          fabSize: 50.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          fabColor: Colors.white,
          fabOpenIcon: const Icon(Icons.info_outline, color: Colors.orange),
          fabCloseIcon: const Icon(Icons.close, color: Colors.orange),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) async {
            if (isOpen) {
              final sp = await SharedPreferences.getInstance();
              sp.setBool('demo', true);
            } else {
              final sp = await SharedPreferences.getInstance();
              sp.setBool('demo', false);
              sp.remove('statusinfo');
              setState(() {});
            }
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 1);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceSmile,
                  color: Color.fromARGB(217, 198, 17, 104)),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 2);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceDizzy,
                  color: Color.fromARGB(217, 198, 17, 104)),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 3);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceMeh,
                  color: Color.fromARGB(217, 198, 17, 104)),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 4);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceSadCry,
                  color: Color.fromARGB(217, 198, 17, 104)),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 5);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceLaughSquint,
                  color: Color.fromARGB(217, 198, 17, 104)),
            ),
          ],
        ),
      ),
    );
  } //GamePage

//this method permit to fetch the activity data if the authorization is done and if no activity data has already fecthed. It also update the data in the database

  Future<void> _aggiungoGM(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    if (((sp.getBool('activity') == false || sp.getBool('sleep') == false)) &&
        sp.getBool('game') == false) {
      FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
          FitbitActivityTimeseriesDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        type: 'steps',
      );

      FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl =
          FitbitActivityTimeseriesAPIURL.weekWithResource(
        baseDate: DateTime.now(),
        userID: sp.getString('userid'),
        resource: fitbitActivityTimeseriesDataManager.type,
      );
      final stepsData = await fitbitActivityTimeseriesDataManager.fetch(
          fitbitActivityTimeseriesApiUrl) as List<FitbitActivityTimeseriesData>;

// _____________________________________________________________________________
//_____________________________FETCH ACTIVITY CALORIES DATA_____________________
      FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager2 =
          FitbitActivityTimeseriesDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        type: 'activityCalories',
      );
      FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl2 =
          FitbitActivityTimeseriesAPIURL.weekWithResource(
              baseDate: DateTime.now(),
              userID: sp.getString('userid'),
              resource: fitbitActivityTimeseriesDataManager2.type);
      final activitycalories = await fitbitActivityTimeseriesDataManager2
              .fetch(fitbitActivityTimeseriesApiUrl2)
          as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH CALORIES DATA______________________________
      FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager3 =
          FitbitActivityTimeseriesDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        type: 'calories',
      );
      FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl3 =
          FitbitActivityTimeseriesAPIURL.dayWithResource(
              date: DateTime.now(),
              userID: sp.getString('userid'),
              resource: fitbitActivityTimeseriesDataManager3.type);
      final calories = await fitbitActivityTimeseriesDataManager3
              .fetch(fitbitActivityTimeseriesApiUrl3)
          as List<FitbitActivityTimeseriesData>;
// _____________________________________________________________________________
//_____________________________FETCH MINUTES SEDEBTARY__________________________
      FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager4 =
          FitbitActivityTimeseriesDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        type: 'minutesSedentary',
      );
      FitbitActivityTimeseriesAPIURL fitbitActivityTimeseriesApiUrl4 =
          FitbitActivityTimeseriesAPIURL.dayWithResource(
              date: DateTime.now(),
              userID: sp.getString('userid'),
              resource: fitbitActivityTimeseriesDataManager4.type);
      final sedentary = await fitbitActivityTimeseriesDataManager4
              .fetch(fitbitActivityTimeseriesApiUrl4)
          as List<FitbitActivityTimeseriesData>;
      final activity = ActivityData(activitycalories, calories, sedentary);
      final steps = StepsData(stepsData);

      database.updateActivity(
          Activity(1, steps[0], activity[0], activity[1], activity[2]));
      database.updateActivity(Activity(2, steps[1], null, null, null));
      database.updateActivity(Activity(3, steps[2], null, null, null));
      database.updateActivity(Activity(4, steps[3], null, null, null));
      database.updateActivity(Activity(5, steps[4], null, null, null));
      database.updateActivity(Activity(6, steps[5], null, null, null));
      database.updateActivity(Activity(7, steps[6], null, null, null));
      sp.setBool('activity', true);
      FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
      );

      // _____________________________________________________________________________
//_____________________________FETCH SLEEP DATA _____________________________________
      final sleepData =
          await fitbitSleepDataManager.fetch(FitbitSleepAPIURL.withUserIDAndDay(
        date: DateTime.now(),
        userID: sp.getString('userid'),
      )) as List<FitbitSleepData>;

      if (sleepData.length > 0) {
        DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
        DateTime? startTime = sleepData[0].entryDateTime;
        int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
      } else {
        database.updateSleep(Sleep(1, 0));
        sp.setBool('sleep', true);
      }
      sp.setBool('game', true);
    }
  }
}

// _____________ class that draw the wave on appbar  ___________________
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom
    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class AnimationWidget extends StatefulWidget {
  final Widget child;

  const AnimationWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

// Class that make the animation of superhappy status
// "coridandoli" effect
class _AnimationWidgetState extends State<AnimationWidget> {
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: const Duration(seconds: 2));
    controller.play(); // start the animation
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (controller.state == ConfettiControllerState.playing) {
          controller.play();
        } else {
          controller.stop();
        }
      },
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: controller,
                colors: const [
                  Colors.greenAccent,
                  Color.fromARGB(255, 168, 197, 247),
                  Color.fromARGB(255, 204, 61, 128),
                ],
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
                emissionFrequency: 0,
                numberOfParticles: 200,
              )),
          widget.child,
        ],
      ),
    );
  }
}
