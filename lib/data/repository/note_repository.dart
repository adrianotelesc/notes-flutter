import 'package:notes/data/model/note.dart';

abstract class NoteRepository {
  List<Note> getNotes();
}
