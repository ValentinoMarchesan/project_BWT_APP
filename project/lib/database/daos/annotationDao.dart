import 'package:project/database/entities/annotation.dart';
import 'package:floor/floor.dart';

//class that defines the DAO of Annotation entity

@dao
abstract class AnnotationDao {
  //Query #1: SELECT ->  permette di ottenere tutte le entries della tabella Annotation
  @Query('SELECT * FROM Annotation')
  Future<List<Annotation>> findAllAnnotations();

  //Query #2: INSERT di una nuova annotation nella tabella
  @insert
  Future<void> insertAnnotation(Annotation annotation);

  //Query #3: DELETE di una annotation nella tabella
  @delete
  Future<void> deleteAnnotation(Annotation task);

  //Query #4: UPDATE -> update una annotatino entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAnnotation(Annotation annotation);

  @Query('DELETE FROM Annotation')
  Future<void> deleteAllAnnotation();
} //AnnotationDao
