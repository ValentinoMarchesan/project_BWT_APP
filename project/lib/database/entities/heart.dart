import 'package:floor/floor.dart';

// per dire a floor che questa è una classe che definisce una entity
@entity
class Heart {
  @PrimaryKey(autoGenerate: true)
  final int? id; //è la primary key, è nullable perchè viene autogenerata

  final int? minutesheart; // data e ora

  //constructor
  Heart(this.id, this.minutesheart);
}
