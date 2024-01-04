import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repository/note_repository.dart';
import 'package:notes/main.dart';
import 'package:notes/ui/page/notes/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NoteRepository noteRepo = getIt<NoteRepository>();

  NotesCubit() : super(const NotesState()) {
    noteRepo.notes.listen((notes) {
      emit(NotesState(notes: notes));
    });
  }
}
