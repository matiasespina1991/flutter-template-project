import 'package:flutter/material.dart';

class TemplateTheme {
  static Color primaryColor = Colors.lightBlue;

  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
  );
}
