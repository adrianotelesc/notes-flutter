import 'package:flutter/material.dart';

abstract class PostnoteTheming {
  static const _useMaterial = true;

  static const PopupMenuThemeData _popupMenuTheme = PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  static const _buttonMinimumSize = Size(0, 56);

  static final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(minimumSize: _buttonMinimumSize),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(minimumSize: _buttonMinimumSize),
  );

  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(contentPadding: EdgeInsets.symmetric(vertical: 20));

  static final ThemeData light = ThemeData(
    useMaterial3: _useMaterial,
    brightness: Brightness.light,
    popupMenuTheme: _popupMenuTheme,
    filledButtonTheme: _filledButtonTheme,
    textButtonTheme: _textButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: _useMaterial,
    brightness: Brightness.dark,
    popupMenuTheme: _popupMenuTheme,
    filledButtonTheme: _filledButtonTheme,
    textButtonTheme: _textButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
  );
}
