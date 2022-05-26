import 'dart:io'
    as io; //this is to use in a correct way the class File of dart:io

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/classes/UserPreferences.dart';
import 'package:project/classes/profile_widget.dart';
import 'package:project/classes/user.dart';
import 'package:project/models/Texfield_widget.dart';
import 'package:project/models/appbar_widget.dart';

import 'package:path/path.dart'; //to use basename in line 45

class EditprofilePage extends StatefulWidget {
  static const route = ' home/profile/edit';
  static const routename = 'EditProfilePage';

  const EditprofilePage({Key? key}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditprofilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = Userpreferences
        .getUser(); //we don't use a constant user but one gives by getuser for this we can modify the page
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
          // padding: EdgeInsets.symmetric(horizontal: 2),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              // backgroundPath: user.backgroundPath,
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {
                final image = await ImagePicker().getImage(
                    source: ImageSource
                        .gallery); //permit to take an image from the phone gallery
                if (image == null) return;
                final directory =
                    await getApplicationDocumentsDirectory(); //save on directory if image is not null
                final name = basename(image.path); //obtain the name of the file
                final imageFile = io.File('${directory.path}/$name');
                //directory is were we want store our file and the name of the image
                final newImage = await io.File(image.path).copy(imageFile.path);
                setState(() => user = user.copy(imagePath: newImage.path));
                // final background =
                //     await ImagePicker().getImage(source: ImageSource.gallery);
                // if (background == null) return;
                //    final directory2 = await getApplicationDocumentsDirectory();
                //  final backname = basename(background.path);
                //   final backFile = io.File('${directory2.path}/$backname');

                // final newback =
                //       await io.File(background.path).copy(backFile.path);
                //   setState(() => user = user.copy(backgroundPath: newback.path));
                //save the new imagepath
              },
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
                      onChanged: (name) => user = user.copy(name: name)),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                      label: 'Email',
                      text: user.email,
                      onChanged: (email) => user = user.copy(email: email)),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                      label: 'About',
                      text: user.about,
                      maxLines: 5,
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
