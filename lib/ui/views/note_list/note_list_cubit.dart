import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/ui/views/note_list/note_list_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository _noteRepo;

  StreamSubscription? _notesStreamSubscription;

  NotesCubit(this._noteRepo) : super(const NotesState());

  void initState(String collectionId) {
    _emitcollectionId(collectionId);
    _listenAndEmitNotes();
  }

  void _emitcollectionId(String collectionId) {
    emit(state.copyWith(collectionId: collectionId));
  }

  void _listenAndEmitNotes() {
    final notesStream = _noteRepo.getNotesStream(state.collectionId);
    _notesStreamSubscription = notesStream.listen((notes) {
      emit(state.copyWith(notes: notes));
    });
    _noteRepo.onListen();
  }

  @override
  Future<void> close() {
    _notesStreamSubscription?.cancel();
    _notesStreamSubscription = null;
    return super.close();
  }
}
