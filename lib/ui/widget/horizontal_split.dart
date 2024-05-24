import 'package:flutter/material.dart';

class HorizontalSplit extends StatefulWidget {
  final double dividerPosition;
  final Widget left;
  final Widget right;

  const HorizontalSplit({
    super.key,
    this.dividerPosition = 290,
    required this.left,
    required this.right,
  });

  @override
  State<HorizontalSplit> createState() => _HorizontalSplitState();
}

class _HorizontalSplitState extends State<HorizontalSplit> {
  static const _dividerWidth = 8.0;
  static const _dividerDefaultThickness = 0.0;
  static const _dividerHoverThickness = 3.0;

  var _dividerPosition = 0.0;
  var _maxWidth = 0.0;
  var _isDividerHovered = false;

  get _leftWidth => _dividerPosition;
  get _rightWidth => _maxWidth - _leftWidth;

  @override
  void initState() {
    super.initState();
    _dividerPosition = widget.dividerPosition;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      if (_maxWidth != constraints.maxWidth) {
        _maxWidth = constraints.maxWidth;
      }

      return SizedBox(
        width: constraints.maxWidth,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(width: _leftWidth, child: widget.left),
                SizedBox(width: _rightWidth, child: widget.right),
              ],
            ),
            Positioned(
              height: constraints.maxHeight,
              left: _dividerPosition - _dividerWidth / 2,
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                onHover: (event) {
                  setState(() {
                    _isDividerHovered = true;
                  });
                },
                onExit: (event) {
                  setState(() {
                    _isDividerHovered = false;
                  });
                },
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: VerticalDivider(
                    width: _dividerWidth,
                    thickness: _isDividerHovered
                        ? _dividerHoverThickness
                        : _dividerDefaultThickness,
                    color: _isDividerHovered
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).dividerColor,
                  ),
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _isDividerHovered = true;
                      _dividerPosition += details.delta.dx;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
