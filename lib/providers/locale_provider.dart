import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class LocaleProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Locale _locale = Locale(
      Config.supportedLocales.contains(Config.appDefaultLanguage)
          ? Config.appDefaultLanguage
          : Config.supportedLocales.first);

  LocaleProvider() {
    _loadLocale();
  }

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    List<String> supportedLocales = Config.supportedLocales;

    bool forcedLocale = Config.forceDefaultLanguage;

    if (forcedLocale) {
      debugPrint(
          'Error: Language change forbidden. Forced locale is on. Set Config.forceLanguage to "false" in order to allow language change.');
      locale = _locale;
      return;
    }

    if (!supportedLocales.contains(locale.languageCode)) {
      debugPrint(
          'Unsupported locale: ${locale.languageCode.toUpperCase()}, please use one of the following: $supportedLocales. Or add the new locale to the supportedLocales list in config.dart');
      return;
    }

    debugPrint(
        'App language switched to: ${locale.languageCode.toUpperCase()}.');

    _locale = locale;
    notifyListeners();
    await _storage.write(
        key: 'user_defined_locale', value: locale.languageCode);
  }

  Future<void> _loadLocale() async {
    String? languageCode = await _storage.read(key: 'user_defined_locale');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}
