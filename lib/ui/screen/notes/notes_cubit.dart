import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/main.dart';
import 'package:notes/ui/screen/notes/notes_ui_state.dart';

class NotesCubit extends Cubit<NotesUiState> {
  NoteRepository noteRepo = getIt<NoteRepository>();

  NotesCubit() : super(const NotesUiState()) {
    noteRepo.getNotes().listen(
      (notes) {
        emit(NotesUiState(notes: notes));
      },
    );
  }
}
