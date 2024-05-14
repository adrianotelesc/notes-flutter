import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postnote/ui/page/note_editor/note_editor_cubit.dart';
import 'package:postnote/ui/page/note_editor/note_editor_state.dart';

class NoteEditorPage<T> extends Page<T> {
  final String? noteId;
  final String topic;

  const NoteEditorPage({super.key, this.topic = '', this.noteId});

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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 182.0,
              maxHeight: _calculateDialogMaxHeight(context),
              maxWidth: 600,
            ),
            child: _NoteEditor(
              key: super.key,
              topic: topic,
              noteId: noteId,
            ),
          ),
        );
      },
    );
  }

  double _calculateDialogMaxHeight(context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * .75;
  }

  MaterialPageRoute<T> _createPageRoute(BuildContext context) {
    return MaterialPageRoute<T>(
      settings: this,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: _NoteEditor(
            key: super.key,
            topic: topic,
            noteId: noteId,
          ),
        );
      },
    );
  }
}

class _NoteEditor extends StatefulWidget {
  final String? noteId;
  final String topic;

  const _NoteEditor({super.key, this.topic = '', this.noteId});

  @override
  State<StatefulWidget> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<_NoteEditor> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  final _cubit = GetIt.instance.get<NoteEditorCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(topic: widget.topic, noteId: widget.noteId);
    _textEditingController.text = _cubit.state.note.text;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteEditorCubit, NoteEditorState>(
      bloc: _cubit,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: constraints.minHeight == 0
                  ? const BoxConstraints.expand()
                  : constraints,
              child: RawScrollbar(
                shape: const StadiumBorder(),
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  vertical: constraints.minHeight == 0 ? 0 : 32,
                  horizontal: 4,
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final textStyle = Theme.of(context).textTheme.bodyLarge;
                      final height = textStyle?.height ?? 0;
                      final fontSize = textStyle?.fontSize ?? 0;
                      final lineHeight = fontSize * height;
                      final minLines = constraints.minHeight ~/ lineHeight;

                      return SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 4),
                            ),
                            style: textStyle,
                            minLines: minLines > 0 ? minLines : null,
                            controller: _textEditingController,
                            maxLines: null,
                            autofocus: state.note.text.isEmpty,
                            onChanged: (text) => _cubit.updateNote(text),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
