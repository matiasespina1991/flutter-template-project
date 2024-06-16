// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "_locale": MessageLookupByLibrary.simpleMessage("es"),
        "email": MessageLookupByLibrary.simpleMessage("email"),
        "emailHintText": MessageLookupByLibrary.simpleMessage("Email"),
        "emailLabel": MessageLookupByLibrary.simpleMessage("EMAIL"),
        "invalidEmailMessage": MessageLookupByLibrary.simpleMessage(
            "Inserte un correo electrónico válido, por favor."),
        "invalidEmailSnackbarMessage": MessageLookupByLibrary.simpleMessage(
            "El correo electrónico insertado no es válido."),
        "invalidPasswordMessage": MessageLookupByLibrary.simpleMessage(
            "Inserte una contraseña válida, por favor."),
        "invalidPasswordSnackbarMessage": MessageLookupByLibrary.simpleMessage(
            "La contraseña insertada no es válida."),
        "invalidPasswordTooShortMessage": MessageLookupByLibrary.simpleMessage(
            "La contraseña debe tener al menos 6 caracteres."),
        "lightModeDarkMode":
            MessageLookupByLibrary.simpleMessage("Modo claro / modo oscuro"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "loginErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Error al iniciar sesión. Por favor, inténtelo de nuevo o contacte con el soporte."),
        "loginScreenTitle":
            MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "loginSuccessfulMessage":
            MessageLookupByLibrary.simpleMessage("Inicio de sesión exitoso!"),
        "password": MessageLookupByLibrary.simpleMessage("contraseña"),
        "passwordHintText": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("CONTRASEÑA"),
        "pleaseFillTheFollowingFields": MessageLookupByLibrary.simpleMessage(
            "Por favor, rellene los siguientes campos:"),
        "signingInMessage":
            MessageLookupByLibrary.simpleMessage("Iniciando sesión...")
      };
}
