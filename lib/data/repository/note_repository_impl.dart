import 'dart:async';

import 'package:notes/data/model/note.dart';
import 'package:notes/data/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final List<Note> notes = [];
  final _notes = StreamController<List<Note>>();

  @override
  Stream<List<Note>> getNotes() => _notes.stream;

  @override
  void addNote({required String text}) {
    notes.insert(0, Note(text: text));
    _notes.add(notes);
  }
}
