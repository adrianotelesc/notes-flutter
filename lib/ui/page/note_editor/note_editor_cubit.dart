import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:postnote/data/model/note.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/ui/page/note_editor/note_editor_state.dart';

class NoteEditorCubit extends Cubit<NoteEditorState> {
  final _noteRepo = GetIt.instance.get<NoteRepository>();

  NoteEditorCubit() : super(NoteEditorState(note: Note()));

  void initState({required String topic, String? noteId}) {
    _findNote(topic: topic, noteId: noteId);
  }

  void _findNote({required String topic, required String? noteId}) {
    if (noteId == null) return;
    final note = _noteRepo.findById(topic, noteId);
    emit(state.copyWith(topic: topic, note: note));
  }

  void updateNote(String text) {
    final note = state.note.copyWith(text: text);
    final topic = state.topic;
    _noteRepo.update(topic, note);
    emit(state.copyWith(note: note));
  }
}
