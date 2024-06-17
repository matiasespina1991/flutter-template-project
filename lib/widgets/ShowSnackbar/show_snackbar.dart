import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config.dart';
import '../../globals.dart';

class SnackbarDuration {
  static const String short = 'short';
  static const String long = 'long';
}

class SnackbarVariant {
  static const String error = 'error';
  static const String success = 'success';
  static const String info = 'info';
}

class ShowSnackbar {
  static void showSnackBar({
    required String message,
    required String variant,
    required String duration,
  }) {
    if (Config.useFlutterToast) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: duration == SnackbarDuration.long
            ? Toast.LENGTH_LONG
            : Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: duration == SnackbarDuration.long ? 3 : 2,
        backgroundColor: variant == SnackbarVariant.success
            ? Config.snackBarSuccessBackgroundColor
            : variant == SnackbarVariant.info
                ? Config.snackBarInfoBackgroundColor
                : Config.snackBarErrorBackgroundColor,
        textColor: Config.snackBarErrorTextColor,
        fontSize: Config.snackbarFontSize,
      );
      return;
    }

    snackbarKey.currentState?.showSnackBar(SnackBar(
      duration: duration == SnackbarDuration.short
          ? const Duration(seconds: 2)
          : const Duration(seconds: 5),
      backgroundColor: variant == SnackbarVariant.success
          ? Config.snackBarSuccessBackgroundColor
          : variant == SnackbarVariant.info
              ? Config.snackBarInfoBackgroundColor
              : Config.snackBarErrorBackgroundColor,
      content: Text(message,
          style: TextStyle(
              color: variant == SnackbarVariant.success
                  ? Config.snackBarSuccessTextColor
                  : variant == SnackbarVariant.info
                      ? Config.snackBarInfoTextColor
                      : Config.snackBarErrorTextColor,
              fontSize: Config.snackbarFontSize)),
    ));
  }

  static void hideCurrentSnackBar() {
    if (Config.useFlutterToast) {
      Fluttertoast.cancel();
      return;
    }
    snackbarKey.currentState?.hideCurrentSnackBar();
  }
}
