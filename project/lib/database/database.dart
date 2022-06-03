//Imports necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:project/database/typeConverters/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//importing the entities and the daos of the database
import 'package:project/database/daos/annotationDao.dart';
import 'package:project/database/entities/annotation.dart';

//The generated code will be in database.g.dart
part 'database.g.dart';

//This is the first version of the Database and it has just 1 entity = Annotation.
//TypeConverter added to manage the DateTime of a Meal entry, since DateTimes are not supported by Floor.

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Annotation])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  AnnotationDao get annotationDao;
}//AppDatabase
