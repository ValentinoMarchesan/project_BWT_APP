import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/CustomCard.dart';
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
//______________________________________________________________________________
//_______________ CONTAINER HOMEPAGE ___________________________________________
//______________________________________________________________________________
            Container(
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
//_____________________ HEART RATE CARD ________________________________________
                  CardHR(),
//__________________________ FINE HEART RATE CARD _____________________________
                  SizedBox(
                    height: 5,
                  ),
// _______________________ SLEEP CARD _________________________________________
                  CardSM(),
//________________________ FINE SLEEP CARD ____________________________________
                  SizedBox(
                    height: 5,
                  ),
// _____________________ STEP CARD _____________________________________________
                  CardSteep(),
//___________________________ FINE STEP CARD ___________________________________
                  SizedBox(
                    height: 5,
                  ),
//_________________________ ACTIVITY CARD ______________________________________
                  CardActivity(),
//_________________________ FINE ACTIVITY CARD _________________________________

                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
//______________________________________________________________________________
//_________________  FINE HOMEPAGE    __________________________________________
//_______________ CONTAINER TRAININGPAGE _______________________________________
//______________________________________________________________________________
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
//______________________________________________________________________________
//_________________FINE TRAININGPAGE  __________________________________________
//_______________ CONTAINER GAMEPAGE ___________________________________________
//______________________________________________________________________________
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
//______________________________________________________________________________
//________________    FINE GAMEPAGE    _________________________________________
//_______________ CONTAINER SETTING PAGE _______________________________________
//______________________________________________________________________________
            Container(
              alignment: Alignment.center,
              child: SafeArea(child: ProfilePage()

                  /*
                 ListView(
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
              */
                  ),
            ),
          ],
        ),
//______________________________________________________________________________
//______________________ FINE SETTING PAGE _____________________________________
//______________________________________________________________________________
//__________________________ BOTTOM BAR ________________________________________
//______________________________________________________________________________

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
                filledIcon: Icons.account_box_rounded,
                outlinedIcon: Icons.account_box_rounded,
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
}
