import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import '../models/theme_models.dart';

class MainTheme {
  /// --------------- LIGHT THEME ---------------
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: Config.useMaterial3);
    return _buildTheme(base, Brightness.light);
  }

  /// --------------- DARK THEME ---------------

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: Config.useMaterial3);
    return _buildTheme(base, Brightness.dark);
  }

  static ThemeData _buildTheme(ThemeData base, Brightness brightness) {
    ColorScheme colorScheme;

    if (Config.themeSeedColor.forceSeedColor) {
      colorScheme = ColorScheme.fromSeed(
        seedColor: Config.themeSeedColor.seedColor,
        brightness: brightness,
      );
    } else {
      colorScheme = brightness == Brightness.light
          ? ColorScheme.light(
              primary: Config.primaryTextColor.lightModePrimary,
              secondary: Config.secondaryTextColor.lightModePrimary,
              background: Config.scaffoldBackgroundColor.lightModePrimary,
              surface: Colors.white,
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onBackground: Config.primaryTextColor.lightModePrimary,
              onSurface: Config.primaryTextColor.lightModePrimary,
              onError: Colors.white,
              brightness: brightness,
            )
          : ColorScheme.dark(
              primary: Config.primaryTextColor.darkModePrimary,
              onPrimary: Colors.black,
              primaryContainer:
                  Config.primaryContainerBackgroundColor.darkModePrimary,
              secondary: Config.secondaryTextColor.darkModePrimary,
              error: Colors.red[900]!,
              background: Config.scaffoldBackgroundColor.darkModePrimary,
              onBackground: Config.primaryTextColor.darkModePrimary,
              onSecondary: Colors.black,
              onError: Colors.black,
              brightness: brightness,
            );
    }

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      hintColor: colorScheme.onSurface,
      textTheme: _buildTextTheme(base.textTheme, Config.primaryTextStyle),
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.onPrimary,
        titleTextStyle: Config.appBarTextStyle.isGoogleFont
            ? GoogleFonts.getFont(Config.appBarTextStyle.name,
                textStyle: TextStyle(
                    fontSize: Config.appBarTitleFontSize,
                    color: colorScheme.onPrimary))
            : TextStyle(
                fontFamily: Config.appBarTextStyle.name,
                fontSize: Config.appBarTitleFontSize,
                color: colorScheme.onPrimary),
        backgroundColor: Config.themeSeedColor.forceSeedColor
            ? colorScheme.primary
            : (brightness == Brightness.light
                ? Config.appBarBackgroundColor.lightModePrimary
                : Config.appBarBackgroundColor.darkModePrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Config.themeSeedColor.forceSeedColor
              ? colorScheme.onPrimary
              : (brightness == Brightness.light
                  ? Config.elevatedButtonTextColor.lightModePrimary
                  : Config.elevatedButtonTextColor.darkModePrimary),
          backgroundColor: Config.themeSeedColor.forceSeedColor
              ? colorScheme.primary.withOpacity(Config.buttonsOpacity)
              : (brightness == Brightness.light
                      ? Config.elevatedButtonBackgroundColor.lightModePrimary
                      : Config.elevatedButtonBackgroundColor.darkModePrimary)
                  .withOpacity(Config.buttonsOpacity),
          elevation: Config.buttonsElevation,
          minimumSize: const Size(double.infinity, 47),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      dividerTheme: base.dividerTheme.copyWith(
        space: 70,
        color: colorScheme.onSurface.withOpacity(0.2),
        thickness: 1,
        indent: 50,
        endIndent: 50,
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
