import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:postnote/ui/views/note_list/note_list_cubit.dart';
import 'package:postnote/ui/utils/screen_utils.dart';
import 'package:postnote/ui/views/note_list/note_list_state.dart';
import 'package:postnote/ui/widgets/note_widget.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({
    super.key,
    required this.collectionId,
  });

  final String collectionId;

  @override
  State<StatefulWidget> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  static const int _minimumColumnCount = 2;
  static const double _columnWidth = 200;

  final _cubit = GetIt.I<NotesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(widget.collectionId);
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
        final isSmallScreen = ScreenUtils.isSmallScreen(context);
        final contentWidth = constraints.maxWidth;
        final columnCount = constraints.maxWidth <= _columnWidth
            ? 1
            : max(_minimumColumnCount, contentWidth ~/ _columnWidth);

        return BlocBuilder<NotesCubit, NotesState>(
          bloc: _cubit,
          builder: (context, state) {
            return MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
              ),
              padding: EdgeInsets.only(
                left: 16,
                top: isSmallScreen ? 16 : 48,
                right: 16,
                bottom: 120,
              ),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];

                return NoteWidget(
                  text: note.text,
                  onTap: () {
                    context.replace('/${widget.collectionId}/${note.id}');
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
