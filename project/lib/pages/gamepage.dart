import 'package:flutter/material.dart';

import 'package:progress_indicator/progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This is the stateless widget that the main application instantiates.
class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  static const route = '/home/game';
  static const routename = 'GAMEPAGE';

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
            Container(
              width: 300,
              child: BarProgress(
                percentage: 80,
                backColor: Color.fromARGB(255, 235, 243, 166),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 243, 240, 33),
                  Color.fromARGB(255, 135, 247, 8)
                ]),
                showPercentage: true,
                textStyle: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontFamily: 'AudioWide'),
                stroke: 40,
                round: true,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                  color: Colors.white,
                  width: 300,
                  height: maxheight,
                  child: Stack(
                    children: [
                      /*
                      CustomPaint(
                          foregroundPainter: LinePainter(),
                          child: Image.network(
                            "https://cdn.pixabay.com/photo/2019/12/14/07/21/mountain-4694346_960_720.png",
                          )),*/
                      Image.network(
                        "https://cdn.pixabay.com/photo/2019/12/14/07/21/mountain-4694346_960_720.png",
                      ),
                      Container(
                        color: Colors.red,
                        height: maxheight * 0.8,
                      ),
                    ],
                  )),
            ),
          ],
        ));
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

// ____________ CLASSE CHE DISEGNA LINEE SOPRA LA FIGURA ___________________
class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 40
      ..color = Colors.red;

    // faccio una linea
    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 50),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 50),
        // richiamo del paint
        paint);
    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 7),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 7),
        // richiamo del paint
        paint);

    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 4),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 4),
        // richiamo del paint
        paint);

    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 2.7),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 2.7),
        // richiamo del paint
        paint);

    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 2),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 2),
        // richiamo del paint
        paint);
    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 1.7),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 1.7),
        // richiamo del paint
        paint);

    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 1.4),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 1.4),
        // richiamo del paint
        paint);

    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 1.2),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 1.2),
        // richiamo del paint
        paint);
    canvas.drawLine(
        // distanza del punto iniziale dal bordo sinistro + altezza
        // startpoint
        Offset(size.width * 0 / 6, size.height * 1 / 1.05),
        // distanza dal bordo destro della schermata + altezza
        // endpoint
        Offset(size.width * 6 / 6, size.height * 1 / 1.05),
        // richiamo del paint
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
/*
Image.network(
                "https://cdn.pixabay.com/photo/2019/12/14/07/21/mountain-4694346_960_720.png",
                fit: BoxFit.cover,
              ),
              */
