import 'package:notes/data/model/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> getNotes();

  void addNote({required String text});
}
