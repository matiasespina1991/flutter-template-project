import 'package:flutter/material.dart';

import '../config.dart';

class DebugModeNotifier extends ChangeNotifier {
  bool _isDebugMode = Config.debugMode;

  bool get isDebugMode => _isDebugMode;

  DebugModeNotifier() {
    if (_isDebugMode) {
      printDebugMessages();
    }
  }

  void setDebugMode(bool value) {
    if (_isDebugMode != value) {
      _isDebugMode = value;
      if (_isDebugMode) {
        printDebugMessages();
      }
      notifyListeners();
    }
  }

  void printDebugMessages() {
    debugPrint('-------------------- DEBUG MODE: ON --------------------');
    debugPrint(
        'Login screen will be skipped and user will be automatically authenticated.');
    debugPrint('Change Config.debugMode to false to disable this feature.');
    debugPrint('--------------------------------------------------------');
  }
}
