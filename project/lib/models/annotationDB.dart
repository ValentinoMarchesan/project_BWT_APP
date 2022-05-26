import 'package:project/models/annotation.dart';
import 'package:flutter/material.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the annotations and will be shared thorugh the application.

class AnnotationDB extends ChangeNotifier {
  // AnnotationDB can be represented as list of annotations.
  List<Annotation> annotations = [];

  //Method to use to ADD an annotation.
  void addAnnotation(Annotation toAdd) {
    annotations.add(toAdd);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //addProduct

  //Method to use to EDIT an annotatino.
  void editAnnotation(int index, Annotation newAnnotation) {
    annotations[index] = newAnnotation;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //editAnnotation

  //Method to use to DELETE an annotation.
  void deleteAnnotation(int index) {
    annotations.removeAt(index);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //deleteAnnotation

}//AnnotatinoDB
