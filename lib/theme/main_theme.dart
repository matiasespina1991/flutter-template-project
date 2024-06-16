import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import '../models/theme_models.dart';

class MainTheme {
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: Config.scaffoldBackgroundColor.lightThemeColor,
      hintColor: Colors.blueAccent,
      textTheme: _buildTextTheme(base.textTheme, Config.primaryFont),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white, // AppBar text color
        titleTextStyle: Config.appBarFont.isGoogleFont
            ? GoogleFonts.getFont(Config.appBarFont.name,
                textStyle:
                    const TextStyle(fontSize: Config.appBarTitleFontSize))
            : TextStyle(
                fontFamily: Config.appBarFont.name,
                fontSize: Config.appBarTitleFontSize),
        backgroundColor: Config
            .appBarBackgroundColor.lightThemeColor, // AppBar background color
      ),
      colorScheme: const ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.blueAccent,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: Config.scaffoldBackgroundColor.darkThemeColor,
      hintColor: Colors.blueAccent,
      textTheme: _buildTextTheme(base.textTheme, Config.primaryFont),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white, // AppBar text color
        backgroundColor: Config
            .appBarBackgroundColor.darkThemeColor, // AppBar background color
        titleTextStyle: Config.appBarFont.isGoogleFont
            ? GoogleFonts.getFont(Config.appBarFont.name,
                textStyle:
                    const TextStyle(fontSize: Config.appBarTitleFontSize))
            : TextStyle(
                fontFamily: Config.appBarFont.name,
                fontSize: Config.appBarTitleFontSize),
      ),
      colorScheme: base.colorScheme.copyWith(
        onPrimary: Colors.black,
        primary: Colors.white,
        secondary: Colors.blueAccent,
        error: Colors.red[900]!,
        onSecondary: Colors.black,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, FontConfig font) {
    return base.copyWith(
      displayLarge: _applyFont(base.displayLarge, font),
      displayMedium: _applyFont(base.displayMedium, font),
      displaySmall: _applyFont(base.displaySmall, font),
      headlineLarge: _applyFont(base.headlineLarge, font),
      headlineMedium: _applyFont(base.headlineMedium, font),
      headlineSmall: _applyFont(base.headlineSmall, font),
      titleLarge: _applyFont(base.titleLarge, font),
      titleMedium: _applyFont(base.titleMedium, font),
      titleSmall: _applyFont(base.titleSmall, font),
      bodyLarge: _applyFont(
          base.bodyLarge?.copyWith(
            fontSize: Config.bodyLargeFontSize,
          ),
          font),
      bodyMedium: _applyFont(
          base.bodyMedium?.copyWith(
            fontSize: Config.bodyMediumFontSize,
          ),
          font),
      bodySmall: _applyFont(
          base.bodySmall?.copyWith(
            fontSize: Config.bodySmallFontSize,
          ),
          font),
      labelLarge: _applyFont(base.labelLarge, font),
      labelMedium: _applyFont(base.labelMedium, font),
      labelSmall: _applyFont(base.labelSmall, font),
    );
  }

  static TextStyle? _applyFont(TextStyle? style, FontConfig font) {
    if (style == null) return null;
    return font.isGoogleFont
        ? GoogleFonts.getFont(font.name, textStyle: style)
        : style.copyWith(fontFamily: font.name, fontSize: style.fontSize);
  }
}
