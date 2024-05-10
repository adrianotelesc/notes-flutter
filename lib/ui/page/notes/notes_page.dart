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
  const NotesPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _cubit = GetIt.instance.get<NotesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Postnote')),
          body: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: max(2, MediaQuery.of(context).size.width ~/ 200),
            ),
            padding: const EdgeInsets.all(12),
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return StickyNote(
                  id: note.id,
                  text: note.text,
                  onTap: (id) => context.push('/notes/$id'));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/notes/new'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
