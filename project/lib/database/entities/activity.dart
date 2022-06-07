import 'package:floor/floor.dart';

// per dire a floor che questa è una classe che definisce una entity
@entity
class Activity {
  @PrimaryKey(autoGenerate: true)
  final int? id; //è la primary key, è nullable perchè viene autogenerata

  final int? sleepduration; // data e ora

  //constructor
  Activity(this.id, this.sleepduration);
}
