import 'package:flutter/material.dart';
import 'package:project/classes/UserPreferences.dart';
import 'package:project/pages/annotationpage.dart';
import 'package:project/pages/authpage.dart';
import 'package:project/pages/bmipage.dart';
import 'package:project/pages/diarypage.dart';
import 'package:project/pages/editProfilePage.dart';
import 'package:project/pages/heartpage.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/infopage.dart';
import 'package:project/pages/loginPage.dart';
import 'package:project/pages/profilePage.dart';
import 'package:project/pages/sleeppage.dart';

import 'package:project/pages/steppage/steppage.dart';
import 'package:project/repositories/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

Future main() async {
  //this two lines need to initialized the UserPreferences
  WidgetsFlutterBinding.ensureInitialized();
  await Userpreferences.init();

  //This opens the database.
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database2.db').build();
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = DatabaseRepository(database: database);

  // Run the app and provide to the whole widget tree the instance of the DatabaseRepository.That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
} // main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.route,

      // VECCHIO CODICE, PIU' SEMPLICE DA LEGGERE:
      // routes: {
      // LoginPage.route: (context) => LoginPage(),
      // HomePage.route: (context) => HomePage(),
      // ProfilePage.route: (context) => ProfilePage(),
      // EditProfilePage.route: (context) => EditProfilePage(),
      // ActivityPage.route: (context) => ActivityPage(),
      // StepPage.route: (context) => StepPage(),
      // HeartPage.route: (context) => HeartPage(),
      // SleepPage.route: (context) => SleepPage(),
      // WalkPage.route: (context) => WalkPage(walkDB: walkDB, walkIndex: )},),

      // CODICE IMPLEMENTATO DAL PROF. NEL LAB 7:
      // another way to manage Navigation. This approach can be handy when you need to pass data to a route directly to its constructor and you want to continue to use pushNamed().

      onGenerateRoute: (settings) {
        if (settings.name == LoginPage.route) {
          return MaterialPageRoute(builder: (context) {
            return LoginPage();
          });
        } else if (settings.name == HomePage.route) {
          return MaterialPageRoute(builder: (context) {
            return HomePage();
          });
        } else if (settings.name == DiaryPage.route) {
          return MaterialPageRoute(builder: (context) {
            return DiaryPage();
          });
        } else if (settings.name == BmiPage.route) {
          return MaterialPageRoute(builder: (context) {
            return BmiPage();
          });
        } else if (settings.name == EditprofilePage.route) {
          return MaterialPageRoute(builder: (context) {
            return EditprofilePage();
          });
        } else if (settings.name == HeartPage.route) {
          return MaterialPageRoute(builder: (context) {
            return HeartPage();
          });
        } else if (settings.name == ProfilePage.route) {
          return MaterialPageRoute(builder: (context) {
            return ProfilePage();
          });
        } else if (settings.name == InfoPage.route) {
          return MaterialPageRoute(builder: (context) {
            return InfoPage();
          });
        } else if (settings.name == SleepPage.route) {
          return MaterialPageRoute(builder: (context) {
            return SleepPage();
          });
        } else if (settings.name == StepPage.route) {
          return MaterialPageRoute(builder: (context) {
            return StepPage();
          });
        } else if (settings.name == AuthPage.route) {
          return MaterialPageRoute(builder: (context) {
            return AuthPage();
          });
        } else if (settings.name == AnnotationPage.route) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(builder: (context) {
            return AnnotationPage(annotation: args['annotation']); //!!
          });
        } else {
          return null;
        } //if-else
      }, //onGenerateRoute
    );
  } //build
} //MyApp
