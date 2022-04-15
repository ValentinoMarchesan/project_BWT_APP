import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/customcard.dart';
import 'package:project/models/homecard.dart';
import 'package:project/pages/activitypage.dart';
import 'package:project/pages/heartpage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/pages/sleeppage.dart';
import 'package:project/pages/steppage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/home/';
  static const routename = 'Homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)
    print('${HomePage.routename} built');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 254, 183, 77),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
//_______________ CONTAINER HOMEPAGE __________________________________
            Container(
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CardHR(),
                  SizedBox(
                    height: 5,
                  ),
                  CardSleepM(),
                  SizedBox(
                    height: 5,
                  ),
                  Cardsteps(),
                  SizedBox(
                    height: 5,
                  ),
                  CardActivity(),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
//_________________  FINE HOMEPAGE    _____________________________________
//_______________ CONTAINER TRAININGPAGE __________________________________
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text('GAMEPAGE'),
                      ),
                      Icon(
                        Icons.fitness_center_sharp,
                        size: 56,
                        color: Colors.red[400],
                      ),
                    ]),
              ),
            ),
//_________________FINE TRAININGPAGE  _____________________________________
//_______________ CONTAINER GAMEPAGE __________________________________
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text('GAMEPAGE'),
                    ),
                    Icon(
                      Icons.gamepad_sharp,
                      size: 56,
                      color: Colors.red[400],
                    ),
                  ],
                ),
              ),
            ),
//_________________FINE GAMEPAGE       _____________________________________
//_______________ CONTAINER SETTING PAGE __________________________________
            Container(
              alignment: Alignment.center,
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text('To ProfilePage'),
                      onTap: () => _toProfilePage(context),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () => _toLoginPage(context),
                    ),
                  ],
                ),
              ),
            ),
//______________________ FINE SETTING PAGE __________________________________
          ],
        ),
//___________________________________________________________________________
//__________________ BOTTOM BAR _____________________________________________
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: WaterDropNavBar(
            backgroundColor: navigationBarColor,
            waterDropColor: Colors.orangeAccent,
            onItemSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
              pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuad);
            },
            selectedIndex: selectedIndex,
            barItems: <BarItem>[
              BarItem(
                filledIcon: Icons.home_rounded,
                outlinedIcon: Icons.home_rounded,
              ),
              BarItem(
                  filledIcon: Icons.fitness_center_rounded,
                  outlinedIcon: Icons.fitness_center_rounded),
              BarItem(
                filledIcon: Icons.gamepad_rounded,
                outlinedIcon: Icons.gamepad_rounded,
              ),
              BarItem(
                filledIcon: Icons.settings_rounded,
                outlinedIcon: Icons.settings_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toProfilePage(BuildContext context) {
    //Pop the drawer first
    //Navigator.pop(context);
    //Then push the ProfilePage
    Navigator.pushNamed(context, ProfilePage.route);
  } //_toProfilePage

  void _toLoginPage(BuildContext context) {
    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    //Navigator.pop(context);
    Navigator.pushNamed(context, LoginPage.route);
  }

  void _toActivityPage(BuildContext context) {
    Navigator.pushNamed(context, ActivityPage.route);
  }

  void _toStepPage(BuildContext context) {
    Navigator.pushNamed(context, StepPage.route);
  } //_toStepPage

  void _toHeartPage(BuildContext context) {
    Navigator.pushNamed(context, HeartPage.route);
  } //_toStepPage

  void _toSleepPage(BuildContext context) {
    Navigator.pushNamed(context, SleepPage.route);
  } //_toStepPage
}
