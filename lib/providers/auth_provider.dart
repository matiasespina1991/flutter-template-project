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
