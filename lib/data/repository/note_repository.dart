import 'package:postnote/data/model/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotesStream(String topic);

  Note? findById(String topic, String id);

  void update(String topic, Note note);

  void add(String topic, Note note, {int index = 0});

  void remove(String topic, Note note);

  void replace(String topic, Note oldNote, Note newNote);
}
