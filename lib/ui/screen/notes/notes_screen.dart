import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/ui/screen/notes/notes_cubit.dart';
import 'package:notes/ui/screen/notes/notes_ui_state.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotesScreenState();
  }
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesCubit>(
      create: (_) => NotesCubit(),
      child: BlocBuilder<NotesCubit, NotesUiState>(
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
                final item = state.notes[index];
                return Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/note-editing",
                        arguments: item.id,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        item.text,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed("/note-editing"),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
