import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols/material_symbols.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:postnote/ui/pages/note_list/note_list_cubit.dart';
import 'package:postnote/ui/utils/screen_utils.dart';
import 'package:postnote/ui/pages/note_list/note_list_state.dart';
import 'package:postnote/ui/widgets/extendable_fab.dart';
import 'package:postnote/ui/widgets/note_widget.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({
    super.key,
    required this.boardId,
  });

  final String boardId;

  @override
  State<StatefulWidget> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  static const int _minimumColumnCount = 2;
  static const double _columnWidth = 200;

  late final _cubit = GetIt.I<NoteListCubit>(param1: widget.boardId);

  @override
  void initState() {
    super.initState();
    _cubit.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = ScreenUtils.isSmallScreen(context);
        final contentWidth = constraints.maxWidth;
        final columnCount = constraints.maxWidth <= _columnWidth
            ? 1
            : max(_minimumColumnCount, contentWidth ~/ _columnWidth);

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(MaterialSymbols.back),
              onPressed: () => Navigator.maybePop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Minhas notas',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  widget.boardId,
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
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
                            const Icon(MaterialSymbols.content_copy),
                            const SizedBox.square(dimension: 8),
                            Text(
                              AppLocalizations.of(context)!.copyCode,
                            )
                          ],
                        ),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: widget.boardId))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.codeCopied,
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ];
                  },
                ),
              )
            ],
          ),
          body: BlocBuilder<NoteListCubit, NoteListState>(
            bloc: _cubit,
            builder: (context, state) {
              return MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                ),
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 120,
                ),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];

                  return NoteWidget(
                    text: note.text,
                    onTap: () async =>
                        await context.push('/${widget.boardId}/${note.id}'),
                  );
                },
              );
            },
          ),
          floatingActionButton: ExtendableFab(
            isExtended: !isSmallScreen,
            onPressed: () {
              context.push('/${widget.boardId}/new');
            },
            icon: const Icon(MaterialSymbols.note_stack_add),
            label: Text(AppLocalizations.of(context)!.newNote),
          ),
        );
      },
    );
  }
}
