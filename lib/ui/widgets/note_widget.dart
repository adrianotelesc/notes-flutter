import 'package:flutter/material.dart';

import 'package:postnote/ui/utils/string_extension.dart';

class NoteWidget extends StatelessWidget {
  static const _maxLinex = 10;

  final String id;
  final String text;
  final Function(String)? onTap;

  const NoteWidget({
    super.key,
    required this.id,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap != null ? () => onTap?.call(id) : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text.truncateWithEllipsis(maxLines: _maxLinex),
            maxLines: _maxLinex,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
