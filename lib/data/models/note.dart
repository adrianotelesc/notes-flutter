import 'package:uuid/uuid.dart';

class Note {
  final String id;

  final String text;

  bool get isEmpty => text.trim().isEmpty;

  bool get isNotEmpty => !isEmpty;

  Note({
    String? id,
    this.text = '',
  }) : id = id ?? const Uuid().v1();

  Note copyWith({String? id, String? text}) {
    return Note(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Note && id == other.id && text == other.text;
  }
}
