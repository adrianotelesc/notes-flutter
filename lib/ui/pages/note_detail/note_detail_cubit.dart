import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/data/models/note.dart';
import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/ui/pages/note_detail/note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailState> {
  final String boardId;
  final NoteRepository _noteRepo;

  NoteDetailCubit(
    this.boardId,
    this._noteRepo,
  ) : super(NoteDetailState(note: Note()));

  void initState({String? noteId}) {
    _findAndEmitNote(noteId: noteId);
  }

  void _findAndEmitNote({required String? noteId}) {
    if (noteId == null) return;
    final note = _noteRepo.findById(boardId, noteId);

    if (note == null) return;
    emit(state.copyWith(note: note));
  }

  void updateNote(String text) {
    final note = state.note.copyWith(text: text);
    _noteRepo.update(boardId, note);
    emit(state.copyWith(note: note));
  }
}
