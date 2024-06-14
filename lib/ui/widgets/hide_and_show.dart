import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HideAndShow extends StatefulWidget {
  final Function(Function() show) hide;
  final Widget Function(Function() hide) builder;

  const HideAndShow({
    super.key,
    required this.hide,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() => _HideAndShowState();
}

class _HideAndShowState extends State<HideAndShow> {
  final _hideableKey = GlobalKey<_HideableState>();

  @override
  Widget build(BuildContext context) {
    return _Hideable(
      key: _hideableKey,
      child: Builder(
        builder: (context) => widget.builder(hide),
      ),
    );
  }

  void hide() {
    _toggleHideable(hide: true);

    widget.hide.call(() => _toggleHideable(hide: false));
  }

  void _toggleHideable({required bool hide}) {
    if (_hideableKey.currentState != null) {
      _hideableKey.currentState!
        ..placeholderSize = null
        ..isVisible = !hide;
    }
  }

  @override
  void dispose() {
    if (_hideableKey.currentState?.isVisible == false) {
      SchedulerBinding.instance
          .addPostFrameCallback((duration) => _toggleHideable(hide: false));
    }
    super.dispose();
  }
}

class _Hideable extends StatefulWidget {
  const _Hideable({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<_Hideable> createState() => _HideableState();
}

class _HideableState extends State<_Hideable> {
  Size? get placeholderSize => _placeholderSize;
  Size? _placeholderSize;
  set placeholderSize(Size? value) {
    if (_placeholderSize == value) {
      return;
    }
    setState(() {
      _placeholderSize = value;
    });
  }

  bool get isVisible => _visible;
  bool _visible = true;
  set isVisible(bool value) {
    if (_visible == value) {
      return;
    }
    setState(() {
      _visible = value;
    });
  }

  bool get isInTree => _placeholderSize == null;

  @override
  Widget build(BuildContext context) {
    if (_placeholderSize != null) {
      return SizedBox.fromSize(size: _placeholderSize);
    }
    return Visibility(
      visible: _visible,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      child: widget.child,
    );
  }
}
