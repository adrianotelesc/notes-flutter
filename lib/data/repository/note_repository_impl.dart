import 'dart:async';

import 'package:notes/data/model/note.dart';
import 'package:notes/data/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final List<Note> notes = [];
  final _streamController = StreamController<List<Note>>();

  @override
  Stream<List<Note>> getNotes() => _streamController.stream;

  @override
  Note? findById(String id) =>
      notes.where((element) => element.id == id).firstOrNull;

  @override
  void add(Note note, {int index = 0}) {
    if (note.text.isEmpty) return;
    notes.insert(index, note);
    _streamController.add(notes);
  }

  @override
  void remove(Note note) {
    notes.remove(note);
    _streamController.add(notes);
  }

  @override
  void replace(Note oldNote, Note newNote) {
    final index = notes.indexOf(oldNote);
    remove(oldNote);
    add(newNote, index: index);
    _streamController.add(notes);
  }

  @override
  void update(Note note) {
    final oldNote = findById(note.id);
    if (oldNote == null) {
      add(note);
    } else {
      if (oldNote.text.isNotEmpty && note.text.isEmpty) {
        remove(oldNote);
      } else if (oldNote != note) {
        replace(oldNote, note);
      }
    }
  }
}
