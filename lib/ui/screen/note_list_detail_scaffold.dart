import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:postnote/ui/screen/notes/notes_screen_helper.dart';
import 'package:postnote/ui/widget/list_detail.dart';
import 'package:postnote/ui/widget/extendable_fab.dart';

class NoteListDetailScaffold extends StatefulWidget {
  final String code;
  final String? noteId;
  final Widget list;
  final Widget detail;

  const NoteListDetailScaffold({
    super.key,
    required this.code,
    this.noteId,
    required this.list,
    required this.detail,
  });

  @override
  State<StatefulWidget> createState() => _NoteListDetailScaffoldState();
}

class _NoteListDetailScaffoldState extends State<NoteListDetailScaffold> {
  static const double _tallToolbarHeight = 88.0;

  String? _noteId;

  get _showDetail => _noteId != null;

  @override
  void didUpdateWidget(covariant NoteListDetailScaffold oldWidget) {
    _noteId = widget.noteId;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pageHelper = NotesScreenHelper(
          mediaQueryData: MediaQuery.of(context),
          constraints: constraints,
        );

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: pageHelper.isSmallScreen
                ? const Size.fromHeight(kToolbarHeight)
                : const Size.fromHeight(_tallToolbarHeight),
            child: pageHelper.isSmallScreen && _showDetail
                ? AppBar(
                    leading: BackButton(
                      onPressed: () {
                        setState(() {
                          _noteId = null;
                        });
                      },
                    ),
                  )
                : AppBar(
                    title: Text(widget.code),
                    centerTitle: false,
                    leading: BackButton(
                      onPressed: () {
                        context.go('/');
                      },
                    ),
                  ),
          ),
          body: ListDetail(
            showDetail: _showDetail,
            list: widget.list,
            detail: widget.detail,
          ),
          floatingActionButton: !pageHelper.isSmallScreen || !_showDetail
              ? ExtendableFab(
                  isExtended: !pageHelper.isSmallScreen,
                  onPressed: () {
                    context.replace('/${widget.code}/new');
                  },
                  icon: const Icon(Icons.add),
                  label: Text(AppLocalizations.of(context)!.newNote),
                )
              : null,
          floatingActionButtonLocation: pageHelper.isSmallScreen
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.startTop,
        );
      },
    );
  }
}
