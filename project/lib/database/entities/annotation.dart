import 'package:floor/floor.dart';

// per dire a floor che questa è una classe che definisce una entity
@entity
class Annotation {
  @PrimaryKey(autoGenerate: true)
  final int? id; //è la primary key, è nullable perchè viene autogenerata

  final int min; // minuti di meditazione
  final int ml; // ml di acqua bevuti (250 ml = 1 bicchiere)
  final String mood; // umore
  final DateTime dateTime; // data e ora

  //constructor
  Annotation(this.id, this.min, this.ml, this.mood, this.dateTime);
} //Annotation
