import 'package:notes/data/model/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> get notes;

  Note? findById(String id);

  void update(Note note);

  void add(Note note, {int index = 0});

  void remove(Note note);

  void replace(Note oldNote, Note newNote);
}
