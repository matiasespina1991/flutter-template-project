import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpguard_poc/providers/auth_provider.dart';
import 'package:gpguard_poc/providers/locale_provider.dart';
import 'package:gpguard_poc/providers/theme_provider.dart';

import '../services/connectivity_service.dart';

final authProvider = ChangeNotifierProvider((ref) => AuthorizationProvider());
final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());
final localeProvider = ChangeNotifierProvider((ref) => LocaleProvider());
final connectivityProvider =
    ChangeNotifierProvider((ref) => ConnectivityService());
