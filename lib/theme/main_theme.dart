import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import '../models/theme_models.dart';

class MainTheme {
  /// --------------- LIGHT THEME ---------------
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: Config.useMaterial3);
    return base.copyWith(
      scaffoldBackgroundColor: Config.scaffoldBackgroundColor.lightThemeColor,
      hintColor: Config.hintTextColor
          .lightThemeColor, // Define the hintColor for light theme

      textTheme: _buildTextTheme(base.textTheme, Config.primaryTextStyle),

      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white, // AppBar text color
        titleTextStyle: Config.appBarTextStyle.isGoogleFont
            ? GoogleFonts.getFont(Config.appBarTextStyle.name,
                textStyle:
                    const TextStyle(fontSize: Config.appBarTitleFontSize))
            : TextStyle(
                fontFamily: Config.appBarTextStyle.name,
                fontSize: Config.appBarTitleFontSize),
        backgroundColor: Config
            .appBarBackgroundColor.lightThemeColor, // AppBar background color
      ),

      colorScheme: ColorScheme.light(
        primary: Config.primaryTextColor.lightThemeColor,
        secondary: Config.secondaryTextColor.lightThemeColor,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Config.elevatedButtonTextColor.lightThemeColor,
          backgroundColor: Config.elevatedButtonBackgroundColor.lightThemeColor,
          elevation: Config.buttonsElevation,
          minimumSize: const Size(double.infinity, 47),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      dividerTheme: base.dividerTheme.copyWith(
        space: 70,
        color: Colors.black26,
        thickness: 1,
        indent: 50,
        endIndent: 50,
      ),
    );
  }

  /// --------------- DARK THEME ---------------

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: Config.useMaterial3);
    return base.copyWith(
      scaffoldBackgroundColor: Config.scaffoldBackgroundColor.darkThemeColor,
      hintColor: Config
          .hintTextColor.darkThemeColor, // Define the hintColor for dark theme
      textTheme: _buildTextTheme(base.textTheme, Config.primaryTextStyle),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white, // AppBar text color
        backgroundColor: Config
            .appBarBackgroundColor.darkThemeColor, // AppBar background color
        titleTextStyle: Config.appBarTextStyle.isGoogleFont
            ? GoogleFonts.getFont(Config.appBarTextStyle.name,
                textStyle:
                    const TextStyle(fontSize: Config.appBarTitleFontSize))
            : TextStyle(
                fontFamily: Config.appBarTextStyle.name,
                fontSize: Config.appBarTitleFontSize),
      ),

      // primary,   Color? onPrimary,   Color? primaryContainer,   Color? onPrimaryContainer,   Color? primaryFixed,   Color? primaryFixedDim,   Color? onPrimaryFixed,   Color? onPrimaryFixedVariant,   Color? secondary,   Color? onSecondary,   Color? secondaryContainer,   Color? onSecondaryContainer,   Color? secondaryFixed,   Color? secondaryFixedDim,   Color? onSecondaryFixed,   Color? onSecondaryFixedVariant,   Color? tertiary,   Color? onTertiary,   Color? tertiaryContainer,   Color? onTertiaryContainer,   Color? tertiaryFixed,   Color? tertiaryFixedDim,   Color? onTertiaryFixed,   Color? onTertiaryFixedVariant,   Color? error,   Color? onError,   Color? errorContainer,   Color? onErrorContainer,   Color? surface,   Color? onSurface,   Color? surfaceDim,   Color? surfaceBright,   Color? surfaceContainerLowest,   Color? surfaceContainerLow,   Color? surfaceContainer,   Color? surfaceContainerHigh,   Color? surfaceContainerHighest,   Color? onSurfaceVariant,   Color? outline,   Color? outlineVariant,   Color? shadow,   Color? scrim,   Color? inverseSurface,   Color? onInverseSurface,   Color? inversePrimary,   Color? surfaceTint,   Color? background,   Color? onBackground,   Color? surfaceVariant,

      colorScheme: base.colorScheme.copyWith(
        primary: Config.primaryTextColor.darkThemeColor,
        onPrimary: Colors.black,
        primaryContainer: Config.primaryContainerBackgroundColor.darkThemeColor,
        secondary: Config.secondaryTextColor.darkThemeColor,
        error: Colors.red[900]!,
        onSecondary: Colors.black,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Config.elevatedButtonTextColor.darkThemeColor,
          backgroundColor: Config.elevatedButtonBackgroundColor.darkThemeColor,
          elevation: Config.buttonsElevation,
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      dividerTheme: base.dividerTheme.copyWith(
        space: 70,
        color: Colors.white60,
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
