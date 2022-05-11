import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IdratationPage extends StatelessWidget {
  IdratationPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'Page';

  @override
  Widget build(BuildContext context) {
    print('${IdratationPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(IdratationPage.routename),
      ),
      body: Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page

