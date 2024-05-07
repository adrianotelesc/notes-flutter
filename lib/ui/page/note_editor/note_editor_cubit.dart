import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postnote/data/model/note.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/ui/page/note_editor/note_editor_state.dart';

class NoteEditorCubit extends Cubit<NoteEditorState> {
  NoteRepository noteRepo;

  NoteEditorCubit({
    required String? noteId,
    required this.noteRepo,
  }) : super(NoteEditorState(note: Note())) {
    emitStateWithNoteBy(id: noteId);
  }

  void emitStateWithNoteBy({required String? id}) {
    if (id == null) return;
    final note = noteRepo.findById(id);

    if (note == null) return;
    emit(NoteEditorState(note: note));
  }

  void updateNote(String text) {
    final note = state.note.copy(text: text);
    noteRepo.update(note);
  }
}
