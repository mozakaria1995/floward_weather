import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static final Color primaryDark = Colors.blue.shade800;
  static final Color primaryLight = Colors.blue.shade200;

  // Fonts
  static const String primaryFont = 'Poppins';

  // Gradients
  static final List<Color> weatherBackgroundGradient = [
    primaryDark,
    primaryLight,
  ];

  // Text themes
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: primaryFont,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: primaryFont,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      fontFamily: primaryFont,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: primaryFont,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: primaryFont,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: primaryFont,
      fontWeight: FontWeight.w300,
    ),
  );

  // Theme data
  static ThemeData themeData = ThemeData(
    fontFamily: primaryFont,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDark,
      brightness: Brightness.light,
    ),
  );
}
