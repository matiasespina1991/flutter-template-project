import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:template_app/generated/l10n.dart';
import 'package:template_app/providers/authorization_provider.dart';
import 'package:template_app/providers/locale_provider.dart';
import 'package:template_app/screens/home_screen/home_screen.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import 'package:template_app/screens/login_screen/login_screen.dart';
import 'package:template_app/theme/main_theme.dart';
import 'package:template_app/utils/create_route.dart';
import 'config.dart';
import 'globals.dart';
import 'providers/theme_provider.dart';

void main() async {
  if (Config.useFirebase) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  if (Config.debugMode) {
    debugPrint('-------------------- DEBUG MODE: ON --------------------');
    debugPrint(
        'Login screen will be skipped and user will be automatically authenticated.');
    debugPrint('Change Config.debugMode to false to disable this feature.');
    debugPrint('--------------------------------------------------------');
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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeNotifier, localeProvider, child) {
          return MaterialApp(
            scaffoldMessengerKey: snackbarKey,
            title: Config.appName,
            theme: MainTheme.lightTheme,
            darkTheme: MainTheme.darkTheme,
            themeMode: themeNotifier.themeMode,
            locale: localeProvider.locale,
            supportedLocales: Config.supportedLocales
                .map((e) => Locale.fromSubtags(languageCode: e))
                .toList(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
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
            return Navigator(
              onGenerateRoute: (settings) {
                return createRoute(const LoginScreen());
              },
            );
          }

          return Navigator(
            onGenerateRoute: (settings) {
              return createRoute(const HomeScreen());
            },
          );
        },
        child: const LoadingScreen(),
      ),
    );
  }
}
