import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  ThemeMode get userDefinedThemeMode => _themeMode;

  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await _storage.write(
        key: 'user_defined_theme_mode', value: isDarkMode.toString());
  }

  void _loadThemeMode() async {
    String? isDarkModeString =
        await _storage.read(key: 'user_defined_theme_mode');
    if (isDarkModeString != null) {
      bool isDarkMode = isDarkModeString == 'true';
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}
