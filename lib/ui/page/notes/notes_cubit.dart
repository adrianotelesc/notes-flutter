import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/ui/page/notes/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final _noteRepo = GetIt.instance.get<NoteRepository>();

  StreamSubscription? _notesStreamSubscription;

  NotesCubit() : super(const NotesState());

  void initState() {
    _listenNotes();
  }

  void _listenNotes() {
    _notesStreamSubscription = _noteRepo.notesStream.listen((notes) {
      emit(state.copyWith(notes: notes));
    });
  }

  @override
  Future<void> close() {
    _notesStreamSubscription?.cancel();
    _notesStreamSubscription = null;
    return super.close();
  }
}
