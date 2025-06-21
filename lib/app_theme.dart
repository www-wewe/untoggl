import 'package:flutter/material.dart';

final ThemeData appThemeDark = ThemeData(
  useMaterial3: true,

  // Brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple, // Use this to generate a palette
    brightness: Brightness.dark,
    primary: Colors.purpleAccent,
    secondary: Colors.blueAccent[700],
  ),

  // Default font family.
  fontFamily: 'Roboto',

  // ElevatedButton theme.
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Button corner radius
      ),
    ),
  ),

  // Input decoration for `TextField`.
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // Input field corner radius
      borderSide: const BorderSide(color: Colors.purpleAccent),
    ),
    labelStyle: const TextStyle(color: Colors.lightBlueAccent),
  ),

  // AppBarTheme
  appBarTheme: const AppBarTheme(
    color: Colors.purple,
    elevation: 0, // Removes the shadow from the app bar.
  ),
);

// Color values from: https://appsinter.dev/
final ThemeData appThemeLight = ThemeData(
  useMaterial3: true,

  // Brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple, // Use this to generate a palette
    brightness: Brightness.light,
    primary: const Color(0xff9a25ae),
    secondary: const Color(0xff6b586b),
  ),

  // Default font family.
  fontFamily: 'Roboto',

  // ElevatedButton theme.
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Button corner radius
      ),
    ),
  ),

  // Input decoration for `TextField`.
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // Input field corner radius
      borderSide: const BorderSide(color: Color(0xff9a25ae)),
    ),
    labelStyle: const TextStyle(color: Color(0xff6b586b)),
  ),

  // AppBarTheme
  appBarTheme: const AppBarTheme(
    color: Colors.purple,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    elevation: 0, // Removes the shadow from the app bar.
  ),
);
