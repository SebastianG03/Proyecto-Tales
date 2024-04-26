import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      elevation: 1.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.grey.shade400,
    ));
  }
}
