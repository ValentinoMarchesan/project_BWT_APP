import 'package:floor/floor.dart';

@entity
class Passi {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final double? passi;

  Passi(
    this.id,
    this.passi,
  );
}
