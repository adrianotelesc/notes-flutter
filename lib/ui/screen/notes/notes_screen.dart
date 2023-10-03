import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/ui/screen/notes/notes_cubit.dart';
import 'package:notes/ui/screen/notes/notes_ui_state.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesUiState>(
      builder: (context, state) {
        return Scaffold(
          body: ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              return Text(
                state.notes[index].text,
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<NotesCubit>().addNote();
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
