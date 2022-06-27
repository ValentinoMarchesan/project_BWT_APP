import 'dart:convert';

import 'package:project/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/flutter_login.dart';

class Userpreferences {
  static const email_name = "meco@biomedical.com";
  static late SharedPreferences _preferences;
  static const _keyUser = 'user'; //in key user we store user information
  static const myUser = User(
      imagePath: 'assets/profile_pic.png',
      name: 'Name',
      email: email_name,
      about: 'somethings about you');

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  //async //await

  static Future setUser(User user) async {
    //convert  json map to String
    final json =
        jsonEncode(user.toJson()); //jsonEcode return a string from json map

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);
    //because json can be nullable
    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
