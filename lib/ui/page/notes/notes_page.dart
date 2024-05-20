import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:postnote/ui/page/notes/notes_cubit.dart';
import 'package:postnote/ui/page/notes/notes_page_helper.dart';
import 'package:postnote/ui/page/notes/notes_state.dart';
import 'package:postnote/ui/widget/extendable_fab.dart';
import 'package:postnote/ui/widget/sticky_note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    super.key,
    required this.code,
    this.shouldReplace = false,
  });

  final String code;
  final bool shouldReplace;

  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _cubit = GetIt.instance.get<NotesCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.initState(widget.code);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageHelper = NotesPageHelper(MediaQuery.of(context));
    return BlocBuilder<NotesCubit, NotesState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: pageHelper.appBarSize,
            child: AppBar(
              title: Text(widget.code),
              centerTitle: pageHelper.isSmallScreen,
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return MasonryGridView.builder(
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: pageHelper.getColumnCount(constraints),
                ),
                padding: pageHelper.contentPadding,
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return StickyNote(
                    id: note.id,
                    text: note.text,
                    onTap: (noteId) => widget.shouldReplace
                        ? context.replace('/${widget.code}/$noteId')
                        : context.push('/${widget.code}/$noteId'),
                  );
                },
              );
            },
          ),
          floatingActionButton: ExtendableFab(
            isExtended: pageHelper.isSmallScreen,
            onPressed: () => widget.shouldReplace
                ? context.replace('/${widget.code}/new')
                : context.push('/${widget.code}/new'),
          ),
          floatingActionButtonLocation: pageHelper.fabLocation,
        );
      },
    );
  }
}
