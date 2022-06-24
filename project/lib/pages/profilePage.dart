import 'package:flutter/material.dart';
import 'package:project/classes/UserPreferences.dart';
import 'package:project/classes/profile_widget.dart';
import 'package:project/classes/user.dart';

import 'package:project/pages/editProfilePage.dart';
import '../models/appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  static const route = ' /home/profile';
  static const routename = 'ProfilePage';

  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Userpreferences.getUser();

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 186, 109),
        appBar: buildAppBar(context),
        body: ListView(physics: const BouncingScrollPhysics(), children: [
          ProfileWidget(
            // backgroundPath: user.backgroundPath,
            imagePath: user.imagePath,
            onClicked: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const EditprofilePage()),
              );
              setState(() {}); //await the re build of our UI
            },
          ),
          const SizedBox(
            height: 20,
          ),
          buildName(user),
          const SizedBox(
            height: 48,
          ),
          buildAbout(user),
        ]));
  }

  Widget buildName(User user) => Column(
        children: [
          Text(user.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white,
                  fontFamily: 'Goldman')),
          const SizedBox(
            height: 4,
          ),
          Text(user.email,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 18)),
        ],
      );
  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About me :',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'Goldman')),
            const SizedBox(
              height: 10,
            ),
            Text(user.about,
                style: const TextStyle(
                    fontSize: 19, height: 1.4, color: Colors.white)),
          ],
        ),
      );
}
