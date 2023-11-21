import 'dart:async';

import 'package:notes/data/model/note.dart';
import 'package:notes/data/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final List<Note> notes = [];
  final _notes = StreamController<List<Note>>();

  @override
  Stream<List<Note>> getNotes() => _notes.stream;

  @override
  bool add({required Note note}) {
    notes.insert(0, note);
    _notes.add(notes);
    return true;
  }

  @override
  bool delete({required Note note}) {
    final isSuccess = notes.remove(note);
    _notes.add(notes);
    return isSuccess;
  }

  @override
  Note? findBy({required String id}) {
    return notes.where((element) => element.id == id).firstOrNull;
  }

  @override
  bool replace({required Note oldNote, required Note newNote}) {
    final index = notes.indexOf(oldNote);
    delete(note: oldNote);
    notes.insert(index, newNote);
    _notes.add(notes);
    return true;
  }

  @override
  bool update({required Note note}) {
    final oldNote = findBy(id: note.id);
    if (oldNote == null && note.text.isNotEmpty) {
      return add(note: note);
    } else if (oldNote != null &&
        oldNote.text.isNotEmpty &&
        note.text.isEmpty) {
      return delete(note: oldNote);
    } else if (oldNote != null && oldNote != note) {
      return replace(oldNote: oldNote, newNote: note);
    }

    return false;
  }
}
