import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
decoration: const BoxDecoration(
                gradient: LinearGradient(
                  //sfumatura
                  colors: [Colors.orangeAccent, Colors.deepOrange],
                  // direzione della sfumatura
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
*/
const activateColor = Color.fromARGB(255, 244, 190, 110);
const inactiveColor = Color(0xFFffffff);

class BmiPage extends StatefulWidget {
  static const route = '/home/Bmi';
  static const routename = 'BMI CALCULATOR';

  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  Color maleBoxColor = activateColor;
  Color femaleBoxColor = inactiveColor;
  int height = 180;
  int weight = 70;
  int age = 25;
  String result = '';
  String resultDetail = '';
  double bmi = 0;

  String calculateBmi(int weight, int height) {
    bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  String getInterpretation(double bmi) {
    if (bmi >= 25) {
      return 'You have a higher than body weight. Try to exercise more';
    } else if (bmi > 18.5) {
      return 'You have a normal body weight. Goog job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more!';
    }
  }

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (maleBoxColor == inactiveColor) {
        maleBoxColor = activateColor;
        femaleBoxColor = inactiveColor;
      } else {
        maleBoxColor = inactiveColor;
        femaleBoxColor = activateColor;
      }
    } else {
      if (femaleBoxColor == inactiveColor) {
        femaleBoxColor = activateColor;
        maleBoxColor = inactiveColor;
      } else {
        femaleBoxColor = inactiveColor;
        maleBoxColor = activateColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          BmiPage.routename,
          style: TextStyle(fontFamily: 'Audiowide'),
        ),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            //sfumatura
            colors: [
              Color.fromARGB(255, 239, 65, 123),
              Color.fromARGB(255, 244, 190, 110)
            ],
            // direzione della sfumatura
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      setState(() {
                        updateBoxColor(1);
                      });
                    }),
                    child: ContainerBox(
                      boxColor: Color.fromARGB(255, 235, 213, 180),
                      childWidget: const DataContainer(
                        icon: FontAwesomeIcons.mars,
                        title: 'MALE',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      setState(() {
                        updateBoxColor(2);
                      });
                    }),
                    child: ContainerBox(
                      boxColor: Color.fromARGB(255, 235, 213, 180),
                      childWidget: const DataContainer(
                        icon: FontAwesomeIcons.venus,
                        title: 'FEMALE',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ContainerBox(
            boxColor: const Color(0xFFffffff),
            childWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HEIGHT',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Audiowide'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'cm',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Audiowide'),
                    ),
                  ],
                ),
                Slider(
                  value: height.toDouble(),
                  min: 120,
                  max: 220,
                  activeColor: activateColor,
                  inactiveColor: inactiveColor,
                  onChanged: (double newValue) {
                    setState(() {
                      height = newValue.round();
                    });
                  },
                )
              ],
            ),
          )),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ContainerBox(
                    boxColor: const Color(0xFFffffff),
                    childWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'WEIGHT',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Audiowide'),
                        ),
                        Text(
                          weight.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 2.0,
                            ),
                            FloatingActionButton(
                              heroTag: 'btn1',
                              backgroundColor: activateColor,
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            FloatingActionButton(
                              heroTag: 'btn2',
                              backgroundColor: activateColor,
                              child: const Icon(
                                FontAwesomeIcons.minus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (weight > 0) {
                                    weight--;
                                  }
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ContainerBox(
                    boxColor: const Color(0xFFffffff),
                    childWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'AGE',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Audiowide'),
                        ),
                        Text(
                          age.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 2.0,
                            ),
                            FloatingActionButton(
                              heroTag: "btn3",
                              backgroundColor: activateColor,
                              child: const Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            FloatingActionButton(
                              heroTag: "btn4",
                              backgroundColor: activateColor,
                              child: const Icon(
                                FontAwesomeIcons.minus,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (age > 0) {
                                    age--;
                                  }
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  result = calculateBmi(weight, height);
                  resultDetail = getInterpretation(bmi);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          height: 200.0,
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'RESULT',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Audiowide'),
                              ),
                              Text(
                                result.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                resultDetail,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              width: double.infinity,
              height: 70.0,
              color: activateColor,
              margin: const EdgeInsets.only(top: 10.0),
              child: const Center(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Audiowide'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContainerBox extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContainerBox({required this.boxColor, this.childWidget});
  final Color boxColor;
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: childWidget,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: boxColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5.0,
              blurRadius: 7.0,
              offset: const Offset(0, 3),
            ),
          ]),
    );
  }
}

class DataContainer extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DataContainer({required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
        ),
        const SizedBox(height: 15.0),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 20.0, fontFamily: 'Audiowide'),
        )
      ],
    );
  }
}
