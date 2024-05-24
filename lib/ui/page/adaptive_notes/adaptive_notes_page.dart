import 'package:flutter/material.dart';
import 'package:postnote/ui/page/note_details/note_details_page.dart';
import 'package:postnote/ui/page/notes/notes_page.dart';
import 'package:postnote/ui/widget/horizontal_split.dart';

class AdaptiveNotesPage extends StatelessWidget {
  const AdaptiveNotesPage({
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
            ratio: .2,
            left: NotesPage(
              code: code,
              usePageReplacement: true,
            ),
            right: NoteDetailsPage(
              code: code,
              noteId: noteId,
            ),
          )
        : noteId == null
            ? NotesPage(code: code)
            : NoteDetailsPage(
                code: code,
                noteId: noteId,
                automaticallyImplyLeading: true,
              );
  }
}
