import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/Texfield_widget.dart';
import 'package:project/models/appbar_widget.dart';

import 'package:project/pages/classes/UserPreferences.dart';
import 'package:project/pages/classes/profile_widget.dart';

import 'classes/user.dart';

class EditprofilePage extends StatefulWidget {
  static const route = ' home/profile/edit';
  static const routename = 'EditProfilePage';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditprofilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = Userpreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
          // padding: EdgeInsets.symmetric(horizontal: 2),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  TextFieldWidget(
                      label: 'Full Name',
                      text: user.name,
                      // onChanged: (name) {},),

                      onChanged: (name) => user = user.copy(name: name)),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                      label: 'Email',
                      text: user.email,
                      // onChanged: (email) {},),

                      onChanged: (email) => user = user.copy(email: email)),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                      label: 'About',
                      text: user.about,
                      maxLines: 5,
                      // onChanged: (about) {},),

                      onChanged: (about) => user = user.copy(about: about)),
                  const SizedBox(height: 20),
                ])),
            FloatingActionButton.extended(
              icon: Icon(Icons.save),
              label: Text('save'),
              onPressed: () {
                Userpreferences.setUser(user);
                Navigator.of(context).pop();
              },
            )
          ]));
}

//oppure se si mette il button dentro alle colonne viene più piccolo ma magari con del padding si può espandere
