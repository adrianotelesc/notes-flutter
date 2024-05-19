import 'package:postnote/data/model/note.dart';

class NoteEditorState {
  final String code;
  final Note note;

  NoteEditorState({this.code = '', required this.note});

  NoteEditorState copyWith({String? code, Note? note}) {
    return NoteEditorState(
      code: code ?? this.code,
      note: note ?? this.note,
    );
  }
}
