import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:postnote/ui/views/note_detail/note_detail_cubit.dart';
import 'package:postnote/ui/views/note_detail/note_detail_state.dart';

class NoteDetailView extends StatefulWidget {
  final String? noteId;
  final String collectionId;

  const NoteDetailView({
    super.key,
    this.collectionId = '',
    this.noteId,
  });

  @override
  State<StatefulWidget> createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  final _cubit = GetIt.I<NoteDetailsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(collectionId: widget.collectionId, noteId: widget.noteId);
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
    return BlocBuilder<NoteDetailsCubit, NoteDetailsState>(
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
