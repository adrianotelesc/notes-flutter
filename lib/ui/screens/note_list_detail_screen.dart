import 'package:flutter/material.dart';

import 'package:postnote/ui/widgets/list_detail.dart';

class NoteListDetailScreen extends StatefulWidget {
  final String collectionId;
  final String? noteId;
  final Widget list;
  final Widget detail;

  const NoteListDetailScreen({
    super.key,
    required this.collectionId,
    this.noteId,
    required this.list,
    required this.detail,
  });

  @override
  State<StatefulWidget> createState() => _NoteListDetailScreenState();
}

class _NoteListDetailScreenState extends State<NoteListDetailScreen> {
  String? _noteId;

  get _showDetail => _noteId != null;

  @override
  void didUpdateWidget(covariant NoteListDetailScreen oldWidget) {
    _noteId = widget.noteId;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListDetail(
      showDetail: _showDetail,
      list: widget.list,
      detail: widget.detail,
    );
  }
}
