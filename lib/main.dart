import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:template_app/generated/l10n.dart';
import 'package:template_app/providers/authorization_provider.dart';
import 'package:template_app/screens/home_screen/home_screen.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import 'package:template_app/screens/login_screen/login_screen.dart';
import 'package:template_app/theme/main_theme.dart';
import 'config.dart';
import 'globals.dart';
import 'helpers/theme_notifier.dart';

void main() async {
  if (Config.useFirebase) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthorizationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            scaffoldMessengerKey: snackbarKey,
            title: Config.appName,
            theme: MainTheme.lightTheme,
            darkTheme: MainTheme.darkTheme,
            themeMode: themeNotifier.themeMode,

            ///TODO: Add automatic locale detection
            locale: const Locale.fromSubtags(
                languageCode: Config.appDefaultLanguage),
            supportedLocales: Config.supportedLocales.length > 1
                ? Config.supportedLocales
                    .map((e) => Locale.fromSubtags(languageCode: e))
                    .toList()
                : [const Locale.fromSubtags(languageCode: 'en')],
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: Config.useSafeArea,
      child: Consumer<AuthorizationProvider>(
        builder: (BuildContext context, value, Widget? child) {
          bool isAuthenticated = value.isAuthenticated;

          if (Config.debugMode == true) {
            isAuthenticated = true;
          }

          if (!isAuthenticated) {
            return const LoginScreen();
          }
          return const HomeScreen();
        },
        child: const LoadingScreen(),
      ),
    );
  }
}
