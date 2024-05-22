import 'package:flutter/material.dart';

class HorizontalSplit extends StatefulWidget {
  final double ratio;

  final Widget left;

  final Widget right;

  const HorizontalSplit({
    super.key,
    this.ratio = 0.5,
    required this.left,
    required this.right,
  })  : assert(ratio >= 0),
        assert(ratio <= 1);

  @override
  State<HorizontalSplit> createState() => _HorizontalSplitState();
}

class _HorizontalSplitState extends State<HorizontalSplit> {
  static const _dividerWidth = 8.0;

  var _ratio = 0.0;
  var _maxWidth = 0.0;

  var _dividerOnHover = false;

  get _leftWidth => _ratio * _maxWidth;

  get _rightWidth => (1 - _ratio) * _maxWidth;

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
              width: _leftWidth,
              child: widget.left,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              onHover: (event) {
                setState(() {
                  _dividerOnHover = true;
                });
              },
              onExit: (event) {
                setState(() {
                  _dividerOnHover = false;
                });
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: _dividerWidth,
                  height: constraints.maxHeight,
                  child: VerticalDivider(
                    thickness: _dividerOnHover ? 3 : 1,
                    color: _dividerOnHover
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).dividerColor,
                  ),
                ),
                onPanUpdate: (DragUpdateDetails details) {
                  _dividerOnHover = true;
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
            ),
            SizedBox(
              width: _rightWidth,
              child: widget.right,
            ),
          ],
        ),
      );
    });
  }
}
