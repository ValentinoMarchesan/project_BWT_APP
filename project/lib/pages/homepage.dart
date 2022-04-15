import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  Card(
                    clipBehavior: Clip.antiAlias,
                    // forma dei bordi
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    // contenuto
                    child: Column(
                      children: [
                        Container(
                          //colore interno
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              //sfumatura
                              colors: [Colors.orangeAccent, Colors.deepOrange],
                              // direzione della sfumatura
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.heart_broken),
                              SizedBox(
                                height: 1,
                                width: 10,
                              ),
                              Text('HEART RATE'),
                              SizedBox(
                                width: 210,
                              ),
                              Icon(Icons.view_column),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                // parte per posizionare immagine
                                Ink.image(
                                  image: NetworkImage(
                                      'https://image.shutterstock.com/image-illustration/cardio-exercise-increases-hearts-health-600w-173381630.jpg'),
                                  // rendere la card schiacciabile
                                  width: 200,
                                  height: 100,
                                  child: InkWell(
                                      onTap: () => _toHeartPage(context)),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Container(
                              //colore interno
                              height: 100,
                              width: 184.7,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 200, 145),
                                /*gradient: LinearGradient(
                    //sfumatura
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    // direzione della sfumatura
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  */
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    'Inserire Testo',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
//__________________________ FINE HEART RATE CARD _____________________________
                  SizedBox(
                    height: 5,
                  ),
// _______________________ SLEEP CARD _________________________________________
                  Card(
                    clipBehavior: Clip.antiAlias,
                    // forma dei bordi
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    // contenuto
                    child: Column(
                      children: [
                        Container(
                          //colore interno
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              //sfumatura
                              colors: [Colors.orangeAccent, Colors.deepOrange],
                              // direzione della sfumatura
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.dark_mode),
                              SizedBox(
                                height: 1,
                                width: 10,
                              ),
                              Text('SLEEP MONITORING'),
                              SizedBox(
                                width: 165,
                              ),
                              Icon(Icons.view_column),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                // parte per posizionare immagine
                                Ink.image(
                                  image: NetworkImage(
                                      'https://image.shutterstock.com/image-vector/sleep-cycle-labeled-night-stages-600w-1945387777.jpg'),
                                  // rendere la card schiacciabile
                                  width: 200,
                                  height: 100,
                                  child: InkWell(
                                    onTap: () => _toSleepPage(context),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Container(
                              //colore interno
                              height: 100,
                              width: 184.7,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 200, 145),
                                /*gradient: LinearGradient(
                    //sfumatura
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    // direzione della sfumatura
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  */
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    'Inserire Testo',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
//________________________ FINE SLEEP CARD ____________________________________
                  SizedBox(
                    height: 5,
                  ),
// _____________________ STEP CARD _____________________________________________
                  Card(
                    clipBehavior: Clip.antiAlias,
                    // forma dei bordi
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    // contenuto
                    child: Column(
                      children: [
                        Container(
                          //colore interno
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              //sfumatura
                              colors: [Colors.orangeAccent, Colors.deepOrange],
                              // direzione della sfumatura
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.run_circle),
                              SizedBox(
                                height: 1,
                                width: 10,
                              ),
                              Text('STEPS MONITORING'),
                              SizedBox(
                                width: 160,
                              ),
                              Icon(Icons.view_column),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                // parte per posizionare immagine
                                Ink.image(
                                  image: NetworkImage(
                                      'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                                  // rendere la card schiacciabile
                                  width: 200,
                                  height: 100,
                                  child: InkWell(
                                    onTap: () => _toStepPage(context),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Container(
                              //colore interno
                              height: 100,
                              width: 184.7,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 200, 145),
                                /*gradient: LinearGradient(
                    //sfumatura
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    // direzione della sfumatura
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  */
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    'Inserire Testo',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
//___________________________ FINE STEP CARD ___________________________________
                  SizedBox(
                    height: 5,
                  ),
//_________________________ ACTIVITY CARD ______________________________________
                  Card(
                    clipBehavior: Clip.antiAlias,
                    // forma dei bordi
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    // contenuto
                    child: Column(
                      children: [
                        Container(
                          //colore interno
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              //sfumatura
                              colors: [Colors.orangeAccent, Colors.deepOrange],
                              // direzione della sfumatura
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.fitness_center),
                              SizedBox(
                                height: 1,
                                width: 10,
                              ),
                              Text('ACTIVITY'),
                              SizedBox(
                                width: 230,
                              ),
                              Icon(Icons.view_column),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Stack(
                              children: [
                                // parte per posizionare immagine
                                Ink.image(
                                  image: NetworkImage(
                                      'https://media.istockphoto.com/photos/sports-equipment-on-green-grass-top-view-picture-id905105146'),
                                  // rendere la card schiacciabile
                                  width: 200,
                                  height: 100,
                                  child: InkWell(
                                    onTap: () => _toActivityPage(context),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Container(
                              //colore interno
                              height: 100,
                              width: 184.7,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 200, 145),
                                /*gradient: LinearGradient(
                                //sfumatura
                                colors: [Colors.orangeAccent, Colors.deepOrange],
                                // direzione della sfumatura
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                ),
                              */
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    'Inserire Testo',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
