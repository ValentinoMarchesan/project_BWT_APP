import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/CustomCard.dart';
import 'package:project/pages/gamepage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'diarypage.dart';

//class that define the HomePage
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = '/Auth/home/';
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
    print('${HomePage.routename} built');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 254, 183, 77),
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
                children: const <Widget>[
                  SizedBox(
                    height: 35,
                  ),
//_____________________ HEART RATE CARD ________________________________________
                  CardHR(),
//__________________________ END HEART RATE CARD _____________________________
                  SizedBox(
                    height: 10,
                  ),
// _______________________ SLEEP CARD _________________________________________
                  CardSM(),
//________________________ END SLEEP CARD ____________________________________
                  SizedBox(
                    height: 10,
                  ),
// _____________________ STEP CARD _____________________________________________
                  CardSteep(),
//___________________________ END STEP CARD ___________________________________
                  SizedBox(
                    height: 10,
                  ),
//_________________________ ACTIVITY CARD ______________________________________
                  Cardbmi(),
//_________________________ END ACTIVITY CARD _________________________________

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
//______________________________________________________________________________
//_________________  END HOMEPAGE    __________________________________________

//_______________ CONTAINER DIARYPAGE _______________________________________
//______________________________________________________________________________
            Container(
              alignment: Alignment.center,
              child: const Center(
                child: DiaryPage(),
              ),
            ),
//______________________________________________________________________________
//_________________END ACTIVITYPAGE  __________________________________________
//_______________ CONTAINER GAMEPAGE ___________________________________________
//______________________________________________________________________________
            Container(
              alignment: Alignment.center,
              child: GamePage(),
            ),
//______________________________________________________________________________
//________________    FINE GAMEPAGE    _________________________________________
//_______________ CONTAINER SETTING PAGE _______________________________________
//______________________________________________________________________________
            Container(
              alignment: Alignment.center,
              child: SafeArea(child: ProfilePage()),
            ),
          ],
        ),
//______________________________________________________________________________
//______________________ END SETTING PAGE _____________________________________
//______________________________________________________________________________
//__________________________ BOTTOM BAR ________________________________________
//______________________________________________________________________________

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: WaterDropNavBar(
            backgroundColor: navigationBarColor,
            waterDropColor: const Color.fromARGB(255, 254, 183, 77),
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
                  filledIcon: Icons.history_edu,
                  outlinedIcon: Icons.history_edu),
              BarItem(
                filledIcon: Icons.gamepad,
                outlinedIcon: Icons.gamepad,
              ),
              BarItem(
                  filledIcon: Icons.account_circle,
                  outlinedIcon: Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }
}//HomePage
