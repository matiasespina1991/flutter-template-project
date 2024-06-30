import 'package:flutter/material.dart';

import '../models/general_models.dart';
import '../models/theme_models.dart';

class ThemeConfig {
  static const String defaultThemeMode = 'light';
  static const bool forceDefaultThemeMode = false;
  static const String defaultScrollPhysics = 'always';
  static const bool forceSeedColor = true;
  static const Color seedColor = Colors.yellow;

  static const LottieAnimationBackground
      loginScreenLottieBackgroundAnimationLightMode = LottieAnimationBackground(
    animationPath: 'lib/assets/animation9.json',
    width: 200,
    x: 0,
    y: 0,
    blur: 80,
    active: false,
    opacity: 0.8,
  );

  static const LottieAnimationBackground
      loginScreenLottieBackgroundAnimationDarkMode = LottieAnimationBackground(
    animationPath: 'lib/assets/animation4.json',
    width: 200,
    x: 0,
    y: 250,
    blur: 80,
    active: false,
    opacity: 0.8,
  );

  static const ThemeColors scaffoldBackgroundColor = ThemeColors(
    lightModePrimary: Color(0xFFFFF8FE),
    darkModePrimary: Color(0xFF121212),
  );

  static const ThemeColors appBarBackgroundColor = ThemeColors(
    lightModePrimary: Colors.black87,
    darkModePrimary: Colors.blueGrey,
  );

  static const ThemeColors primaryTextColor = ThemeColors(
    lightModePrimary: Colors.black,
    darkModePrimary: Colors.white,
  );

  static const ThemeColors secondaryTextColor = ThemeColors(
    lightModePrimary: Colors.black,
    darkModePrimary: Colors.white,
  );

  static const ThemeColors hintTextColor = ThemeColors(
    lightModePrimary: Colors.grey,
    darkModePrimary: Colors.grey,
  );

  static const ThemeColors primaryContainerBackgroundColor = ThemeColors(
    lightModePrimary: Colors.blueGrey,
    darkModePrimary: Colors.blueGrey,
  );

  static const ThemeColors elevatedButtonBackgroundColor = ThemeColors(
    lightModePrimary: Colors.blueGrey,
    darkModePrimary: Colors.blueGrey,
  );

  static const ThemeColors elevatedButtonTextColor = ThemeColors(
    lightModePrimary: Colors.white,
    darkModePrimary: Colors.white,
  );

  static const Color snackBarErrorBackgroundColor = Colors.red;
  static const Color snackBarErrorTextColor = Colors.white;
  static const Color snackBarSuccessBackgroundColor = Colors.green;
  static const Color snackBarSuccessTextColor = Colors.white;
  static const Color snackBarInfoBackgroundColor = Colors.grey;
  static const Color snackBarInfoTextColor = Colors.white;

  static const FontConfig appBarTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true,
  );

  static const FontConfig primaryTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true,
  );

  static const FontConfig secondaryTextStyle = FontConfig(
    name: 'Open Sans',
    isGoogleFont: true,
  );

  static const FontConfig tertiaryTextStyle = FontConfig(
    name: 'Lato',
    isGoogleFont: true,
  );

  static const FontConfig snackbarTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true,
  );

  static const double appBarTitleFontSize = 20;
  static const double bodyLargeFontSize = 16;
  static const double bodyMediumFontSize = 13;
  static const double bodySmallFontSize = 12;
  static const double snackbarFontSize = 14;

  static const double buttonsElevation = 1.1;

  static const TextThemes textThemes = TextThemes(
    primaryFont: primaryTextStyle,
    secondaryFont: secondaryTextStyle,
    tertiaryFont: tertiaryTextStyle,
  );
}
