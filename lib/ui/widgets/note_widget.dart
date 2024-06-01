import 'package:flutter/material.dart';

import 'package:postnote/ui/utils/string_extension.dart';

class NoteWidget extends StatelessWidget {
  static const _defaultMaxLines = 10;

  final String text;
  final Function()? onTap;

  const NoteWidget({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text.truncateWithEllipsis(maxLines: _defaultMaxLines),
            maxLines: _defaultMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
