import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/data/repository/note_repository_impl.dart';
import 'package:notes/ui/screen/note_editing/note_editing_cubit.dart';
import 'package:notes/ui/screen/note_editing/note_editing_ui_state.dart';

class NoteEditingScreen extends StatefulWidget {
  const NoteEditingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NoteEditingScreenState();
}

class _NoteEditingScreenState extends State<NoteEditingScreen> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteEditingCubit>(
      create: (_) => NoteEditingCubit(noteRepo: NoteRepositoryImpl()),
      child: BlocBuilder<NoteEditingCubit, NoteEditingUiState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: TextField(
                clipBehavior: Clip.none,
                scrollPadding: const EdgeInsets.all(0),
                controller: _textEditingController,
                maxLines: null,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
