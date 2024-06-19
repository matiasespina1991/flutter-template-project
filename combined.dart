import 'package:flutter/material.dart';

import 'models/theme_models.dart';

class Config {
  // APP INFO:
  static const String appName = 'Template App';

  // APP CONFIG:
  static const bool useSafeArea =
      false; // If true, the app will adjust to the space below the status bar
  static const bool useTopAppBar = false;
  static const bool useFloatingSpeedDialMenu = true;
  static const bool useAppDrawer = false;

  // DEBUG MODE:
  static const bool debugMode = false; // Set to true to skip login screen
  static const debugScreen =
      '/home'; // Set to the screen you want to navigate to in debug mode

  // AUTH:
  static const bool useProtectedRoutes =
      true; // If true, the app will always redirect to login screen if user is not authenticated
  static const bool useFirebase = false;
  static const bool allowGoogleSignIn = false;
  static const List<String> googleSignInScopes = [
    'email'
  ]; // 'email', 'profile', 'openid', etc
  static const bool allowFacebookSignIn = false;
  static const bool allowAppleSignIn = false;
  static const bool allowAnonymousSignIn = false;
  static const bool allowEmailSignIn = false;

  static const String appDefaultLanguage = 'es';
  static const bool forceDefaultLanguage = false;
  static const List<String> supportedLocales = ['en', 'es', 'de'];

  /// NOTE: edit lib/l10n/intl_xx.arb files and use 'flutter pub run intl_utils:generate' to generate translations

  // APP STYLES:

  static const String defaultThemeMode = 'light'; // 'light' | 'dark'
  static const bool forceDefaultThemeMode = false;
  static const bool useFlutterToast =
      false; // Use FlutterToast package for snackbars
  static const bool useMaterial3 = true; // Use Material 3.0 // DEFAULT: true

  // COLOR THEME:

  ///TODO
  //ThemePalette for dark and light themes, presenting the primary, secondary, tertiary, quarternary, white, and black, inverse, success, info, warning, and error colors.

  // static const ThemePallette themePallette = ThemePallette(
  //   primary: Color(0xFF6200EE),
  //   secondary: Color(0xFF03DAC6),
  //   tertiary: Color(0xFF03DAC6),
  //   quarternary: Color(0xFF03DAC6),
  //   white: Color(0xFFFFFFFF),
  //   black: Color(0xFF000000),
  //   inverse: Color(0xFF000000),
  //   success: Color(0xFF00C853),
  //   info: Color(0xFF03DAC6),
  //   warning: Color(0xFFFFAB00),
  //   error: Color(0xFFFF453A),
  // );

  static const ThemeColors scaffoldBackgroundColor = ThemeColors(
    lightModePrimary: lightWhiteColor,
    darkModePrimary: lightBlackColor,
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

  // FONT TYPES:

  static const FontConfig appBarTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig primaryTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig secondaryTextStyle = FontConfig(
    name: 'Open Sans',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig tertiaryTextStyle = FontConfig(
    name: 'Lato',
    isGoogleFont: true, // Set to false if using a custom font
  );

  static const FontConfig snackbarTextStyle = FontConfig(
    name: 'Roboto',
    isGoogleFont: true, // Set to false if using a custom font
  );

  // FONT SIZES:

  static const double appBarTitleFontSize = 20;
  static const double bodyLargeFontSize = 16; // Input fields text
  static const double bodyMediumFontSize = 13; // Default Text() font size
  static const double bodySmallFontSize = 12;
  static const double snackbarFontSize = 14;

  // SHADOWS:

  static const double buttonsElevation = 1.1;

  //-----------------------

  //

  //-----------------------

  // UTILS (DO NOT EDIT):

  static const lightBlackColor = Color(0xFF121212);
  static const lightWhiteColor = Color(0xFFFFF8FE);

  static const TextThemes textThemes = TextThemes(
    primaryFont: primaryTextStyle,
    secondaryFont: secondaryTextStyle,
    tertiaryFont: tertiaryTextStyle,
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/generated/l10n.dart';
import 'package:template_app/providers/providers_all.dart';
import 'package:template_app/screens/home_screen/home_screen.dart';
import 'package:template_app/theme/main_theme.dart';
import 'package:template_app/utils/notify_that_app_is_runing_in_debug_mode.dart';
import 'config.dart';
import 'globals.dart';

void main() async {
  if (Config.useFirebase) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  if (Config.debugMode) {
    notifyThatAppIsRunningInDebugMode();
  }
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
      title: Config.appName,
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      themeMode: themeNotifier.themeMode,
      locale: localeNotifier.locale,
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
        bool forceDefaultLanguage = Config.forceDefaultLanguage;

        if (forceDefaultLanguage) {
          if (Config.supportedLocales.contains(Config.appDefaultLanguage)) {
            return const Locale(Config.appDefaultLanguage);
          } else {
            debugPrint(
                'Error: Default language "${Config.appDefaultLanguage.toUpperCase()}" not found in supportedLocales list. Defaulting to the first locale in the list. Please add the default language to the supportedLocales list in config.dart.');
            return Locale(Config.supportedLocales.first);
          }
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/widgets/AppScaffold/app_scaffold.dart';

import '../../config.dart';
import '../../generated/l10n.dart';
import '../../providers/providers_all.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool useAppBar = Config.useTopAppBar;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Home Screen',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).lightMode,
                  style: TextStyle(
                    fontWeight: Theme.of(context).brightness == Brightness.light
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const Text(
                  ' / ',
                ),
                Text(
                  S.of(context).darkMode,
                  style: TextStyle(
                    fontWeight: Theme.of(context).brightness == Brightness.dark
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              onChanged: (value) {
                ref.read(themeProvider).toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'package:flutter/services.dart';
import 'package:template_app/generated/l10n.dart';

import '../../config.dart';
import '../../providers/providers_all.dart';
import '../../utils/create_route.dart';
import '../../utils/is_email_valid.dart';
import '../../widgets/AppScaffold/app_scaffold.dart';
import '../../widgets/NotificationSnackbar/notification_snackbar.dart';
import '../../widgets/ThemeInputField/theme_input_field.dart';
import '../home_screen/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  final int minPasswordLength = 6;
  bool _attemptingLogin = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: S.of(context).loginScreenTitle,
      protected: false,
      hideFloatingSpeedDialMenu: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Config.useTopAppBar
                    ? const SizedBox()
                    : Config.useSafeArea
                        ? const SizedBox(height: 40)
                        : const SizedBox(
                            height: 100,
                          ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: 5),
                      Text(
                        S.of(context).emailLabel,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ThemeInputField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  hintText: S.of(context).emailHintText,
                  isEmailInput: true,
                  isValid: _isEmailValid,
                  errorText: S.of(context).invalidEmailMessage,
                  onChanged: (value) {
                    if (isEmailValid(value)) {
                      setState(() {
                        _isEmailValid = true;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.lock_outline),
                      const SizedBox(width: 5),
                      Text(
                        S.of(context).passwordLabel,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ThemeInputField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  hintText: S.of(context).passwordHintText,
                  isPasswordInput: true,
                  hidePasswordVisibilityIcon: false,
                  isValid: _isPasswordValid,
                  errorText: S.of(context).invalidPasswordMessage,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length >= minPasswordLength) {
                      setState(() {
                        _isPasswordValid = true;
                      });
                    }
                  },
                ),
                const SizedBox(height: 32.0),
                SizedBox(
                  width: 233,
                  child: ElevatedButton(
                    onPressed:
                        _attemptingLogin ? null : () => attemptLogin(ref),
                    child: Text(S.of(context).loginButton),
                  ),
                ),
                Visibility(
                  visible: Config.allowGoogleSignIn,
                  child: Column(
                    children: [
                      const SizedBox(height: 22.0),
                      SignInButton(Buttons.google,
                          elevation: Config.buttonsElevation,
                          padding: const EdgeInsets.all(5.5),
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          text: S.of(context).signInWithGoogleButtonLabel,
                          onPressed: () async {
                        NotificationSnackbar.showSnackBar(
                          message:
                              S.of(context).signingInWithGoogleSnackbarMessage,
                          variant: SnackbarVariant.info,
                          duration: SnackbarDuration.long,
                        );

                        try {
                          await ref.read(authProvider).signInWithGoogle();
                        } on PlatformException catch (error) {
                          NotificationSnackbar.showSnackBar(
                            message: S
                                .of(context)
                                .errorSigningInWithGoogleSnackbarMessage,
                            variant: SnackbarVariant.error,
                            duration: SnackbarDuration.long,
                          );

                          debugPrint(
                              'Error signing in with Google: ${error.toString()}');
                        } catch (error) {
                          NotificationSnackbar.showSnackBar(
                            message: S
                                .of(context)
                                .errorSigningInWithGoogleSnackbarMessage,
                            variant: SnackbarVariant.error,
                            duration: SnackbarDuration.long,
                          );
                          debugPrint('Error: ${error.toString()}');
                        }
                      }),
                    ],
                  ),
                ),
                const Divider(),
                Text(S.of(context).lightModeDarkMode),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    ref.read(themeProvider).toggleTheme(value);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(localeProvider).setLocale(const Locale('en'));
                      },
                      child: const Text(
                        '🇺🇸',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('/'),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        ref.read(localeProvider).setLocale(const Locale('es'));
                      },
                      child: const Text(
                        '🇪🇸',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('/'),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        ref.read(localeProvider).setLocale(const Locale('de'));
                      },
                      child: const Text(
                        '🇩🇪',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void attemptLogin(WidgetRef ref) async {
    debugPrint('Attempting login...');
    var error = false;
    setState(() {
      _isEmailValid = true;
      _isPasswordValid = true;
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      List<String> emptyFields = [];
      if (_emailController.text.isEmpty) {
        debugPrint('Please insert a valid email');
        emptyFields.add(S.of(context).email);
        setState(() {
          _isEmailValid = false;
        });
        NotificationSnackbar.showSnackBar(
          message: S.of(context).invalidEmailSnackbarMessage,
          variant: SnackbarVariant.error,
          duration: SnackbarDuration.short,
        );
      }
      if (_passwordController.text.isEmpty) {
        debugPrint('Please insert a valid password');
        emptyFields.add(S.of(context).password);
        setState(() {
          _isPasswordValid = false;
        });
        NotificationSnackbar.showSnackBar(
          message: S.of(context).invalidPasswordSnackbarMessage,
          variant: SnackbarVariant.error,
          duration: SnackbarDuration.short,
        );
        error = true;
      }

      debugPrint('Error: The following fields are empty: $emptyFields');

      NotificationSnackbar.showSnackBar(
        message:
            '${S.of(context).pleaseFillTheFollowingFields} ${emptyFields.join(', ')}.',
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.short,
      );
      error = true;
    }

    if (_emailController.text.isNotEmpty &&
        !isEmailValid(_emailController.text)) {
      debugPrint('Email is not valid');
      setState(() {
        _isEmailValid = false;
      });
      NotificationSnackbar.showSnackBar(
        message: S.of(context).invalidEmailMessage,
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.short,
      );
      error = true;
    }

    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.length < minPasswordLength) {
      debugPrint('Password is too short. Minimum length: $minPasswordLength');
      setState(() {
        _isPasswordValid = false;
      });
      NotificationSnackbar.showSnackBar(
        message: S.of(context).invalidPasswordTooShortMessage,
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.short,
      );
      error = true;
    }

    if (error) {
      debugPrint('Login aborted.');
      return;
    }

    setState(() {
      _attemptingLogin = true;
    });

    NotificationSnackbar.showSnackBar(
      message: S.of(context).signingInMessage,
      variant: SnackbarVariant.info,
      duration: SnackbarDuration.long,
    );
    try {
      bool userSignedIn = await ref
          .read(authProvider)
          .signInWithEmail(_emailController.text, _passwordController.text);

      if (userSignedIn) {
        NotificationSnackbar.hideCurrentSnackBar();
        NotificationSnackbar.showSnackBar(
            message: S.of(context).loginSuccessfulMessage,
            variant: SnackbarVariant.success,
            duration: SnackbarDuration.short,
            delay: 1);
        Navigator.of(context).pushReplacement(
            createRoute(const HomeScreen(), direction: SlideDirection.right));
      } else {
        NotificationSnackbar.showSnackBar(
          message: S.of(context).loginErrorMessage,
          variant: SnackbarVariant.error,
          duration: SnackbarDuration.long,
        );
      }
    } catch (error) {
      NotificationSnackbar.showSnackBar(
        message: S.of(context).loginErrorMessage,
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.long,
      );
      debugPrint('Error logging in: ${error.toString()}');
    } finally {
      setState(() {
        _attemptingLogin = false;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/providers/providers_all.dart';
import 'package:template_app/screens/loading_screen/loading_screen.dart';
import '../../config.dart';
import '../../screens/login_screen/login_screen.dart';
import '../../utils/create_route.dart';
import '../ThemeAppBar/template_app_bar.dart';
import '../ThemeFloatingSpeedDialMenu/theme_floating_speed_dial_menu.dart';

class AppScaffold extends ConsumerStatefulWidget {
  final Widget body;
  final bool hideFloatingSpeedDialMenu;
  final String appBarTitle;
  final bool protected;

  const AppScaffold({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.hideFloatingSpeedDialMenu = false,
    this.protected = true,
  });

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final theme = ref.watch(themeProvider);

    if (!Config.debugMode &&
        Config.useProtectedRoutes &&
        widget.protected &&
        !auth.isAuthenticated &&
        !_navigated) {
      _navigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
            createRoute(const LoginScreen(), direction: SlideDirection.left));
      });
    }

    if (!auth.isAuthenticated && widget.protected) {
      return LoadingScreen();
    }

    ValueNotifier<bool> isFloatingMenuOpen = ValueNotifier(false);

    return SafeArea(
      top: Config.useSafeArea,
      child: Scaffold(
        appBar: Config.useTopAppBar
            ? ThemeAppBar(
                title: widget.appBarTitle,
              )
            : null,
        body: Stack(
          children: [
            widget.body,
            if (!widget.hideFloatingSpeedDialMenu &&
                Config.useFloatingSpeedDialMenu)
              Positioned.fill(
                child: ValueListenableBuilder(
                  valueListenable: isFloatingMenuOpen,
                  builder: (context, value, child) {
                    return value
                        ? BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
              ),
          ],
        ),
        floatingActionButton: ThemeFloatingSpeedDialMenu(
          hideFloatingSpeedDialMenu: widget.hideFloatingSpeedDialMenu,
          isDialOpenNotifier: isFloatingMenuOpen,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config.dart';

class AuthorizationProvider extends ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final FirebaseAuth? _firebaseAuth =
      Config.useFirebase ? FirebaseAuth.instance : null;

  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: Config.googleSignInScopes);
  String? _authToken;

  AuthorizationProvider() {
    _loadAuthToken();
  }

  String? get authToken => _authToken;

  Future<void> _loadAuthToken() async {
    _authToken = await storage.read(key: 'auth_token');
    notifyListeners();
  }

  Future<void> setAuthToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
    _authToken = token;
    notifyListeners();
  }

  Future<void> clearAuthToken() async {
    await storage.delete(key: 'auth_token');
    _authToken = null;
    debugPrint('Auth token cleared. User will be logged out.');
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    if (Config.debugMode) {
      debugPrint(
          'Error: Debug mode is on. Disable it from Config.debugMode in order to proceed with sign out.');
      return;
    }
    await clearAuthToken();
    if (Config.useFirebase) {
      await _firebaseAuth?.signOut();
    }
  }

  bool get isAuthenticated =>
      Config.debugMode || (_authToken != null && _authToken!.isNotEmpty);

  /// Email/Password Sign In methods
  Future<bool> signInWithEmail(String email, String password) async {
    bool success = false;
    try {
      debugPrint('Attempting to sign in with email and password.');

      if (Config.useFirebase) {
        final UserCredential authResult = await _firebaseAuth!
            .signInWithEmailAndPassword(email: email, password: password);
        _authToken = authResult.user!.uid; // Use user ID as auth token
        await setAuthToken(_authToken!);
      } else {
        // Non-Firebase Sign In
        _authToken = email; // Use email as auth token
        await setAuthToken(_authToken!);
      }

      notifyListeners();
      success = true;
      return success;
    } catch (error) {
      debugPrint('Error during email/password Sign In: ${error.toString()}');

      success = false;
      return success;
    }
  }

  /// Google Sign In methods
  Future<bool> signInWithGoogle() async {
    bool success = false;
    if (Config.allowGoogleSignIn) {
      try {
        debugPrint('Attempting to sign in with Google.');

        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          debugPrint('Google Sign In successful.');
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          if (Config.useFirebase) {
            final UserCredential? authResult =
                await _firebaseAuth?.signInWithCredential(credential);
            _authToken = authResult?.user!.uid; // Use user ID as auth token
            await setAuthToken(_authToken!);
          } else {
            /// Non-Firebase Sign In
            _authToken =
                googleAuth.accessToken; // Use access token as auth token
            await setAuthToken(_authToken!);
          }

          notifyListeners();
          success = true;
          return success;
        }
      } catch (error) {
        debugPrint('Error during Google Sign In: ${error.toString()}');
        success = false;
        return success;
      }
    }
    return success;
  }
}

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

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config.dart';

class LocaleProvider extends ChangeNotifier {
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_app/providers/auth_provider.dart';
import 'package:template_app/providers/locale_provider.dart';
import 'package:template_app/providers/theme_provider.dart';

import 'debug_mode_notifier.dart';

final authProvider = ChangeNotifierProvider((ref) => AuthorizationProvider());
final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());
final localeProvider = ChangeNotifierProvider((ref) => LocaleProvider());
final debugModeProvider = ChangeNotifierProvider((ref) => DebugModeNotifier());

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool forceDefaultTheme = Config.forceDefaultThemeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  ThemeMode get userDefinedThemeMode => _themeMode;

  void toggleTheme(bool isDarkMode) async {
    if (forceDefaultTheme) {
      debugPrint(
          'Error: Theme mode change forbidden. Forced theme is on. Disable it from Config.forceDefaultThemeMode in order to proceed with theme change.');
      return;
    }

    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    String? userDefinedTheme = isDarkMode ? 'dark' : 'light';
    await _storage.write(
        key: 'user_defined_theme_mode', value: userDefinedTheme);
  }

  void _loadThemeMode() async {
    if (forceDefaultTheme) {
      _themeMode =
          Config.defaultThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
      return;
    }

    String? userDefinedTheme =
        await _storage.read(key: 'user_defined_theme_mode');

    if (userDefinedTheme != null) {
      bool isDarkMode = userDefinedTheme == 'dark' ? true : false;
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}

