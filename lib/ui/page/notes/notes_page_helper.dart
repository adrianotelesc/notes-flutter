import 'dart:math';

import 'package:flutter/material.dart';

class NotesPageHelper {
  final MediaQueryData _mediaQueryData;

  static const double _smallScreenWidthThreshold = 430;
  static const double _tallToolbarHeight = 88.0;
  static const int _minimumColumnCount = 2;
  static const double _columnWidth = 200.0;

  const NotesPageHelper(this._mediaQueryData);

  Size calculateAppBarSize() {
    final screenWidth = _mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold
        ? const Size.fromHeight(kToolbarHeight)
        : const Size.fromHeight(_tallToolbarHeight);
  }

  bool shouldCenterAppBarTitle() {
    final screenWidth = _mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold;
  }

  int calculateColumnCount() {
    final screenWidth = _mediaQueryData.size.width;
    return max(_minimumColumnCount, screenWidth ~/ _columnWidth);
  }

  EdgeInsets calculateContentPadding() {
    final screenWidth = _mediaQueryData.size.width;
    return EdgeInsets.only(
      left: 16,
      top: screenWidth <= _smallScreenWidthThreshold ? 16 : 48,
      right: 16,
      bottom: 120,
    );
  }

  bool shouldExtendFab() {
    final screenWidth = _mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold;
  }

  FloatingActionButtonLocation determineFabLocation() {
    final screenWidth = _mediaQueryData.size.width;
    return screenWidth <= _smallScreenWidthThreshold
        ? FloatingActionButtonLocation.endFloat
        : FloatingActionButtonLocation.startTop;
  }
}
