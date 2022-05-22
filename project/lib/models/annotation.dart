//This is the data model of an annotation (che verrà aggiunta al diario).

class Annotation {
  int min; // minuti di meditazione
  int ml; // ml di acqua bevuti (250 ml = 1 bicchiere)

  DateTime dateTime; // data e ora di acquisizione dell'annotazione del diario

  // Constructor
  Annotation({required this.min, required this.ml, required this.dateTime}); //
} //Walk
