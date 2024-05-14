import 'package:postnote/data/model/note.dart';

class NotesState {
  final List<Note> notes;
  final String topic;

  const NotesState({this.topic = '', this.notes = const []});

  NotesState copyWith({String? topic, List<Note>? notes}) {
    return NotesState(topic: topic ?? this.topic, notes: notes ?? this.notes);
  }
}
