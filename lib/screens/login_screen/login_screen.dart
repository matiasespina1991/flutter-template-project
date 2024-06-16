import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:template_app/utils/show_snackbar.dart';
import 'package:template_app/widgets/AppBar/template_app_bar.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../helpers/theme_notifier.dart';
import '../../providers/authorization_provider.dart';

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
  bool _isPasswordVisible = false;
  bool _attemptingLogin = false;

  bool isEmailValid(String email) {
    // A simple email validation logic
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void attemptLogin(BuildContext context) async {
    setState(() {
      _isEmailValid = true;
      _isPasswordValid = true;
    });

    if (!isEmailValid(_emailController.text)) {
      setState(() {
        _isEmailValid = false;
      });
    }

    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < minPasswordLength) {
      setState(() {
        _isPasswordValid = false;
      });
    }

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      List<String> emptyFields = [];
      if (_emailController.text.isEmpty) {
        emptyFields.add('email');
      }
      if (_passwordController.text.isEmpty) {
        emptyFields.add('password');
      }

      debugPrint('Error: The following fields are empty: $emptyFields');

      ShowSnackbar.showSnackBar(
        message: 'Please fill the following fields: ${emptyFields.join(', ')}',
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.long,
      );
      return;
    }

    if (!isEmailValid(_emailController.text)) {
      debugPrint('Email is not valid');
      ShowSnackbar.showSnackBar(
        message: 'Please insert a valid email',
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.long,
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      debugPrint('Please insert a valid password');
      ShowSnackbar.showSnackBar(
        message: 'Please insert a valid email',
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.long,
      );
      return;
    }

    setState(() {
      _attemptingLogin = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 25),
        content: Text(
          'Trying to login...',
        ),
      ),
    );

    try {
      await Provider.of<AuthorizationProvider>(context, listen: false)
          .signInWithEmail(_emailController.text, _passwordController.text);

      ShowSnackbar.showSnackBar(
        message: 'Login successful!',
        variant: SnackbarVariant.success,
        duration: SnackbarDuration.long,
      );
    } catch (error) {
      ShowSnackbar.showSnackBar(
        message: 'Error logging in. Please try again or contact support.',
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
          ? const TemplateAppBar(
              title: 'Login screen',
            )
          : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'EMAIL ADDRESS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  onChanged: (value) {
                    if (isEmailValid(value)) {
                      setState(() {
                        _isEmailValid = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Email',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    errorText:
                        _isEmailValid ? null : 'Please insert a valid email',
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.lock_outline),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'PASSWORD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length >= minPasswordLength) {
                      setState(() {
                        _isPasswordValid = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Password',
                    errorText: _isPasswordValid
                        ? null
                        : 'Please insert a valid password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                ),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed:
                      _attemptingLogin ? null : () => attemptLogin(context),
                  child: Text('Login'),
                ),
                const SizedBox(height: 25.0),
                Visibility(
                  visible: Config.allowGoogleSignIn,
                  child: SignInButton(Buttons.google, onPressed: () async {
                    ShowSnackbar.showSnackBar(
                      message: 'Signing in with Google...',
                      variant: SnackbarVariant.info,
                      duration: SnackbarDuration.long,
                    );

                    try {
                      await authProvider.signInWithGoogle();
                    } on PlatformException catch (error) {
                      ShowSnackbar.showSnackBar(
                        message:
                            'There was an error signing in with Google. Please try again or contact support.',
                        variant: SnackbarVariant.error,
                        duration: SnackbarDuration.long,
                      );

                      debugPrint(
                          'Error signing in with Google: ${error.toString()}');
                    } catch (error) {
                      ShowSnackbar.showSnackBar(
                        message:
                            'There was an error signing in with Google. Please try again or contact support.',
                        variant: SnackbarVariant.error,
                        duration: SnackbarDuration.long,
                      );
                      debugPrint('Error: ${error.toString()}');
                    }
                  }),
                ),
                const Divider(),
                const Text(
                  'Light Mode/Dark Mode',
                ),
                Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
