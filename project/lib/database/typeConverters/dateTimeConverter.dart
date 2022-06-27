import 'package:floor/floor.dart';

class DateTimeConverter extends TypeConverter<DateTime, int> {
  //convert an int in a type datetime
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  } //decode

//convert the datetime in int
  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  } //encode
}//DateTimeConverter
