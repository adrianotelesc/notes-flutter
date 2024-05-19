import 'package:postnote/data/model/note.dart';

class NoteDetailsState {
  final String code;
  final Note note;

  NoteDetailsState({this.code = '', required this.note});

  NoteDetailsState copyWith({String? code, Note? note}) {
    return NoteDetailsState(
      code: code ?? this.code,
      note: note ?? this.note,
    );
  }
}
