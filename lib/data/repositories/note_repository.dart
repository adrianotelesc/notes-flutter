import 'package:postnote/data/models/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotesStream(String code);

  void onListen();

  Note? findById(String code, String id);

  void update(String code, Note note);

  void add(String code, Note note, {int index = 0});

  void remove(String code, Note note);

  void replace(String code, Note oldNote, Note newNote);
}
