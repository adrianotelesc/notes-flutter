import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  bool _showFab = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesUiState>(
      builder: (context, state) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text("Notes"),
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                ),
              ];
            },
            body: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                setState(() {
                  if (direction == ScrollDirection.reverse) {
                    _showFab = false;
                  } else if (direction == ScrollDirection.forward) {
                    _showFab = true;
                  }
                });
                return true;
              },
              child: MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                padding: const EdgeInsets.all(12),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.notes[index].text,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButton: AnimatedScale(
            duration: const Duration(milliseconds: 120),
            scale: _showFab ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () {
                context.read<NotesCubit>().addNote();
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
