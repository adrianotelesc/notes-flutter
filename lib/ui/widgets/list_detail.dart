import 'package:flutter/material.dart';

import 'package:postnote/ui/utils/screen_utils.dart';

class ListDetail extends StatefulWidget {
  final double initialDividerPosition;
  final Widget list;
  final Widget detail;
  final bool showDetail;

  const ListDetail({
    super.key,
    this.initialDividerPosition = 360,
    required this.list,
    required this.detail,
    this.showDetail = false,
  });

  @override
  State<ListDetail> createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail>
    with SingleTickerProviderStateMixin {
  static const double _dividerWidth = 8;
  static const double _dividerDefaultThickness = 0;
  static const double _dividerHoverThickness = 3;

  double _dividerPosition = 0;
  double _maxWidth = 0;
  bool _isDividerHovered = false;

  get _listWidth => _dividerPosition;
  get _detailWidth => _maxWidth - _listWidth;

  final _animationDuration = const Duration(milliseconds: 200);
  late final AnimationController _animationController = AnimationController(
    duration: _animationDuration,
    reverseDuration: _animationDuration,
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();
    _dividerPosition = widget.initialDividerPosition;
  }

  @override
  void didUpdateWidget(covariant ListDetail oldWidget) {
    if (widget.showDetail) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_maxWidth != constraints.maxWidth) {
          _maxWidth = constraints.maxWidth;
        }

        return SizedBox(
          width: constraints.maxWidth,
          child: Stack(
            children: [
              if (ScreenUtils.isSmallScreen(context)) ...[
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: widget.list,
                ),
                SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: widget.detail,
                  ),
                ),
              ] else ...[
                Row(
                  children: [
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: _listWidth,
                      child: widget.list,
                    ),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: _detailWidth,
                      child: widget.detail,
                    ),
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
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
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
            ],
          ),
        );
      },
    );
  }
}
