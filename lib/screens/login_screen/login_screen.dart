import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:template_app/utils/show_snackbar.dart';
import 'package:template_app/widgets/AppBar/template_app_bar.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../providers/authorization_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthorizationProvider>(context); // assuming Provider usage

    return Scaffold(
      appBar: const TemplateAppBar(
        title: 'Login',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login',
            ),
            Visibility(
              visible: Config.allowGoogleSignIn, // show button only if allowed
              child: SignInButton(Buttons.google, onPressed: () async {
                ShowSnackbar.showSnackBar(
                  message: 'Signing in with Google...',
                  variant: SnackbarVariant.info,
                  duration: SnackbarDuration.long,
                );

                try {
                  await authProvider.signInWithGoogle();
                } on PlatformException catch (error) {
                  if (error.code == 'google_sign_in') {
                    ShowSnackbar.showSnackBar(
                      message:
                          'There was an error signing in with Google. Please try again or contact support.',
                      variant: SnackbarVariant.error,
                      duration: SnackbarDuration.long,
                    );

                    debugPrint(
                        'Error signing in with Google: ${error.toString()}');
                  } else {
                    ShowSnackbar.showSnackBar(
                      message:
                          'There was an error signing in with Google. Please try again or contact support.',
                      variant: SnackbarVariant.error,
                      duration: SnackbarDuration.long,
                    );
                    debugPrint('Unexpected error: ${error.toString()}');
                  }
                } catch (error) {
                  ShowSnackbar.showSnackBar(
                    message:
                        'There was an error signing in with Google. Please try again or contact support.',
                    variant: SnackbarVariant.error,
                    duration: SnackbarDuration.long,
                  );
                  // Handle other non-PlatformException errors
                  debugPrint('Error: ${error.toString()}');
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
