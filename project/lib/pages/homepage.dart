import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/models/CustomCard.dart';
import 'package:project/pages/profilePage.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'diarypage.dart';

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
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)
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
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
//_____________________ HEART RATE CARD ________________________________________
                  const CardHR(),
//__________________________ FINE HEART RATE CARD _____________________________
                  const SizedBox(
                    height: 5,
                  ),
// _______________________ SLEEP CARD _________________________________________
                  const CardSM(),
//________________________ FINE SLEEP CARD ____________________________________
                  const SizedBox(
                    height: 5,
                  ),
// _____________________ STEP CARD _____________________________________________
                  const CardSteep(),
//___________________________ FINE STEP CARD ___________________________________
                  const SizedBox(
                    height: 5,
                  ),
//_________________________ ACTIVITY CARD ______________________________________
                  const Cardbmi(),
//_________________________ FINE ACTIVITY CARD _________________________________

                  const SizedBox(
                    height: 5,
                  ),
                  //_______________________________________________________________________
                  //________________________________________________________________________
                  /*
                  ElevatedButton(
                    onPressed: () async {
                      // Authorize the app
                      String? userId = await FitbitConnector.authorize(
                          context: context,
                          clientID: Strings.fitbitClientID,
                          clientSecret: Strings.fitbitClientSecret,
                          redirectUri: Strings.fitbitRedirectUri,
                          callbackUrlScheme: Strings.fitbitCallbackScheme);
                    },
                    child: Text('Tap to authorize'),
                  ),
                  */

                  //_______________________________________________________________________
                  //________________________________________________________________________
                ],
              ),
            ),
//______________________________________________________________________________
//_________________  FINE HOMEPAGE    __________________________________________
//_______________ CONTAINER ACTIVITY _______________________________________
//______________________________________________________________________________
            Container(
              alignment: Alignment.center,
              child: const Center(
                child: DiaryPage(),
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
                      child: const Text('GAMEPAGE'),
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                  filledIcon: Icons.history_edu,
                  outlinedIcon: Icons.history_edu),
              BarItem(
                filledIcon: Icons.gamepad_rounded,
                outlinedIcon: Icons.gamepad_rounded,
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
}
