import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HeartPage extends StatelessWidget {
  HeartPage({Key? key}) : super(key: key);

  static const route = '/home/heart';
  static const routename = 'HearthPage';

  @override
  Widget build(BuildContext context) {
    print('${HeartPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HeartPage.routename),
      ),
      body: Center(
        child: Text('un cuore matto,matto da legare'),
      ),
    );
  } //build

} //Page