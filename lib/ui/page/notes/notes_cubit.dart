import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/main.dart';
import 'package:postnote/ui/page/notes/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NoteRepository noteRepo = getIt<NoteRepository>();

  NotesCubit() : super(const NotesState()) {
    noteRepo.notes.listen((notes) {
      emit(NotesState(notes: notes));
    });
  }
}
