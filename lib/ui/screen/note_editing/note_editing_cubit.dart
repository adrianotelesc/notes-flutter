import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/model/note.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/main.dart';
import 'package:notes/ui/screen/note_editing/note_editing_ui_state.dart';
import 'package:uuid/uuid.dart';

class NoteEditingCubit extends Cubit<NoteEditingUiState> {
  NoteRepository noteRepo = getIt<NoteRepository>();

  NoteEditingCubit({required String? noteId})
      : super(NoteEditingUiState(note: Note(id: const Uuid().v1()))) {
    loadNoteIfIdIsNotNull(noteId);
  }

  void loadNoteIfIdIsNotNull(String? noteId) {
    if (noteId != null) {
      final note = noteRepo.findBy(id: noteId);
      if (note != null) {
        emit(NoteEditingUiState(note: note));
      }
    }
  }

  void updateNote(String text) {
    final note = Note(id: state.note.id, text: text);
    noteRepo.update(note: note);
  }
}
