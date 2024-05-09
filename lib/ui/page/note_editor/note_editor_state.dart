import 'package:postnote/data/model/note.dart';

class NoteEditorState {
  final Note note;

  NoteEditorState({required this.note});

  NoteEditorState copyWith({Note? note}) {
    return NoteEditorState(note: note ?? this.note);
  }
}
