import 'package:project/models/walk.dart';
import 'package:flutter/material.dart';

//This class extends ChangeNotifier.
//It will act as data repository for the walks and will be shared thorugh the application.
class WalkDB extends ChangeNotifier {
  //The WalkDB can be represented as list of walks.
  List<Walk> walks = [];

  //Method to use to add a walk.
  void addWalk(Walk toAdd) {
    walks.add(toAdd);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //addProduct

  //Method to use to edit a walk.
  void editWalk(int index, Walk newWalk) {
    walks[index] = newWalk;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //editWalk

  //Method to use to delete a walk.
  void deleteWalk(int index) {
    walks.removeAt(index);
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  } //deleteWalk

}//WalkDB
