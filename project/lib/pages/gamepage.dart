import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  static const route = '/home/game';
  static const routename = '_GAMEPAGE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(GamePage.routename),
          centerTitle: true,
          backgroundColor: Colors.orange,
          shadowColor: Colors.orangeAccent,
        ),
        body: Center(
          child: Container(
              color: Colors.white,
              width: 300,
              height: 300,
              child: CustomPaint(
                  foregroundPainter: LinePainter(),
                  child: Image.network(
                    "https://cdn.pixabay.com/photo/2019/12/14/07/21/mountain-4694346_960_720.png",
                  ))),
        ));
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 40
      ..color = Colors.red;

    // faccio una linea
    /*canvas.drawLine(
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
        paint);*/
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
