import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/ui/page/notes/notes_cubit.dart';
import 'package:notes/ui/page/notes/notes_state.dart';
import 'package:notes/ui/widget/sticky_note.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesCubit>(
      create: (_) => NotesCubit(),
      child: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Notes")),
            body: MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              padding: const EdgeInsets.all(12),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return StickyNote(
                  id: note.id,
                  text: note.text,
                  onClick: (id) {
                    Navigator.of(context).pushNamed(
                      "/note-editor",
                      arguments: id,
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed("/note-editor"),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
