import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/editProfilePage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const route = '/profile/';
  static const routename = 'ProfilePage';

  @override
  Widget build(BuildContext context) {
    print('${ProfilePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ProfilePage.routename),
        actions: [
          IconButton(
              onPressed: () => _toEditProfilePage(context),
              icon: Icon(Icons.edit))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: Colors.orange,
                child: Center(
                  child: Text('Background image goes here'),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text("Valentino Marchesan"),
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 150.0, // (background container size) - (circle height / 2)
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),
          )
        ],
      ),
    );
  } //build

  void _toEditProfilePage(BuildContext context) {
    //Push the EditProfilePage
    Navigator.pushNamed(context, EditProfilePage.route);
  } //_toEditProfilePage

} //ProfilePage