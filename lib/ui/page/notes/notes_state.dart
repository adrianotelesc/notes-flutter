import 'package:notes/data/model/note.dart';

class NotesState {
  final List<Note> notes;

  const NotesState({this.notes = const <Note>[]});
}
