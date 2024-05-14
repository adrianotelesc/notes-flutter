import 'package:postnote/data/model/note.dart';

class NoteEditorState {
  final String topic;
  final Note note;

  NoteEditorState({this.topic = '', required this.note});

  NoteEditorState copyWith({String? topic, Note? note}) {
    return NoteEditorState(
      topic: topic ?? this.topic,
      note: note ?? this.note,
    );
  }
}
