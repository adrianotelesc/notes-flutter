import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';
import 'package:postnote/ui/page/notes/notes_state.dart';
import 'package:postnote/ui/widget/sticky_note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key, required this.topic});

  final String topic;

  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _cubit = GetIt.instance.get<NotesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(widget.topic);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: appBarSize(context), // here the desired height
            child: AppBar(
              title: Text(widget.topic),
              centerTitle: shouldCenterTitle(context),
            ),
          ),
          body: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateMaxColumnCount(context),
            ),
            padding: contentPadding(context),
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return StickyNote(
                  id: note.id,
                  text: note.text,
                  onTap: (id) => context.push('/${widget.topic}/$id'));
            },
          ),
          floatingActionButtonLocation: floaatingActionButtonLocation(context),
          floatingActionButton: floaatingActionButton(
              context, () => context.push('/${widget.topic}/new')),
        );
      },
    );
  }

  Size appBarSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth <= 430
        ? const Size.fromHeight(kToolbarHeight)
        : const Size.fromHeight(88);
  }

  EdgeInsets contentPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return EdgeInsets.fromLTRB(16, screenWidth <= 430 ? 16 : 48, 16, 120);
  }

  Widget floaatingActionButton(BuildContext context, Function() onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 430) {
      return FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      );
    }
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text('New note'),
      icon: const Icon(Icons.add),
    );
  }

  FloatingActionButtonLocation floaatingActionButtonLocation(
      BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 430) {
      return FloatingActionButtonLocation.endFloat;
    }
    return FloatingActionButtonLocation.startTop;
  }

  bool shouldCenterTitle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth <= 430;
  }

  int _calculateMaxColumnCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return max(2, screenWidth ~/ 200);
  }
}
