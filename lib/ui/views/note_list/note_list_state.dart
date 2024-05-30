import 'package:postnote/data/models/note.dart';

class NotesState {
  final List<Note> notes;
  final String code;

  const NotesState({
    this.code = '',
    this.notes = const [],
  });

  NotesState copyWith({String? code, List<Note>? notes}) {
    return NotesState(
      code: code ?? this.code,
      notes: notes ?? this.notes,
    );
  }
}
