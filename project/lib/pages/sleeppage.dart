import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SleepPage extends StatelessWidget {
  SleepPage({Key? key}) : super(key: key);

  static const route = '/home/sleep';
  static const routename = 'SleepPage';

  @override
  Widget build(BuildContext context) {
    print('${SleepPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(SleepPage.routename),
      ),
      body: Center(
        child: Text('che sonno che ho '),
      ),
    );
  } //build

} //Page