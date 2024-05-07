import 'package:postnote/data/model/note.dart';

class NotesState {
  final List<Note> notes;

  const NotesState({this.notes = const <Note>[]});
}
