import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CaloriesPage extends StatelessWidget {
  CaloriesPage({Key? key}) : super(key: key);

  static const route = '/Home/';
  static const routename = 'CaloriesPage';

  @override
  Widget build(BuildContext context) {
    print('${CaloriesPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(CaloriesPage.routename),
      ),
      body: Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page