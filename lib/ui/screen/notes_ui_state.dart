import 'package:notes/data/model/note.dart';

class NotesUiState {
  final List<Note> notes;

  const NotesUiState({this.notes = const <Note>[]});
}
