import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template_app/app_settings/theme_settings.dart';

import '../../models/theme_models.dart';

class MainTheme {
  /// --------------- LIGHT THEME ---------------
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: ThemeSettings.useMaterial3);
    return _buildTheme(base, Brightness.light);
  }

  /// --------------- DARK THEME ---------------

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: ThemeSettings.useMaterial3);
    return _buildTheme(base, Brightness.dark);
  }

  static ThemeData _buildTheme(ThemeData base, Brightness brightness) {
    ColorScheme colorScheme;

    if (ThemeSettings.forceSeedColor) {
      colorScheme = ColorScheme.fromSeed(
        seedColor: ThemeSettings.seedColor,
        brightness: brightness,
      );
    } else {
      colorScheme = brightness == Brightness.light
          ? ColorScheme.light(
              // primary: Config.primaryTextColor.lightModePrimary,
              primary: ThemeSettings.primaryTextColor.lightModePrimary,
              // secondary: Config.secondaryTextColor.lightModePrimary,
              secondary: ThemeSettings.secondaryTextColor.lightModePrimary,
              surface: Colors.white,
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: ThemeSettings.primaryTextColor.lightModePrimary,
              onError: Colors.white,
              brightness: brightness,
            )
          : ColorScheme.dark(
              primary: ThemeSettings.primaryTextColor.darkModePrimary,
              onPrimary: Colors.black,
              primaryContainer:
                  ThemeSettings.primaryContainerBackgroundColor.darkModePrimary,
              secondary: ThemeSettings.secondaryTextColor.darkModePrimary,
              error: Colors.red[900]!,
              surface: ThemeSettings.scaffoldBackgroundColor.darkModePrimary,
              onSurface: ThemeSettings.primaryTextColor.darkModePrimary,
              surfaceContainerHigh: Colors.red,
              onSecondary: Colors.black,
              onError: Colors.black,
              brightness: brightness,
            );
    }

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      hintColor: colorScheme.onSurface,
      sliderTheme: base.sliderTheme.copyWith(
        inactiveTrackColor: colorScheme.onSurface.withOpacity(0.5),
      ),
      textTheme:
          _buildTextTheme(base.textTheme, ThemeSettings.primaryTextStyle),
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.onPrimary,
        titleTextStyle: ThemeSettings.appBarTextStyle.isGoogleFont
            ? GoogleFonts.getFont(ThemeSettings.appBarTextStyle.name,
                textStyle: TextStyle(
                    fontSize: ThemeSettings.appBarTitleFontSize,
                    color: colorScheme.onPrimary))
            : TextStyle(
                fontFamily: ThemeSettings.appBarTextStyle.name,
                fontSize: ThemeSettings.appBarTitleFontSize,
                color: colorScheme.onPrimary),
        backgroundColor: ThemeSettings.forceSeedColor
            ? colorScheme.primary
            : (brightness == Brightness.light
                ? ThemeSettings.appBarBackgroundColor.lightModePrimary
                : ThemeSettings.appBarBackgroundColor.darkModePrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: ThemeSettings.forceSeedColor
              ? colorScheme.onPrimary
              : (brightness == Brightness.light
                  ? ThemeSettings.elevatedButtonTextColor.lightModePrimary
                  : ThemeSettings.elevatedButtonTextColor.darkModePrimary),
          backgroundColor: ThemeSettings.forceSeedColor
              ? colorScheme.primary.withOpacity(ThemeSettings.buttonsOpacity)
              : (brightness == Brightness.light
                      ? ThemeSettings
                          .elevatedButtonBackgroundColor.lightModePrimary
                      : ThemeSettings
                          .elevatedButtonBackgroundColor.darkModePrimary)
                  .withOpacity(ThemeSettings.buttonsOpacity),
          elevation: ThemeSettings.buttonsElevation,
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
            fontSize: ThemeSettings.bodyLargeFontSize,
          ),
          font),
      bodyMedium: _applyFont(
          base.bodyMedium?.copyWith(
            fontSize: ThemeSettings.bodyMediumFontSize,
          ),
          font),
      bodySmall: _applyFont(
          base.bodySmall?.copyWith(
            fontSize: ThemeSettings.bodySmallFontSize,
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
