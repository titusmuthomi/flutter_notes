import 'package:flutter/material.dart';

ThemeData AppTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    cardColor: Themed.white,
    indicatorColor: Themed.primaryColor,
    shadowColor: Themed.shadow,
    splashColor: Themed.primaryColor,
    hintColor: Themed.primaryColor,
    iconTheme: const IconThemeData(color: Themed.primaryColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Themed.primaryColor),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Themed.primaryColor,
        actionTextColor: Themed.accentColor,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: TextStyle(color: Themed.white)),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Themed.primaryColor),
      prefixIconColor: Themed.primaryColor,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themed.primaryColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themed.accentColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themed.errorColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      errorStyle: TextStyle(
        color: Themed.errorColor,
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themed.primaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Themed.primaryColor))),
  );
}

final primaryColor = Color.fromARGB(255, 5, 61, 63);

class Themed {
  static const Color primaryColor = Color.fromARGB(255, 13, 71, 161);
  static const Color secondaryColor = Color.fromARGB(255, 15, 2, 2);
  static const Color shadow = Color.fromARGB(255, 247, 137, 43);
  static const Color errorColor = Color.fromARGB(255, 220, 14, 14);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color yellow = Colors.yellow;
  static const Color accentColor = Colors.deepOrange;
}

class AuthStyle {
  static const hintDark = TextStyle(
      color: Themed.primaryColor, fontWeight: FontWeight.w700, fontSize: 25);
  static const hintLight = TextStyle(fontSize: 20, color: Themed.primaryColor);

  static const forgotPass = TextStyle(
      color: Themed.accentColor,
      decoration: TextDecoration.underline,
      fontSize: 20);

  static const switchPage = TextStyle(
    fontSize: 15,
    color: Themed.accentColor,
    decoration: TextDecoration.underline,
  );
  static const authprivacy = TextStyle(
      color: Themed.black, decoration: TextDecoration.underline, fontSize: 10);
}

class FormStyle {
  static const InputDecoration authDark = InputDecoration(
    hintStyle: TextStyle(color: Themed.white),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Themed.white, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Themed.yellow, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.yellow, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  static const authLight = InputDecoration(
    labelStyle: TextStyle(color: Themed.primaryColor),
    label: Text(
      'Email',
      style: TextStyle(),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.primaryColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.accentColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.errorColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    errorStyle: TextStyle(
      color: Themed.errorColor,
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.primaryColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
  );

  static const feedbackinputdecoration = InputDecoration(
    labelStyle: TextStyle(color: Themed.white),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.white, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.white, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.errorColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    errorStyle: TextStyle(
      color: Themed.errorColor,
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.shadow, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
  );

// Reset Email
  static const restEmailDecoration = InputDecoration(
    labelStyle: TextStyle(color: Themed.white),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.white, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.white, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.accentColor, width: 3.0),
    ),
    errorStyle: TextStyle(
      color: Themed.white,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow, width: 2.0),
    ),
  );

  static const profileInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Themed.primaryColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.primaryColor, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.errorColor, width: 2.0),
    ),
    errorStyle: TextStyle(
      color: Themed.errorColor,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Themed.shadow, width: 2.0),
    ),
  );

// Create Post Style
  static const addPostDecoration = InputDecoration(
    labelStyle: TextStyle(color: Themed.black),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.primaryColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.primaryColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.accentColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    errorStyle: TextStyle(
      color: Themed.black,
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Themed.accentColor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
  );
}

class BorderSyle {
  static const round = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)));
}

class IconStyle {}
