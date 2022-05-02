import 'package:flutter/material.dart';
import 'package:project/pages/classes/UserPreferences.dart';
import 'package:project/pages/classes/profile_widget.dart';
import 'package:project/pages/editProfilePage.dart';
import '../models/appbar_widget.dart';
import 'classes/user.dart';

class ProfilePage extends StatefulWidget {
  static const route = ' /home/profile';
  static const routename = 'ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Userpreferences.getUser();

    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: buildAppBar(context),
        body: ListView(physics: BouncingScrollPhysics(), children: [
          ProfileWidget(
            // backgroundPath: user.backgroundPath,
            imagePath: user.imagePath,
            onClicked: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditprofilePage()),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          const SizedBox(
            height: 4,
          ),
          Text(user.email, style: TextStyle(color: Colors.grey, fontSize: 18)),
        ],
      );
  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About me :',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(
              height: 10,
            ),
            Text(user.about, style: TextStyle(fontSize: 16, height: 1.4)),
          ],
        ),
      );
}
