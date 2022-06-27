//Imports necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:project/database/daos/heartDao.dart';
import 'package:project/database/daos/sleepDao.dart';
import 'package:project/database/entities/activity.dart';
import 'package:project/database/entities/heart.dart';
import 'package:project/database/entities/sleep.dart';
import 'package:project/database/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//importing the entities and the daos of the database
import 'package:project/database/daos/annotationDao.dart';
import 'package:project/database/entities/annotation.dart';

import 'daos/activityDao.dart';

//The generated code will be in database.g.dart
part 'database.g.dart';

//This is the first version of the Database and it has 4 entity = Annotation,Sleep,Heart,Activity.
//TypeConverter added to manage the DateTime of a Annotation entry, since DateTimes are not supported by Floor.

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Annotation, Sleep, Heart, Activity])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  AnnotationDao get annotationDao;
  SleepDao get sleepDao;
  HeartDao get heartDao;
  ActivityDao get activityDao;
}//AppDatabase
