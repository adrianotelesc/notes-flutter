import 'package:uuid/uuid.dart';

class Note {
  final String text;

  final String id;

  bool get isEmpty => text.trim().isEmpty;

  bool get isNotEmpty => !isEmpty;

  Note({String? id, this.text = ''}) : id = id ?? const Uuid().v1();

  Note copy({String? id, String? text}) =>
      Note(id: id ?? this.id, text: text ?? this.text);
}
