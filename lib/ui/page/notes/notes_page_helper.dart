import 'dart:math';

import 'package:flutter/material.dart';

class NotesPageHelper {
  final MediaQueryData mediaQueryData;
  final BoxConstraints constraints;

  static const double _smallScreenDimensionThreshold = 430;
  static const double _tallToolbarHeight = 88.0;
  static const int _minimumColumnCount = 2;
  static const double _columnWidth = 200.0;

  const NotesPageHelper({
    required this.mediaQueryData,
    required this.constraints,
  });

  bool get isSmallScreen {
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    return screenWidth <= _smallScreenDimensionThreshold ||
        screenHeight <= _smallScreenDimensionThreshold;
  }

  Size get appBarSize {
    return isSmallScreen
        ? const Size.fromHeight(kToolbarHeight)
        : const Size.fromHeight(_tallToolbarHeight);
  }

  int get columnCount {
    final contentWidth = constraints.maxWidth;
    if (contentWidth <= _columnWidth) return 1;
    return max(_minimumColumnCount, contentWidth ~/ _columnWidth);
  }

  EdgeInsets get contentPadding {
    return EdgeInsets.only(
      left: 16,
      top: isSmallScreen ? 16 : 48,
      right: 16,
      bottom: 120,
    );
  }

  FloatingActionButtonLocation get fabLocation {
    return isSmallScreen
        ? FloatingActionButtonLocation.endFloat
        : FloatingActionButtonLocation.startTop;
  }
}
