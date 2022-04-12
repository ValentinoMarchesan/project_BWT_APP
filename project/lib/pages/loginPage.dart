import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  //const LoginPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'LoginPage';
  final inputBorder = BorderRadius.vertical(
    bottom: Radius.circular(10.0),
    top: Radius.circular(20.0),
  );

  Future<String> _loginUser(LoginData data) async {
    if (data.name == 'bug@expert.com' && data.password == '0000') {
      return '';
    } else {
      return 'Oops! We could not find matching credentials';
    }
  } // _loginUser

  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  } // _signUpUser

  Future<String> _recoverPassword(String email) async {
    return 'Recover password functionality needs to be implemented';
  } // _recoverPassword

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'MyMo',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async {
        Navigator.of(context).pushReplacementNamed(HomePage.route);
      },
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 229, 121, 157),
        pageColorLight: Colors.lightBlue,
        accentColor: Color.fromARGB(255, 255, 255, 255),
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Quicksand',
          letterSpacing: 6,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.black,
          shadows: [
            Shadow(color: Color.fromARGB(255, 210, 239, 244), blurRadius: 2)
          ],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 247, 247, 226).withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.deepOrange,
            color: Colors.white,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 189, 189, 235), width: 6),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 218, 209, 232), width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 216, 178, 228), width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 215, 186, 220), width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Color.fromARGB(255, 185, 223, 234),
          backgroundColor: Color.fromARGB(255, 101, 173, 232),
          highlightColor: Color.fromARGB(255, 211, 175, 146),
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}

/*    BASIC LOGINPAGE TAMPLATE 
@override
  Widget build(BuildContext context) {
    print('${LoginPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(LoginPage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('To the HomePage'),
              onPressed: () {
                Navigator.pushNamed(context, HomePage.route);
              },
            ),
          ],
        ),
      ),
    );
  } //build
*/