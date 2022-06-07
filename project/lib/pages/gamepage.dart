import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:progress_indicator/progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This is the stateless widget that the main application instantiates.
class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  static const route = '/home/game';
  static const routename = 'GAMEPAGE';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
          SizedBox(
            height: 50,
          ),
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final sp = snapshot.data as SharedPreferences;
                /*if (sp.getInt('sleepduration')! == null) {
              return CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              );
            }*/
                if (sp.getInt('sleepduration') == null) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    strokeWidth: 30,
                    semanticsValue: 'Loading...',
                    semanticsLabel: 'Loading...',
                  ));
                } else if (sp.getInt('sleepduration')! >= 8) {
                  return AnimationWidget(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            FontAwesomeIcons.faceGrinBeam,
                            size: 200,
                            color: Colors.red,
                          ),
                          Text('CONGRATULAZIONI',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                  fontFamily: 'Audiowide',
                                  fontWeight: FontWeight.bold)),
                          Text('Hai dormito a sufficenza!!',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontFamily: 'Audiowide',
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesomeIcons.faceAngry,
                          size: 200,
                          color: Colors.red,
                        ),
                        Text('NON HAI DORMITO A SUFFICENZA!!',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.red,
                                fontFamily: 'Audiowide',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text(
                          'Per uno stile di vita sano e per ottenere le massime performance durante il workout è necessario dormire almeno 8 ore al giorno',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontFamily: 'Audiowide',
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'sleep',
            focusColor: Colors.red,
            splashColor: Colors.red,
            backgroundColor: Colors.red,
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.setInt('sleepduration', 9);
              setState(() {});
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'Removesleep',
            focusColor: Colors.red,
            splashColor: Colors.red,
            backgroundColor: Colors.red,
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.remove('sleepduration');
              setState(() {});
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'wrongsleep',
            focusColor: Colors.red,
            splashColor: Colors.red,
            backgroundColor: Colors.red,
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              sp.setInt('sleepduration', 6);
              setState(() {});
            },
            child: Icon(FontAwesomeIcons.faceAngry),
          ),
        ],
      ),
    );
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
