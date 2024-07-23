import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols/material_symbols.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final _keyboardFocusNode = FocusNode();

  late final _cubit = GetIt.I<NoteDetailCubit>(param1: widget.boardId);

  @override
  void initState() {
    super.initState();
    _cubit.initState(noteId: widget.noteId);
    _textEditingController.text = _cubit.state.note.text;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: constraints.minHeight == 0
            ? const BoxConstraints.expand()
            : constraints,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(MaterialSymbols.close),
              onPressed: () => Navigator.maybePop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: PopupMenuButton(
                  tooltip: AppLocalizations.of(context)!.more,
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(MaterialSymbols.delete),
                            const SizedBox.square(dimension: 8),
                            Text(
                              AppLocalizations.of(context)!.delete,
                            )
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.only(
                                  left: 24,
                                  top: 24,
                                  right: 24,
                                  bottom: 8,
                                ),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .confirmNoteDelete,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(),
                                    child: Text(
                                        AppLocalizations.of(context)!.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                      _cubit.deleteNote();
                                      context.pop();
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.delete),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ];
                  },
                ),
              )
            ],
          ),
          body: RawScrollbar(
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
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 24,
                      ),
                      child: KeyboardListener(
                        focusNode: _keyboardFocusNode,
                        onKeyEvent: (event) {
                          if (event is KeyDownEvent &&
                              event.logicalKey == LogicalKeyboardKey.escape) {
                            context.pop();
                          }
                        },
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nota',
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
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
