import 'package:flutter/material.dart';

abstract class ScreenUtils {
  static const double _smallScreenDimensionThreshold = 430;

  static bool isSmallScreen(MediaQueryData mediaQueryData) {
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    return screenWidth <= _smallScreenDimensionThreshold ||
        screenHeight <= _smallScreenDimensionThreshold;
  }
}
