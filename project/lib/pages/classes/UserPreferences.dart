import 'dart:convert';

import 'package:project/pages/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userpreferences {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user'; //in key user we store user information
  static const myUser = User(
      // backgroundPath: 'assets/tree.jpg',
      imagePath: 'assets/donna.png',
      name: 'Maria Ghirardi',
      email: 'maria.ghirardi@studenti.unipd.it',
      about: 'faccio i video con i droni e sono milanese');

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
