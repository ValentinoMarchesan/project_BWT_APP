import 'dart:async';
import 'package:floor/floor.dart';
import 'package:project/database/daos/accountdatadao.dart';
import 'package:project/database/daos/activitydao.dart';
import 'package:project/database/daos/heartdatadao.dart';
import 'package:project/database/daos/stepdatadao.dart';
import 'package:project/database/entities/accountdata.dart';
import 'package:project/database/entities/activityentity.dart';
import 'package:project/database/entities/heartentity.dart';
import 'package:project/database/entities/sleepentity.dart';
import 'package:project/database/entities/stepentity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/sleepdatadao.dart';

//The generated code will be in database.g.dart

@Database(
    version: 1,
    entities: [AccountData, ActivityData, HeartData, SleepData, StepData])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  AccountDataDao get accountdataDao;
  ActivityDataDao get activityData;
  HeartDataDao get heartData;
  SleepDataDao get sleepData;
  StepsDataDao get stepData;
}//AppDatabase