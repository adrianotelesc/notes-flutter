import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width > 1000
          ? MediaQuery.of(context).size.width / 2
          : null,
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.all(24),
      child: BlocBuilder<NoteEditorCubit, NoteEditorState>(
        bloc: _cubit,
        builder: (context, state) {
          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
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
            ],
          );
        },
      ),
    );
  }
}
