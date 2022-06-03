import 'package:project/database/database.dart';
import 'package:project/database/entities/annotation.dart';
import 'package:flutter/material.dart';
import 'package:project/database/entities/sleep.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllAnnotations() method of the DAO
  Future<List<Annotation>> findAllAnnotations() async {
    final results = await database.annotationDao.findAllAnnotations();
    return results;
  } //findAllAnnotations

  //This method wraps the insertAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertAnnotation(Annotation annotation) async {
    await database.annotationDao.insertAnnotation(annotation);
    notifyListeners();
  } //insertAnnotation

  //This method wraps the deleteAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeAnnotation(Annotation annotation) async {
    await database.annotationDao.deleteAnnotation(annotation);
    notifyListeners();
  } //removeAnnotation

  //This method wraps the updateAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateAnnotation(Annotation annotation) async {
    await database.annotationDao.updateAnnotation(annotation);
    notifyListeners();
  } //updateAnnotation

  Future<List<Sleep>> findAllSleep() async {
    final results = await database.sleepDao.findAllSleep();
    return results;
  } //findAllAnnotations

  //This method wraps the insertAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertSleep(Sleep sleep) async {
    await database.sleepDao.insertSleep(sleep);
    notifyListeners();
  } //insertAnnotation

  //This method wraps the deleteAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> removeSleep(Sleep sleep) async {
    await database.sleepDao.deleteSleep(sleep);
    notifyListeners();
  } //removeAnnotation

  //This method wraps the updateAnnotation() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> updateSleep(Sleep sleep) async {
    await database.sleepDao.updateSleep(sleep);
    notifyListeners();
  } //updateAnnotation
} //DatabaseRepository
