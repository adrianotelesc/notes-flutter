import 'dart:async';
import 'package:postnote/data/model/note.dart';
import 'package:postnote/data/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final Map<String, List<Note>> _notes = {};
  final _notesStreamController =
      StreamController<Map<String, List<Note>>>.broadcast();

  NoteRepositoryImpl() {
    _notesStreamController.onListen = () => _notesStreamController.add(_notes);
  }

  @override
  Stream<List<Note>> getNotesStream(String code) =>
      _notesStreamController.stream.map((event) => event[code] ?? []);

  @override
  Note? findById(String code, String id) =>
      _notes[code]?.where((element) => element.id == id).firstOrNull;

  @override
  void update(String code, Note note) {
    final existingNote = findById(code, note.id);
    if (existingNote != null) {
      if (existingNote.isNotEmpty && note.isEmpty) {
        remove(code, existingNote);
      } else if (existingNote != note) {
        replace(code, existingNote, note);
      }
    } else {
      add(code, note);
    }
  }

  @override
  void add(String code, Note note, {int index = 0}) {
    if (note.isEmpty) return;
    if (_notes[code] == null) _notes[code] = [];
    _notes[code]?.insert(index, note);
    _notesStreamController.add(_notes);
  }

  @override
  void remove(String code, Note note) {
    _notes.remove(note);
    _notesStreamController.add(_notes);
  }

  @override
  void replace(String code, Note oldNote, Note newNote) {
    final index = _notes[code]?.indexOf(oldNote) ?? 0;
    _notes[code]?.removeAt(index);
    _notes[code]?.insert(index, newNote);
    _notesStreamController.add(_notes);
  }
}
