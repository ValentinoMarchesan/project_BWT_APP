import 'dart:async';

import 'package:floor/floor.dart';
import 'package:project/database/stepdao.dart';
import 'package:project/database/stepentity.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Passi])
abstract class AppDatabase extends FloorDatabase {
  StepDao get stepdao;
}
