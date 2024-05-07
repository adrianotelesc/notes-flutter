import 'dart:async';

import 'package:postnote/data/model/note.dart';
import 'package:postnote/data/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final List<Note> _notes = [];
  final _notesStreamController = StreamController<List<Note>>();

  @override
  Stream<List<Note>> get notes => _notesStreamController.stream;

  @override
  Note? findById(String id) =>
      _notes.where((element) => element.id == id).firstOrNull;

  @override
  void update(Note note) {
    final existingNote = findById(note.id);
    if (existingNote != null) {
      if (existingNote.isNotEmpty && note.isEmpty) {
        remove(existingNote);
      } else if (existingNote != note) {
        replace(existingNote, note);
      }
    } else {
      add(note);
    }
  }

  @override
  void add(Note note, {int index = 0}) {
    if (note.isEmpty) return;
    _notes.insert(index, note);
    _notesStreamController.add(_notes);
  }

  @override
  void remove(Note note) {
    _notes.remove(note);
    _notesStreamController.add(_notes);
  }

  @override
  void replace(Note oldNote, Note newNote) {
    final index = _notes.indexOf(oldNote);
    _notes.removeAt(index);
    _notes.add(newNote);
    _notesStreamController.add(_notes);
  }
}
