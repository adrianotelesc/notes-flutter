import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:postnote/ui/utils/screen_helper.dart';
import 'package:postnote/ui/widgets/list_detail.dart';
import 'package:postnote/ui/widgets/extendable_fab.dart';

class NoteListDetailScreen extends StatefulWidget {
  final String code;
  final String? noteId;
  final Widget list;
  final Widget detail;

  const NoteListDetailScreen({
    super.key,
    required this.code,
    this.noteId,
    required this.list,
    required this.detail,
  });

  @override
  State<StatefulWidget> createState() => _NoteListDetailScreenState();
}

class _NoteListDetailScreenState extends State<NoteListDetailScreen> {
  static const double _tallToolbarHeight = 88.0;

  String? _noteId;

  get _showDetail => _noteId != null;

  @override
  void didUpdateWidget(covariant NoteListDetailScreen oldWidget) {
    _noteId = widget.noteId;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = ScreenUtils.isSmallScreen(MediaQuery.of(context));

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: isSmallScreen
                ? const Size.fromHeight(kToolbarHeight)
                : const Size.fromHeight(_tallToolbarHeight),
            child: isSmallScreen && _showDetail
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
          floatingActionButton: !isSmallScreen || !_showDetail
              ? ExtendableFab(
                  isExtended: !isSmallScreen,
                  onPressed: () {
                    context.replace('/${widget.code}/new');
                  },
                  icon: const Icon(Icons.add),
                  label: Text(AppLocalizations.of(context)!.newNote),
                )
              : null,
          floatingActionButtonLocation: isSmallScreen
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.startTop,
        );
      },
    );
  }
}
