import 'package:flutter/material.dart';

class AppStyles {
  // Spacing
  static const double smallSpace = 8.0;
  static const double mediumSpace = 10.0;
  static const double largeSpace = 16.0;
  static const double extraLargeSpace = 40.0;

  // Icon sizes
  static const double smallIconSize = 24.0;
  static const double largeIconSize = 60.0;
  static const double weatherIconSize = 70.0;

  // Text sizes
  static const double smallTextSize = 14.0;
  static const double mediumTextSize = 16.0;
  static const double largeTextSize = 22.0;
  static const double extraLargeTextSize = 32.0;
  static const double temperatureTextSize = 80.0;

  // Border radius
  static const double cardBorderRadius = 20.0;

  // Padding
  static const EdgeInsets cardPadding = EdgeInsets.all(15.0);
  static const EdgeInsets cardMargin = EdgeInsets.symmetric(horizontal: 20.0);

  // Colors
  static const Color errorColor = Colors.red;
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Colors.white70;

  // Text styles
  static const TextStyle cityNameStyle = TextStyle(
    fontSize: extraLargeTextSize,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle dateStyle = TextStyle(
    fontSize: mediumTextSize,
    color: secondaryTextColor,
  );

  static const TextStyle conditionStyle = TextStyle(
    fontSize: largeTextSize,
    color: textColor,
  );

  static const TextStyle temperatureStyle = TextStyle(
    fontSize: temperatureTextSize,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle infoTitleStyle = TextStyle(
    color: secondaryTextColor,
    fontSize: smallTextSize,
  );

  static const TextStyle infoValueStyle = TextStyle(
    color: textColor,
    fontSize: mediumTextSize,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle errorMessageStyle = TextStyle(
    fontSize: mediumTextSize,
  );
}
