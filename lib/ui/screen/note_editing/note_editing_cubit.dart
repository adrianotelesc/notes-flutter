import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/model/note.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/ui/screen/note_editing/note_editing_ui_state.dart';

class NoteEditingCubit extends Cubit<NoteEditingUiState> {
  NoteRepository noteRepo;

  NoteEditingCubit({
    required String? noteId,
    required this.noteRepo,
  }) : super(NoteEditingUiState(note: Note())) {
    emitStateWithNoteBy(id: noteId);
  }

  void emitStateWithNoteBy({required String? id}) {
    if (id == null) return;
    final note = noteRepo.findById(id);

    if (note == null) return;
    emit(NoteEditingUiState(note: note));
  }

  void updateNote(String text) {
    final note = state.note.copy(text: text);
    noteRepo.update(note);
  }
}
