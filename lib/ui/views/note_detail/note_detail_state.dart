import 'package:postnote/data/models/note.dart';

class NoteDetailsState {
  final String collectionId;
  final Note note;

  NoteDetailsState({this.collectionId = '', required this.note});

  NoteDetailsState copyWith({String? collectionId, Note? note}) {
    return NoteDetailsState(
      collectionId: collectionId ?? this.collectionId,
      note: note ?? this.note,
    );
  }
}
