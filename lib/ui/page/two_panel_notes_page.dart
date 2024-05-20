import 'package:flutter/material.dart';
import 'package:postnote/ui/page/note_details/note_details_page.dart';
import 'package:postnote/ui/page/notes/notes_page.dart';
import 'package:postnote/ui/widget/split_view.dart';

class TwoPanelNotesPage extends StatelessWidget {
  const TwoPanelNotesPage({
    super.key,
    required this.code,
    this.noteId,
  });

  final String code;
  final String? noteId;

  static const double largeScreenWidthThreshold = 800;
  @override
  Widget build(BuildContext context) {
    return largeScreenWidthThreshold <= MediaQuery.of(context).size.width &&
            noteId != null
        ? SplitView(
            left: NotesPage(
              code: code,
              shouldReplace: true,
            ),
            right: NoteDetailsPage(
              code: code,
              noteId: noteId,
            ))
        : NotesPage(
            code: code,
            shouldReplace:
                largeScreenWidthThreshold <= MediaQuery.of(context).size.width,
          );
  }
}
