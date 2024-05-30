import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/data/models/note.dart';
import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/ui/views/note_detail/note_detail_state.dart';

class NoteDetailsCubit extends Cubit<NoteDetailsState> {
  final NoteRepository _noteRepo;

  NoteDetailsCubit(this._noteRepo) : super(NoteDetailsState(note: Note()));

  void initState({required String code, String? noteId}) {
    _findNote(code: code, noteId: noteId);
  }

  void _findNote({required String code, required String? noteId}) {
    if (noteId == null) return;
    final note = _noteRepo.findById(code, noteId);
    emit(state.copyWith(code: code, note: note));
  }

  void updateNote(String text) {
    final note = state.note.copyWith(text: text);
    final code = state.code;
    _noteRepo.update(code, note);
    emit(state.copyWith(note: note));
  }
}
