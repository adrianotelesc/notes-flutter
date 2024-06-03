import 'dart:async';
import 'package:postnote/data/models/note.dart';
import 'package:postnote/data/repositories/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  final Map<String, List<Note>> _notes = {};
  final _notesStreamController =
      StreamController<Map<String, List<Note>>>.broadcast();

  NoteRepositoryImpl() {
    _notesStreamController.onListen = () => _notesStreamController.add(_notes);
  }

  @override
  Stream<List<Note>> getNotesStream(String collectionId) =>
      _notesStreamController.stream.map((event) => event[collectionId] ?? []);

  @override
  Note? findById(String collectionId, String id) =>
      _notes[collectionId]?.where((element) => element.id == id).firstOrNull;

  @override
  void update(String collectionId, Note note) {
    final existingNote = findById(collectionId, note.id);
    if (existingNote != null) {
      if (existingNote.isNotEmpty && note.isEmpty) {
        remove(collectionId, existingNote);
      } else if (existingNote != note) {
        replace(collectionId, existingNote, note);
      }
    } else {
      add(collectionId, note);
    }
  }

  @override
  void add(String collectionId, Note note, {int index = 0}) {
    if (note.isEmpty) return;
    if (_notes[collectionId] == null) _notes[collectionId] = [];
    _notes[collectionId]?.insert(index, note);
    _notesStreamController.add(_notes);
  }

  @override
  void remove(String collectionId, Note note) {
    _notes[collectionId]?.remove(note);
    _notesStreamController.add(_notes);
  }

  @override
  void replace(String collectionId, Note oldNote, Note newNote) {
    final index = _notes[collectionId]?.indexOf(oldNote) ?? 0;
    _notes[collectionId]?.removeAt(index);
    _notes[collectionId]?.insert(index, newNote);
    _notesStreamController.add(_notes);
  }

  @override
  void onListen() {
    _notesStreamController.add(_notes);
  }
}
