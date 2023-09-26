import 'package:notes/data/model/note.dart';
import 'package:notes/data/repository/note_repository.dart';

class NoteRepositoryImpl extends NoteRepository {
  @override
  List<Note> getNotes() {
    return List.generate(5, (index) {
      return Note(text: "This is note ${index + 1}");
    });
  }
}
