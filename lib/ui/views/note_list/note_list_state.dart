import 'package:postnote/data/models/note.dart';

class NotesState {
  final String collectionId;
  final List<Note> notes;

  const NotesState({
    this.collectionId = '',
    this.notes = const [],
  });

  NotesState copyWith({String? collectionId, List<Note>? notes}) {
    return NotesState(
      collectionId: collectionId ?? this.collectionId,
      notes: notes ?? this.notes,
    );
  }
}
