import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/data/repositories/note_repository.dart';
import 'package:postnote/ui/screens/note_list/note_list_state.dart';

class NoteListCubit extends Cubit<NoteListState> {
  final String boardId;
  final NoteRepository _noteRepo;

  StreamSubscription? _notesStreamSubscription;

  NoteListCubit(
    this.boardId,
    this._noteRepo,
  ) : super(const NoteListState());

  void initState() {
    _listenAndEmitNotes();
  }

  void _listenAndEmitNotes() {
    final notesStream = _noteRepo.getNotesStream(boardId);
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
