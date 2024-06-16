import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:template_app/utils/show_snackbar.dart';
import 'package:template_app/widgets/AppBar/template_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:template_app/generated/l10n.dart'; // Importa las clases generadas

import '../../config.dart';
import '../../helpers/theme_notifier.dart';
import '../../providers/authorization_provider.dart';
import '../../widgets/ThemeTextField/theme_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  final int minPasswordLength = 6;
  bool _attemptingLogin = false;

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void attemptLogin(BuildContext context) async {
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
        ShowSnackbar.showSnackBar(
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
        ShowSnackbar.showSnackBar(
          message: S.of(context).invalidPasswordSnackbarMessage,
          variant: SnackbarVariant.error,
          duration: SnackbarDuration.short,
        );
        error = true;
      }

      debugPrint('Error: The following fields are empty: $emptyFields');

      ShowSnackbar.showSnackBar(
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
      ShowSnackbar.showSnackBar(
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

      ShowSnackbar.showSnackBar(
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 25),
        content: Text(S.of(context).signingInMessage),
      ),
    );

    try {
      await Provider.of<AuthorizationProvider>(context, listen: false)
          .signInWithEmail(_emailController.text, _passwordController.text);

      ShowSnackbar.showSnackBar(
        message: S.of(context).loginSuccessfulMessage,
        variant: SnackbarVariant.success,
        duration: SnackbarDuration.long,
      );
    } catch (error) {
      ShowSnackbar.showSnackBar(
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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthorizationProvider>(context);

    return Scaffold(
      appBar: Config.useTopAppBar
          ? TemplateAppBar(title: S.of(context).loginScreenTitle)
          : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                ThemeTextField(
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
                ThemeTextField(
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
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed:
                      _attemptingLogin ? null : () => attemptLogin(context),
                  child: Text(S.of(context).loginButton),
                ),
                const SizedBox(height: 25.0),
                Visibility(
                  visible: Config.allowGoogleSignIn,
                  child: SignInButton(Buttons.google,
                      padding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      text: S.of(context).signInWithGoogleButtonLabel,
                      onPressed: () async {
                    ShowSnackbar.showSnackBar(
                      message: S.of(context).signingInWithGoogleSnackbarMessage,
                      variant: SnackbarVariant.info,
                      duration: SnackbarDuration.long,
                    );

                    try {
                      await authProvider.signInWithGoogle();
                    } on PlatformException catch (error) {
                      ShowSnackbar.showSnackBar(
                        message: S
                            .of(context)
                            .errorSigningInWithGoogleSnackbarMessage,
                        variant: SnackbarVariant.error,
                        duration: SnackbarDuration.long,
                      );

                      debugPrint(
                          'Error signing in with Google: ${error.toString()}');
                    } catch (error) {
                      ShowSnackbar.showSnackBar(
                        message: S
                            .of(context)
                            .errorSigningInWithGoogleSnackbarMessage,
                        variant: SnackbarVariant.error,
                        duration: SnackbarDuration.long,
                      );
                      debugPrint('Error: ${error.toString()}');
                    }
                  }),
                ),
                const Divider(),
                Text(S.of(context).lightModeDarkMode),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme(value);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          S.load(const Locale('en'));
                        });
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
                        setState(() {
                          S.load(const Locale('es'));
                        });
                      },
                      child: const Text(
                        '🇪🇸',
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
}
