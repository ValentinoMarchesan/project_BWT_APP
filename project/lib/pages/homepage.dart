import 'package:flutter/material.dart';
import 'package:project/pages/goalPage.dart';
import 'package:project/models/homecard.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Homepage';

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
          title: Text(HomePage.routename),
          backgroundColor: Color.fromARGB(255, 195, 64, 255)),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28,
                right: 18,
                top: 36,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("VMR APP",
                      style: TextStyle(
                          color: Color.fromARGB(255, 12, 0, 0),
                          fontSize: 34,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "GENERAL",
                    style: TextStyle(
                        color: Color.fromARGB(255, 1, 4, 15),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 74,
                  stepSize: 10,
                  selectedColor: Colors.greenAccent,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 15,
                  roundedCap: (_, __) => true,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "FUNCTIONALITY",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 5, 20),
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 19,
                    mainAxisExtent: 125,
                    mainAxisSpacing: 19),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HomeCard(
                    onTap: () {},
                    title: "Sleep Monitoring",
                    gradientStartColor: Color(0xff13DEA0),
                    gradientEndColor: Color(0xff06B782),
                  ),
                  HomeCard(
                      onTap: () {},
                      title: "Heart Rate",
                      gradientStartColor: Color(0xffFC67A7),
                      gradientEndColor: Color(0xffF6815B),
                      icon: Icon(Icons.abc)),
                  HomeCard(
                    onTap: () {},
                    title: "Steps",
                    gradientStartColor: Color(0xffFFD541),
                    gradientEndColor: Color(0xffF0B31A),
                  ),
                  HomeCard(
                      onTap: () {}, title: "Activity", icon: Icon(Icons.abc)),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('layout'),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('To ProfilePage'),
              onTap: () => _toProfilePage(context),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('To GoalPage'),
              onTap: () => _toGoalPage(context),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
          ],
        ),
      ),
    );
  }

  void _toProfilePage(BuildContext context) {
    //Pop the drawer first
    Navigator.pop(context);
    //Then push the ProfilePage
    Navigator.pushNamed(context, ProfilePage.route);
  } //_toProfilePage

  void _toGoalPage(BuildContext context) {
    //Pop the drawer first
    Navigator.pop(context);
    //Then push the CalendarPage
    Navigator.pushNamed(context, GoalPage.route);
  } //_toCalendarPage

  void _toLoginPage(BuildContext context) {
    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.pop(context);
    Navigator.pushNamed(context, LoginPage.route);
  }
}
