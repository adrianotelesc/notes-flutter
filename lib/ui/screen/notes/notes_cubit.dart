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
    final noteCount = state.notes.length + 1;
    var text = "This is note $noteCount";
    if (noteCount % 2 == 0) {
      text =
          "This is note  $noteCount.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer congue metus accumsan aliquet vestibulum. Sed pellentesque diam tincidunt ligula sollicitudin porttitor.";
    }
    noteRepo.addNote(
      text: text,
    );
  }
}
