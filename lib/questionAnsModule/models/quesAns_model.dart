

class QuestionnaireModel {
  final String title;
  final List<Field> fields;
 

  QuestionnaireModel(
      {required this.title, required this.fields});
}

class Field {
  final String type;
   String? ans;

  final Schemma schemma;

  Field({required this.type, required this.schemma,this.ans});
}

class Schemma {
  final String label;
  final List<Map>? options;
    final List<Field>? fields;

  Schemma({required this.label,  this.options,this.fields});
}
