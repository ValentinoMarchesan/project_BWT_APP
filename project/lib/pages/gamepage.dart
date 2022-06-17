import 'package:confetti/confetti.dart';
import 'package:expandable/expandable.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:progress_indicator/progress_indicator.dart';
import 'package:project/database/entities/activity.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/databaseRepository.dart';
import '../utils/strings.dart';

/// This is the stateless widget that the main application instantiates.
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
    double maxheight = 300;
    return Scaffold(
      appBar: AppBar(
        title: const Text(GamePage.routename,
            style: TextStyle(
              fontFamily: 'AudioWide',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000),
            )),
        centerTitle: true,
        backgroundColor: Colors.orange,
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
                      color: Colors.deepOrangeAccent,
                      height: 100,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    color: Colors.orange,
                    height: 80,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          Consumer<DatabaseRepository>(builder: (context, dbr, child) {
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
                              _aggiungoAC(dbr);

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
                                        _aggiungoSL(dbr);

                                        final data =
                                            snapshot.data as List<Sleep>;

                                        final datasleep =
                                            dbr.findminutsleep(data);

                                        if (datasleep == null) {
                                          return CircularProgressIndicator();
                                        } else if (datasleep > 7) {
                                          return FutureBuilder(
                                              initialData: null,
                                              future: dbr.findAllAnnotations(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final data = snapshot.data
                                                      as List<Annotation>;

                                                  if (data.length == 0) {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                          child: Image.asset(
                                                              'assets/MeCo/happy.png'),
                                                          color: Colors.black,
                                                          width: 380,
                                                          height: 340,
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 10, 70, 0),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .orange),
                                                          height: 140,
                                                          width: 300,
                                                          child:
                                                              ExpandablePanel(
                                                            header: const Text(
                                                              'TITLE',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'AudioWide',
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            collapsed:
                                                                const Text(
                                                              '  VUOI SAPERNE DI PIU\'?'
                                                              '\n'
                                                              'SCOPRI LA CARD',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontFamily:
                                                                    'AudioWide',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            expanded:
                                                                const Text(
                                                              'BLABLABLA'
                                                              '   BLABLABLA'
                                                              '   BLABLABLA',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      'AudioWide',
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else if (data[data.length -
                                                                  1]
                                                              .ml >
                                                          1500 &&
                                                      data[data.length - 1]
                                                              .min >
                                                          10) {
                                                    return Column(
                                                      children: [
                                                        Image.asset(
                                                            'assets/MeCo/superhappy.png'),
                                                      ],
                                                    );
                                                  } else {
                                                    return Column(
                                                      children: [
                                                        Image.asset(
                                                            'assets/MeCo/happy.png'),
                                                      ],
                                                    );
                                                  }
                                                } else {
                                                  return CircularProgressIndicator();
                                                }
                                              });
                                        } else {
                                          return Image.asset(
                                              'assets/MeCo/sleepy.png');
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
                                        _aggiungoSL(dbr);

                                        final data =
                                            snapshot.data as List<Sleep>;

                                        final datasleep =
                                            dbr.findminutsleep(data);

                                        if (datasleep == null) {
                                          return CircularProgressIndicator();
                                        } else if (datasleep > 7) {
                                          return Image.asset(
                                              'assets/MeCo/meh.png');
                                        } else {
                                          return Image.asset(
                                              'assets/MeCo/sad.png');
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
                      return FutureBuilder(
                          initialData: null,
                          future: SharedPreferences.getInstance(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final sp = snapshot.data as SharedPreferences;
                              if (sp.getInt('status') == 1) {
                                return Image.asset('assets/MeCo/happy.png');
                              } else if (sp.getInt('status') == 2) {
                                return Image.asset('assets/MeCo/sleepy.png');
                              } else if (sp.getInt('status') == 3) {
                                return Image.asset('assets/MeCo/meh.png');
                              } else if (sp.getInt('status') == 4) {
                                return Image.asset('assets/MeCo/sad.png');
                              } else if (sp.getInt('status') == 5) {
                                return Image.asset(
                                    'assets/MeCo/superhappy.png');
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
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment(0.95, 0.92),
          ringColor: Colors.white.withAlpha(25),
          ringDiameter: 440.0,
          ringWidth: 180.0,
          fabSize: 50.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          // Also can use specific color based on wether
          // the menu is open or not:
          // fabOpenColor: Colors.white
          // fabCloseColor: Colors.white
          // These properties take precedence over fabColor
          fabColor: Colors.white,
          fabOpenIcon: Icon(Icons.info_outline, color: Colors.orange),
          fabCloseIcon: Icon(Icons.close, color: Colors.orange),
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
              child:
                  Icon(FontAwesomeIcons.faceGrinSquint, color: Colors.orange),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 2);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceFrownOpen, color: Colors.orange),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 3);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceSmile, color: Colors.orange),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 4);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceSadCry, color: Colors.orange),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('status', 5);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child:
                  Icon(FontAwesomeIcons.faceLaughSquint, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _aggiungoAC(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool('activity') == false && sp.getBool('confirm') == true) {
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
    }
  }

  Future<void> _aggiungoSL(DatabaseRepository database) async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool('sleep') == false && sp.getBool('confirm') == true) {
      FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
      );

      //Fetch data
      final sleepData =
          await fitbitSleepDataManager.fetch(FitbitSleepAPIURL.withUserIDAndDay(
        date: DateTime.now(),
        userID: sp.getString('userid'),
      )) as List<FitbitSleepData>;

      if (sleepData.length > 0) {
        DateTime? endTime = sleepData[sleepData.length - 1].entryDateTime;
        DateTime? startTime = sleepData[0].entryDateTime;
        int sleepDurHourse = endTime!.difference(startTime!).inMinutes ~/ 60;
        database.updateSleep(Sleep(1, sleepDurHourse));
        sp.setBool('sleep', true);
      } else {
        database.updateSleep(Sleep(1, 0));
        sp.setBool('sleep', true);
      }
      //database.updateSleep(Sleep(1, sleepDurHourse));

    }
  }

// _____________ tentativo di algoritmo gampage _____________________
  game() async {
    int count = 0;
    final sp = await SharedPreferences.getInstance();
    var percentage = sp.getDouble('lastdaystep');
    while (percentage! > 5000) {
      percentage = percentage - 5000;
      count = count + 1;
    }
    double result = (percentage * 100) / 5000;
    return result;
  }
}

// _____________ classe che disegna l'onda sull app bar ___________________
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

//
class AnimationWidget extends StatefulWidget {
  final Widget child;

  const AnimationWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

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
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.purple,
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
