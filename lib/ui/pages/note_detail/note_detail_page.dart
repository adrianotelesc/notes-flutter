import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols/material_symbols.dart';

import 'package:postnote/ui/pages/note_detail/note_detail_cubit.dart';

class NoteDetailPage extends StatefulWidget {
  final String? noteId;
  final String boardId;

  const NoteDetailPage({
    super.key,
    this.boardId = '',
    this.noteId,
  });

  @override
  State<StatefulWidget> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final _scrollController = ScrollController();
  final _textEditingController = TextEditingController();

  late final _cubit = GetIt.I<NoteDetailCubit>(param1: widget.boardId);

  @override
  void initState() {
    super.initState();
    _cubit.initState(noteId: widget.noteId);
    _textEditingController.text = _cubit.state.note.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(MaterialSymbols.close),
        ),
      ),
      body: LayoutBuilder(
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
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                          autofocus: _textEditingController.text.isEmpty,
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
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
