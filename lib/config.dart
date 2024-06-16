import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/theme_models.dart';

class Config {
  // APP INFO:

  static const String appName = 'Template App';

  // DEBUG MODE:

  static const bool debugMode = true;

  // COLOR THEME:

  static const ScaffoldBackgroundColor scaffoldBackgroundColor =
      ScaffoldBackgroundColor(
    lightThemeColor: lightWhiteColor,
    darkThemeColor: lightBlackColor,
  );

  static const AppBarBackgroundColor appBarBackgroundColor =
      AppBarBackgroundColor(
    lightThemeColor: Colors.indigo,
    darkThemeColor: Colors.indigo,
  );

  // FONT TYPES:

  static const FontConfig appBarFont = FontConfig(
    name: 'Roboto',
    fontSize: 23,
    isGoogleFont: true,
  );

  static const FontConfig primaryFont = FontConfig(
    name: 'Roboto',
    isGoogleFont: true,
  );

  static const FontConfig secondaryFont = FontConfig(
    name: 'Open Sans',
    isGoogleFont: true,
  );

  static const FontConfig tertiaryFont = FontConfig(
    name: 'Lato',
    isGoogleFont: true,
  );

  // FONT SIZES:

  static const double appBarTitleFontSize = 20;
  static const double bodyLargeFontSize = 20;
  static const double bodyMediumFontSize = 14; // Default Text() font size
  static const double bodySmallFontSize = 12;

  //-----------------------

  //

  //-----------------------

  // UTILS:

  static const lightBlackColor = Color(0xFF121212);
  static const lightWhiteColor = Color(0xFFFFF8FE);

  static const TextThemes textThemes = TextThemes(
    primaryFont: primaryFont,
    secondaryFont: secondaryFont,
    tertiaryFont: tertiaryFont,
  );
}
