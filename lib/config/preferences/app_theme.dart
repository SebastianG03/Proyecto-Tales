import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static const Color selected = Color(0xFFD93668);
  static const Color enableOutlineBorder = Colors.black;
  static const Color focusOutlineBorder = Color(0xFF0DC3E8);
  static const Color errorOutlineBorder = Color.fromARGB(255, 208, 9, 9);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade400),
      buttonTheme: const ButtonThemeData(
        padding: EdgeInsets.all(15),
        splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enableOutlineBorder),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusOutlineBorder),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorOutlineBorder),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
        ),
      ));
}
