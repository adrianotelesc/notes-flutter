import 'package:flutter/material.dart';

import 'package:postnote/ui/utils/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteWidget extends StatelessWidget {
  static const _defaultMaxLines = 10;

  final String text;
  final Function() onTap;

  NoteWidget({
    super.key,
    required this.text,
    Function()? onTap,
  }) : onTap = onTap ?? (() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text.isEmpty
                ? AppLocalizations.of(context)!.emptyNote
                : text.truncateWithEllipsis(maxLines: _defaultMaxLines),
            maxLines: _defaultMaxLines,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: text.isEmpty
                  ? theme.colorScheme.outline
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
