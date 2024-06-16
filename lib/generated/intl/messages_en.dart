// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "_locale": MessageLookupByLibrary.simpleMessage("en"),
        "email": MessageLookupByLibrary.simpleMessage("email"),
        "emailHintText": MessageLookupByLibrary.simpleMessage("Email"),
        "emailLabel": MessageLookupByLibrary.simpleMessage("EMAIL"),
        "invalidEmailMessage": MessageLookupByLibrary.simpleMessage(
            "Please insert a valid email."),
        "invalidEmailSnackbarMessage": MessageLookupByLibrary.simpleMessage(
            "The email address inserted is not valid."),
        "invalidPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "Please insert a valid password."),
        "invalidPasswordSnackbarMessage": MessageLookupByLibrary.simpleMessage(
            "The password inserted is not valid."),
        "invalidPasswordTooShortMessage": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 6 characters long."),
        "lightModeDarkMode":
            MessageLookupByLibrary.simpleMessage("Light Mode/Dark Mode"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
        "loginErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Error logging in. Please try again or contact support."),
        "loginScreenTitle":
            MessageLookupByLibrary.simpleMessage("Login screen"),
        "loginSuccessfulMessage":
            MessageLookupByLibrary.simpleMessage("Login successful!"),
        "password": MessageLookupByLibrary.simpleMessage("password"),
        "passwordHintText": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("PASSWORD"),
        "pleaseFillTheFollowingFields": MessageLookupByLibrary.simpleMessage(
            "Please fill the following fields:"),
        "signingInMessage":
            MessageLookupByLibrary.simpleMessage("Signing in...")
      };
}