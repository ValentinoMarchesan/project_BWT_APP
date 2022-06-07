import 'package:floor/floor.dart';

// per dire a floor che questa è una classe che definisce una entity
@entity
class Sleep {
  @PrimaryKey(autoGenerate: true)
  final int? id; //è la primary key, è nullable perchè viene autogenerata

  final int? sleepduration; // data e ora

  //constructor
  Sleep(this.id, this.sleepduration);
}
