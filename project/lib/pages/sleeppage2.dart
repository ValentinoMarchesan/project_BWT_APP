import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepPage2 extends StatefulWidget {
  SleepPage2({Key? key}) : super(key: key);
  static const route = '/home/sleep';
  static const routename = 'SLEEPPAGE';

  @override
  State<SleepPage2> createState() => _SleepPage2State();
}

class _SleepPage2State extends State<SleepPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(SleepPage2.routename), backgroundColor: Colors.red),
      body: FutureBuilder(
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
