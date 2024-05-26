import 'package:flutter/material.dart';

import 'package:postnote/ui/screen/note_details/note_details_screen.dart';
import 'package:postnote/ui/screen/notes/notes_screen.dart';
import 'package:postnote/ui/widget/horizontal_split.dart';

class AdaptiveNotesScreen extends StatelessWidget {
  const AdaptiveNotesScreen({
    super.key,
    required this.code,
    this.noteId,
  });

  final String code;
  final String? noteId;

  static const double largeScreenWidthThreshold = 800;

  @override
  Widget build(BuildContext context) {
    return largeScreenWidthThreshold <= MediaQuery.of(context).size.width
        ? HorizontalSplit(
            left: NotesScreen(
              code: code,
              usePageReplacement: true,
            ),
            right: NoteDetailsScreen(
              code: code,
              noteId: noteId,
            ),
          )
        : noteId == null
            ? NotesScreen(code: code)
            : NoteDetailsScreen(
                code: code,
                noteId: noteId,
                automaticallyImplyLeading: true,
              );
  }
}
