import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/screen/notes/notes_cubit.dart';
import 'package:postnote/ui/screen/notes/notes_screen_helper.dart';
import 'package:postnote/ui/screen/notes/notes_state.dart';
import 'package:postnote/ui/widget/sticky_note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({
    super.key,
    required this.code,
    this.usePageDetailReplacement = false,
  });

  final String code;
  final bool usePageDetailReplacement;

  @override
  State<StatefulWidget> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _cubit = GetIt.I<NotesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(widget.code);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pageHelper = NotesScreenHelper(
          mediaQueryData: MediaQuery.of(context),
          constraints: constraints,
        );
        return BlocBuilder<NotesCubit, NotesState>(
          bloc: _cubit,
          builder: (context, state) {
            return MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: pageHelper.columnCount,
              ),
              padding: pageHelper.contentPadding,
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];

                return StickyNote(
                  id: note.id,
                  text: note.text,
                  onTap: (noteId) {
                    context.replace('/${widget.code}/$noteId');
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
