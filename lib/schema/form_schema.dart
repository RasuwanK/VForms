enum FieldTypes {
  text,
  multiline,
  checkboxes,
}

class FormField {
  final String _id;
  final String _question;
  final FieldTypes _type;
  final String _answer;

  FormField({
    required this._id,
    required this._question,
    required this._type,
    required this._answer,
  });

  String get id => _id;
  String get question => _question;
  FieldTypes get type => _type;
  String get answer => _answer;

  Map<String, dynamic> toJson() => {
    'id': _id,
    'question': _question,
    'type': _type.toString(),
    'answer': _answer,
  };

  FormField.fromJson(Map<String, dynamic> json) :
    _id = json['id'],
    _question = json['question'],
    _type = FieldTypes.values.firstWhere((type) => type.toString() == json['type']),
    _answer = json['answer'];
}

class FormSchema {
  final List<FormField> _fields;

  FormSchema({required this._fields});

  List<FormField> get fields => _fields;

  Map<String, dynamic> toJson() => {
    'fields': _fields.map((field) => field.toJson()).toList(),
  };

  FormSchema.fromJson(Map<String, dynamic> json) :
    _fields = (json['fields'] as List).map((field) => FormField.fromJson(field)).toList();
}