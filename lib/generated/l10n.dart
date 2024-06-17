// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get _locale {
    return Intl.message(
      'en',
      name: '_locale',
      desc: '',
      args: [],
    );
  }

  /// `Login screen`
  String get loginScreenTitle {
    return Intl.message(
      'Login screen',
      name: 'loginScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `EMAIL`
  String get emailLabel {
    return Intl.message(
      'EMAIL',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `PASSWORD`
  String get passwordLabel {
    return Intl.message(
      'PASSWORD',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutButton {
    return Intl.message(
      'Logout',
      name: 'logoutButton',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsButton {
    return Intl.message(
      'Settings',
      name: 'settingsButton',
      desc: '',
      args: [],
    );
  }

  /// `Signing in...`
  String get signingInMessage {
    return Intl.message(
      'Signing in...',
      name: 'signingInMessage',
      desc: '',
      args: [],
    );
  }

  /// `Login successful!`
  String get loginSuccessfulMessage {
    return Intl.message(
      'Login successful!',
      name: 'loginSuccessfulMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error logging in. Please try again or contact support.`
  String get loginErrorMessage {
    return Intl.message(
      'Error logging in. Please try again or contact support.',
      name: 'loginErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please insert a valid email.`
  String get invalidEmailMessage {
    return Intl.message(
      'Please insert a valid email.',
      name: 'invalidEmailMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please insert a valid password.`
  String get invalidPasswordMessage {
    return Intl.message(
      'Please insert a valid password.',
      name: 'invalidPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode/Dark Mode`
  String get lightModeDarkMode {
    return Intl.message(
      'Light Mode/Dark Mode',
      name: 'lightModeDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Switch to dark mode`
  String get switchToDarkMode {
    return Intl.message(
      'Switch to dark mode',
      name: 'switchToDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Switch to light mode`
  String get switchToLightMode {
    return Intl.message(
      'Switch to light mode',
      name: 'switchToLightMode',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailHintText {
    return Intl.message(
      'Email',
      name: 'emailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHintText {
    return Intl.message(
      'Password',
      name: 'passwordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long.`
  String get invalidPasswordTooShortMessage {
    return Intl.message(
      'Password must be at least 6 characters long.',
      name: 'invalidPasswordTooShortMessage',
      desc: '',
      args: [],
    );
  }

  /// `The email address inserted is not valid.`
  String get invalidEmailSnackbarMessage {
    return Intl.message(
      'The email address inserted is not valid.',
      name: 'invalidEmailSnackbarMessage',
      desc: '',
      args: [],
    );
  }

  /// `The password inserted is not valid.`
  String get invalidPasswordSnackbarMessage {
    return Intl.message(
      'The password inserted is not valid.',
      name: 'invalidPasswordSnackbarMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please fill the following fields:`
  String get pleaseFillTheFollowingFields {
    return Intl.message(
      'Please fill the following fields:',
      name: 'pleaseFillTheFollowingFields',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogleButtonLabel {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogleButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Signing in with Google...`
  String get signingInWithGoogleSnackbarMessage {
    return Intl.message(
      'Signing in with Google...',
      name: 'signingInWithGoogleSnackbarMessage',
      desc: '',
      args: [],
    );
  }

  /// `There was an error signing in with Google. Please try again or contact support.`
  String get errorSigningInWithGoogleSnackbarMessage {
    return Intl.message(
      'There was an error signing in with Google. Please try again or contact support.',
      name: 'errorSigningInWithGoogleSnackbarMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
