import 'package:flutter/material.dart';

class StickyNote extends StatelessWidget {
  final String id;
  final String text;
  final Function(String)? onTap;

  const StickyNote({
    super.key,
    required this.id,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        onTap: () {
          onTap?.call(id);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
