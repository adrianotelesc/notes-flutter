import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';
import 'package:postnote/ui/page/notes/notes_state.dart';
import 'package:postnote/ui/widget/extendable_fab.dart';
import 'package:postnote/ui/widget/sticky_note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
    required this.code,
  });

  final String code;

  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  static const double _smallScreenWidthThreshold = 430;
  static const double _tallToolbarHeight = 88.0;
  static const int _minimumColumnCount = 2;
  static const double _columnWidth = 200.0;

  final _cubit = GetIt.instance.get<NotesCubit>();

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
    final mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<NotesCubit, NotesState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: _calculateAppBarSize(mediaQueryData),
            child: AppBar(
              title: Text(widget.code),
              centerTitle: _shouldCenterAppBarTitle(mediaQueryData),
            ),
          ),
          body: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateColumnCount(mediaQueryData),
            ),
            padding: _calculateContentPadding(mediaQueryData),
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return StickyNote(
                id: note.id,
                text: note.text,
                onTap: (noteId) => context.push('/${widget.code}/$noteId'),
              );
            },
          ),
          floatingActionButton: ExtendableFab(
            isExtended: _shouldExtendFab(mediaQueryData),
            onPressed: () => context.push('/${widget.code}/new'),
          ),
          floatingActionButtonLocation: _determineFabLocation(mediaQueryData),
        );
      },
    );
  }

  Size _calculateAppBarSize(final MediaQueryData mediaQueryData) {
    final screenWidth = mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold
        ? const Size.fromHeight(kToolbarHeight)
        : const Size.fromHeight(_tallToolbarHeight);
  }

  bool _shouldCenterAppBarTitle(final MediaQueryData mediaQueryData) {
    final screenWidth = mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold;
  }

  int _calculateColumnCount(final MediaQueryData mediaQueryData) {
    final screenWidth = mediaQueryData.size.width;
    return max(_minimumColumnCount, screenWidth ~/ _columnWidth);
  }

  EdgeInsets _calculateContentPadding(final MediaQueryData mediaQueryData) {
    final screenWidth = mediaQueryData.size.width;
    return EdgeInsets.only(
      left: 16,
      top: screenWidth <= _smallScreenWidthThreshold ? 16 : 48,
      right: 16,
      bottom: 120,
    );
  }

  bool _shouldExtendFab(final MediaQueryData mediaQueryData) {
    final screenWidth = mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold;
  }

  FloatingActionButtonLocation _determineFabLocation(
    final MediaQueryData mediaQueryData,
  ) {
    final screenWidth = mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold
        ? FloatingActionButtonLocation.endFloat
        : FloatingActionButtonLocation.startTop;
  }
}
