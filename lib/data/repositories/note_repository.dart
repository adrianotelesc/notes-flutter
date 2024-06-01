import 'package:postnote/data/models/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotesStream(String collectionId);

  void onListen();

  Note? findById(String collectionId, String id);

  void update(String collectionId, Note note);

  void add(String collectionId, Note note, {int index = 0});

  void remove(String collectionId, Note note);

  void replace(String collectionId, Note oldNote, Note newNote);
}
