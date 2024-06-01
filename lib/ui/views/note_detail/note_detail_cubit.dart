import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/data/models/note.dart';
import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/ui/views/note_detail/note_detail_state.dart';

class NoteDetailsCubit extends Cubit<NoteDetailsState> {
  final NoteRepository _noteRepo;

  NoteDetailsCubit(this._noteRepo) : super(NoteDetailsState(note: Note()));

  void initState({required String collectionId, String? noteId}) {
    _findNote(collectionId: collectionId, noteId: noteId);
  }

  void _findNote({required String collectionId, required String? noteId}) {
    if (noteId == null) return;
    final note = _noteRepo.findById(collectionId, noteId);
    emit(state.copyWith(collectionId: collectionId, note: note));
  }

  void updateNote(String text) {
    final note = state.note.copyWith(text: text);
    final collectionId = state.collectionId;
    _noteRepo.update(collectionId, note);
    emit(state.copyWith(note: note));
  }
}
