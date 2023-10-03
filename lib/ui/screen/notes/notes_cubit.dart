import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/data/repository/note_repository_impl.dart';
import 'package:notes/ui/screen/notes/notes_ui_state.dart';

class NotesCubit extends Cubit<NotesUiState> {
  NoteRepository noteRepo = NoteRepositoryImpl();

  NotesCubit({required this.noteRepo}) : super(const NotesUiState()) {
    noteRepo.getNotes().listen(
      (notes) {
        emit(NotesUiState(notes: notes));
      },
    );
  }

  void addNote() {
    noteRepo.addNote(
      text: "This is note ${state.notes.length + 1}",
    );
  }
}
