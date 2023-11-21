import 'package:notes/data/model/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotes();

  bool add({required Note note});

  bool update({required Note note});

  Note? findBy({required String id});

  bool delete({required Note note});

  bool replace({required Note oldNote, required Note newNote});
}
