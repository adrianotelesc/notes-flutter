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
  Stream<List<Note>> getNotesStream(String boardId) =>
      _notesStreamController.stream.map((event) => event[boardId] ?? []);

  @override
  Note? findById(String boardId, String id) =>
      _notes[boardId]?.where((element) => element.id == id).firstOrNull;

  @override
  void update(String boardId, Note note) {
    final existingNote = findById(boardId, note.id);
    if (existingNote != null) {
      if (existingNote.isNotEmpty && note.isEmpty) {
        remove(boardId, existingNote);
      } else if (existingNote != note) {
        replace(boardId, existingNote, note);
      }
    } else {
      add(boardId, note);
    }
  }

  @override
  void add(String boardId, Note note, {int index = 0}) {
    if (note.isEmpty) return;
    if (_notes[boardId] == null) _notes[boardId] = [];
    _notes[boardId]?.insert(index, note);
    _notesStreamController.add(_notes);
  }

  @override
  void remove(String boardId, Note note) {
    _notes[boardId]?.remove(note);
    _notesStreamController.add(_notes);
  }

  @override
  void replace(String boardId, Note oldNote, Note newNote) {
    final index = _notes[boardId]?.indexOf(oldNote) ?? 0;
    _notes[boardId]?.removeAt(index);
    _notes[boardId]?.insert(index, newNote);
    _notesStreamController.add(_notes);
  }

  @override
  void onListen() {
    _notesStreamController.add(_notes);
  }
}
