import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/ui/page/note_editor/note_editor_cubit.dart';
import 'package:postnote/ui/page/note_editor/note_editor_state.dart';

class NoteEditorPage extends StatefulWidget {
  final String? noteId;

  const NoteEditorPage({super.key, this.noteId});

  @override
  State<StatefulWidget> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late TextEditingController _textEditingController;

  final _cubit = GetIt.instance.get<NoteEditorCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(noteId: widget.noteId);
    _textEditingController =
        TextEditingController(text: _cubit.state.note.text);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteEditorCubit, NoteEditorState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/notes');
                }
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Expanded(
              child: TextField(
                expands: true,
                clipBehavior: Clip.none,
                scrollPadding: const EdgeInsets.all(0),
                controller: _textEditingController,
                maxLines: null,
                autofocus: state.note.text.isEmpty,
                onChanged: (text) => _cubit.updateNote(text),
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
