import 'package:flutter/material.dart';

import 'models/theme_models.dart';

class Config {
  // APP INFO:

  static const String appName = 'Template App';

  // APP CONFIG:

  static const bool useFirebase = false;
  static const bool useTopAppBar = false;

  static const bool allowGoogleSignIn = true;
  static const List<String> googleSignInScopes = [
    'email'
  ]; // 'email', 'profile', 'openid', etc
  static const bool allowFacebookSignIn = false;
  static const bool allowAppleSignIn = false;
  static const bool allowAnonymousSignIn = false;
  static const bool allowEmailSignIn = false;

  static const List supportedLanguages = ['en'];

  // DEBUG MODE:

  static const bool debugMode = false;

  // APP STYLES:

  static const bool useFlutterToast = false; // Use FlutterToast package
  static const bool useMaterial3 = true; // Use Material 3.0

  // COLOR THEME:

  static const ThemeColors scaffoldBackgroundColor = ThemeColors(
    lightThemeColor: lightWhiteColor,
    darkThemeColor: lightBlackColor,
  );

  static const ThemeColors appBarBackgroundColor = ThemeColors(
    lightThemeColor: Colors.black87,
    darkThemeColor: Colors.blueGrey,
  );

  static const ThemeColors primaryTextColor = ThemeColors(
    lightThemeColor: Colors.black,
    darkThemeColor: Colors.white,
  );

  static const ThemeColors secondaryTextColor = ThemeColors(
    lightThemeColor: Colors.black,
    darkThemeColor: Colors.white,
  );

  static const ThemeColors hintTextColor = ThemeColors(
    lightThemeColor: Colors.grey,
    darkThemeColor: Colors.grey,
  );

  static const ThemeColors elevatedButtonBackgroundColor = ThemeColors(
    lightThemeColor: Colors.white,
    darkThemeColor: Colors.blueGrey,
  );

  static const ThemeColors elevatedButtonTextColor = ThemeColors(
    lightThemeColor: Colors.black,
    darkThemeColor: Colors.white,
  );

  static const Color snackBarErrorBackgroundColor = Colors.red;
  static const Color snackBarErrorTextColor = Colors.white;
  static const Color snackBarSuccessBackgroundColor = Colors.green;
  static const Color snackBarSuccessTextColor = Colors.white;
  static const Color snackBarInfoBackgroundColor = Colors.grey;
  static const Color snackBarInfoTextColor = Colors.white;

  // FONT TYPES:

  static const FontConfig appBarTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig primaryTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig secondaryTextStyle = FontConfig(
    name: 'Open Sans',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig tertiaryTextStyle = FontConfig(
    name: 'Lato',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig snackbarTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true, // Set to false if using a custom font
  );

  // FONT SIZES:

  static const double appBarTitleFontSize = 20;
  static const double bodyLargeFontSize = 20;
  static const double bodyMediumFontSize = 14; // Default Text() font size
  static const double bodySmallFontSize = 12;
  static const double snackbarFontSize = 14;

  //-----------------------

  //

  //-----------------------

  // UTILS (DO NOT EDIT):

  static const lightBlackColor = Color(0xFF121212);
  static const lightWhiteColor = Color(0xFFFFF8FE);

  static const TextThemes textThemes = TextThemes(
    primaryFont: primaryTextStyle,
    secondaryFont: secondaryTextStyle,
    tertiaryFont: tertiaryTextStyle,
  );
}
