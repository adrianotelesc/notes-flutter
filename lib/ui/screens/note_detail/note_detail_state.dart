import 'package:postnote/data/models/note.dart';

class NoteDetailState {
  final Note note;

  NoteDetailState({required this.note});

  NoteDetailState copyWith({Note? note}) {
    return NoteDetailState(
      note: note ?? this.note,
    );
  }
}
