import 'package:flutter/material.dart';

class ExtendableFab extends StatelessWidget {
  final bool isExtended;
  final Function() onPressed;

  const ExtendableFab({
    super.key,
    this.isExtended = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isExtended
        ? FloatingActionButton(
            onPressed: onPressed,
            child: const Icon(Icons.add),
          )
        : FloatingActionButton.extended(
            onPressed: onPressed,
            label: const Text('New note'),
            icon: const Icon(Icons.add),
          );
  }
}
