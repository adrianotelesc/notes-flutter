import 'package:flutter/material.dart';

class SplitView extends StatefulWidget {
  final Widget left;
  final Widget right;
  final double ratio;

  const SplitView({
    super.key,
    required this.left,
    required this.right,
    this.ratio = 0.5,
  })  : assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  final _dividerWidth = 16.0;

  var _ratio = 0.0;
  var _maxWidth = 0.0;

  get _width1 => _ratio * _maxWidth;

  get _width2 => (1 - _ratio) * _maxWidth;

  @override
  void initState() {
    super.initState();
    _ratio = widget.ratio;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      assert(_ratio <= 1);
      assert(_ratio >= 0);
      if (_maxWidth != constraints.maxWidth) {
        _maxWidth = constraints.maxWidth - _dividerWidth;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: _width1,
              child: widget.left,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                color: Colors.black,
                width: _dividerWidth,
                height: constraints.maxHeight,
                child: const RotationTransition(
                  turns: AlwaysStoppedAnimation(0.25),
                  child: Icon(Icons.drag_handle),
                ),
              ),
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  _ratio += details.delta.dx / _maxWidth;
                  if (_ratio > 1) {
                    _ratio = 1;
                  } else if (_ratio < 0.0) {
                    _ratio = 0.0;
                  }
                });
              },
            ),
            SizedBox(
              width: _width2,
              child: widget.right,
            ),
          ],
        ),
      );
    });
  }
}
