import 'package:flutter/material.dart';

class ExtendableFab extends StatelessWidget {
  final bool isExtended;
  final Widget label;
  final Widget icon;
  final Function() onPressed;

  const ExtendableFab({
    super.key,
    this.isExtended = false,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isExtended
        ? FloatingActionButton.extended(
            onPressed: onPressed,
            label: label,
            icon: icon,
          )
        : FloatingActionButton(
            onPressed: onPressed,
            child: icon,
          );
  }
}
