import 'package:flutter/material.dart';

import '../config.dart';

class TemplateTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.blueAccent,
      fontFamily: Config.primaryFont,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.blueAccent,
      ).copyWith(surface: Colors.white),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      hintColor: Colors.blueAccent,
      fontFamily: Config.primaryFont,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.black,
        secondary: Colors.blueAccent,
      ).copyWith(surface: Colors.black),
    );
  }
}
