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
  Stream<List<Note>> getNotesStream(String topic) =>
      _notesStreamController.stream.map((event) => event[topic] ?? []);

  @override
  Note? findById(String topic, String id) =>
      _notes[topic]?.where((element) => element.id == id).firstOrNull;

  @override
  void update(String topic, Note note) {
    final existingNote = findById(topic, note.id);
    if (existingNote != null) {
      if (existingNote.isNotEmpty && note.isEmpty) {
        remove(topic, existingNote);
      } else if (existingNote != note) {
        replace(topic, existingNote, note);
      }
    } else {
      add(topic, note);
    }
  }

  @override
  void add(String topic, Note note, {int index = 0}) {
    if (note.isEmpty) return;
    if (_notes[topic] == null) _notes[topic] = [];
    _notes[topic]?.insert(index, note);
    _notesStreamController.add(_notes);
  }

  @override
  void remove(String topic, Note note) {
    _notes.remove(note);
    _notesStreamController.add(_notes);
  }

  @override
  void replace(String topic, Note oldNote, Note newNote) {
    final index = _notes[topic]?.indexOf(oldNote) ?? 0;
    _notes[topic]?.removeAt(index);
    _notes[topic]?.insert(index, newNote);
    _notesStreamController.add(_notes);
  }
}
