import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/data/models/note.dart';
import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/ui/screens/note_detail/note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailState> {
  final String collectionId;
  final NoteRepository _noteRepo;

  NoteDetailCubit(
    this.collectionId,
    this._noteRepo,
  ) : super(NoteDetailState(note: Note()));

  void initState({String? noteId}) {
    _findNote(noteId: noteId);
  }

  void _findNote({required String? noteId}) {
    if (noteId == null) return;
    final note = _noteRepo.findById(collectionId, noteId);

    if (note == null) return;
    emit(state.copyWith(note: note));
  }

  void updateNote(String text) {
    final note = state.note.copyWith(text: text);
    _noteRepo.update(collectionId, note);
    emit(state.copyWith(note: note));
  }
}
