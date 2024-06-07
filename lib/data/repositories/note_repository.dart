import 'package:postnote/data/models/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotesStream(String boardId);

  void onListen();

  Note? findById(String boardId, String id);

  void update(String boardId, Note note);

  void add(String boardId, Note note, {int index = 0});

  void remove(String boardId, Note note);

  void replace(String boardId, Note oldNote, Note newNote);
}
