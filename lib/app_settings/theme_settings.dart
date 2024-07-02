import 'package:flutter/material.dart';
import 'package:template_app/theme/main_theme/main_theme.dart';

import '../models/general_models.dart';
import '../models/theme_models.dart';

class ThemeSettings {
  static const String defaultThemeMode = 'light';
  static const bool forceDefaultThemeMode = false;
  static const bool useMaterial3 = true;
  static const Color seedColor = Colors.green;
  static const bool forceSeedColor = false;
  static const String defaultScrollPhysics =
      'always'; // 'never', 'always', 'clamp'
  static const bool useFlutterToast = false;
  static const String textInputBorderStyle = 'border'; // 'border' / 'no-border'
  static const bool glassTextInputs = true;
  static const double buttonsElevation = 1.1;
  static const double buttonsOpacity = 0.8;

  static const LottieAnimationBackground primaryLottieBackgroundAnimation =
      LottieAnimationBackground(
    animationPath: 'lib/assets/lottie_animations/animation9.json',
    width: 200,
    x: 0,
    y: 0,
    blur: 80,
    active: true,
    opacity: 0.8,
  );

  static const LottieAnimationBackground secondaryLottieBackgroundAnimation =
      LottieAnimationBackground(
    animationPath: 'lib/assets/lottie_animations/animation4.json',
    width: 200,
    x: 0,
    y: 250,
    blur: 80,
    active: true,
    opacity: 0.8,
  );

  static const ternaryLottieBackgroundAnimation = LottieAnimationBackground(
    animationPath: 'lib/assets/lottie_animations/animation10.json',
    width: 200,
    x: 0,
    y: 0,
    blur: 50,
    active: true,
    opacity: 0.5,
  );

  static const ThemeColors scaffoldBackgroundColor = ThemeColors(
    lightModePrimary: Color(0xFFFFF8FE),
    darkModePrimary: Color(0xFF121212),
  );

  static const ThemeColors appBarBackgroundColor = ThemeColors(
    lightModePrimary: Colors.blueGrey,
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

  static const TextThemes textThemes = TextThemes(
    primaryFont: primaryTextStyle,
    secondaryFont: secondaryTextStyle,
    tertiaryFont: tertiaryTextStyle,
  );
}
