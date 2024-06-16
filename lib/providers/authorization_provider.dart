import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template_app/utils/show_snackbar.dart';

import '../config.dart';

class AuthorizationProvider with ChangeNotifier {
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

  Future<void> logout() async {
    await clearAuthToken();
    if (Config.useFirebase) {
      await _firebaseAuth?.signOut(); // Sign out from Firebase if enabled
    }
  }

  bool get isAuthenticated => _authToken != null && _authToken!.isNotEmpty;

  // Email/Password Sign In methods
  Future<void> signInWithEmail(String email, String password) async {
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

      ShowSnackbar.showSnackBar(
        message: 'Signed in with email and password.',
        variant: SnackbarVariant.success,
        duration: SnackbarDuration.short,
      );

      notifyListeners();
    } catch (error) {
      debugPrint('Error during email/password Sign In: ${error.toString()}');

      ShowSnackbar.showSnackBar(
        message:
            'Error signing in with email and password: ${error.toString()}',
        variant: SnackbarVariant.error,
        duration: SnackbarDuration.short,
      );
    }
  }

  // Google Sign In methods
  Future<void> signInWithGoogle() async {
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
            // Non-Firebase Sign In
            _authToken =
                googleAuth.accessToken; // Use access token as auth token
            await setAuthToken(_authToken!);
          }

          ShowSnackbar.showSnackBar(
            message: 'Signed in with Google.',
            variant: SnackbarVariant.success,
            duration: SnackbarDuration.short,
          );

          notifyListeners();
        }
      } catch (error) {
        debugPrint('Error during Google Sign In: ${error.toString()}');

        ShowSnackbar.showSnackBar(
          message: 'Error signing in with Google: ${error.toString()}',
          variant: SnackbarVariant.error,
          duration: SnackbarDuration.short,
        );
      }
    }
  }
}
