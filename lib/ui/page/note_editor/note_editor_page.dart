import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postnote/data/repository/note_repository.dart';
import 'package:postnote/main.dart';
import 'package:postnote/ui/page/note_editor/note_editor_cubit.dart';
import 'package:postnote/ui/page/note_editor/note_editor_state.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<StatefulWidget> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
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
    return BlocProvider<NoteEditorCubit>(
      create: (_) => NoteEditorCubit(
        noteId: ModalRoute.of(context)?.settings.arguments as String?,
        noteRepo: getIt.get<NoteRepository>(),
      ),
      child: BlocBuilder<NoteEditorCubit, NoteEditorState>(
        builder: (context, state) {
          _textEditingController.text = state.note.text;
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
                autofocus: state.note.text.isEmpty,
                onChanged: (text) =>
                    context.read<NoteEditorCubit>().updateNote(text),
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
