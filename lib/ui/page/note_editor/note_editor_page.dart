import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postnote/ui/page/note_editor/note_editor_cubit.dart';
import 'package:postnote/ui/page/note_editor/note_editor_state.dart';

class NoteEditorPage<T> extends Page<T> {
  final String? noteId;

  const NoteEditorPage({super.key, this.noteId});

  @override
  Route<T> createRoute(BuildContext context) {
    final shouldCreateDialogRoute = _shouldCreateDialogRoute(context);
    if (shouldCreateDialogRoute) {
      return _createDialogRoute(context);
    } else {
      return _createPageRoute(context);
    }
  }

  bool _shouldCreateDialogRoute(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return screenWidth > 430 && screenHeight > 540;
  }

  DialogRoute<T> _createDialogRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.fromLTRB(24, 160, 24, 24),
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 600,
            height: 182,
            child: _NoteEditor(
              key: super.key,
              noteId: noteId,
            ),
          ),
        );
      },
    );
  }

  MaterialPageRoute<T> _createPageRoute(BuildContext context) {
    return MaterialPageRoute<T>(
      settings: this,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: _NoteEditor(
            key: super.key,
            noteId: noteId,
          ),
        );
      },
    );
  }
}

class _NoteEditor extends StatefulWidget {
  final String? noteId;

  const _NoteEditor({super.key, this.noteId});

  @override
  State<StatefulWidget> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<_NoteEditor> {
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
        return Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
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
          ],
        );
      },
    );
  }
}
