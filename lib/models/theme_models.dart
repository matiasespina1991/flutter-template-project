import 'dart:ui';

class FontConfig {
  final String name;
  final bool isGoogleFont;
  final double? fontSize;

  const FontConfig({
    this.fontSize,
    required this.name,
    required this.isGoogleFont,
  });
}

class TextThemes {
  final FontConfig primaryFont;
  final FontConfig secondaryFont;
  final FontConfig tertiaryFont;

  const TextThemes({
    required this.primaryFont,
    required this.secondaryFont,
    required this.tertiaryFont,
  });
}

class ScaffoldBackgroundColor {
  final Color lightThemeColor;
  final Color darkThemeColor;

  const ScaffoldBackgroundColor({
    required this.lightThemeColor,
    required this.darkThemeColor,
  });
}

class AppBarBackgroundColor {
  final Color lightThemeColor;
  final Color darkThemeColor;

  const AppBarBackgroundColor({
    required this.lightThemeColor,
    required this.darkThemeColor,
  });
}
