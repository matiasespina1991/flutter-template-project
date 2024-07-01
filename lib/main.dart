import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/app_settings/app_general_settings.dart';
import 'package:template_app/app_settings/app_info.dart';
import 'package:template_app/app_settings/auth_config.dart';
import 'package:template_app/app_settings/language_settings.dart';
import 'package:template_app/generated/l10n.dart';
import 'package:template_app/providers/providers_all.dart';
import 'package:template_app/screens/home_screen/home_screen.dart';
import 'package:template_app/theme/main_theme/main_theme.dart';
import 'package:template_app/utils/debug/log_configurations.dart';
import 'globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (AuthConfig.useFirebase) {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      debugPrint('Error: Firebase initialization failed. $e');
    }
  }
  logConfigurations();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);
    final localeNotifier = ref.watch(localeProvider);

    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      title: AppInfo.appName,
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      locale: localeNotifier.locale,
      supportedLocales: LanguageSettings.supportedLocales
          .map((e) => Locale.fromSubtags(languageCode: e))
          .toList(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (LanguageSettings.forceDefaultLanguage) {
          return const Locale(LanguageSettings.appDefaultLanguage);
        }
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
