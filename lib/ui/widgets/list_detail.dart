import 'package:flutter/material.dart';

import 'package:postnote/ui/utils/screen_utils.dart';

class ListDetail extends StatefulWidget {
  final double dividerPosition;
  final Widget list;
  final Widget detail;
  final bool showDetail;

  const ListDetail({
    super.key,
    this.dividerPosition = 290,
    required this.list,
    required this.detail,
    this.showDetail = false,
  });

  @override
  State<ListDetail> createState() => _ListDetailState();
}

class _ListDetailState extends State<ListDetail> {
  static const double _dividerWidth = 8;
  static const double _dividerDefaultThickness = 0;
  static const double _dividerHoverThickness = 3;

  double _dividerPosition = 0;
  double _maxWidth = 0;
  bool _isDividerHovered = false;

  get _listWidth => _dividerPosition;
  get _detailWidth => _maxWidth - _listWidth;

  @override
  void initState() {
    super.initState();
    _dividerPosition = widget.dividerPosition;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_maxWidth != constraints.maxWidth) {
          _maxWidth = constraints.maxWidth;
        }

        final isSmallScreen = ScreenUtils.isSmallScreen(context);
        if (isSmallScreen) {
          _dividerPosition = widget.showDetail ? 0 : _maxWidth;
        } else {
          _dividerPosition = 290;
        }

        return SizedBox(
          width: constraints.maxWidth,
          child: Stack(
            children: [
              Row(
                children: [
                  SizedBox(width: _listWidth, child: widget.list),
                  SizedBox(width: _detailWidth, child: widget.detail),
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
      },
    );
  }
}
