import 'package:flutter/material.dart';

class AppTheme {
  static const Color nightBlue = Color(0xFF0A1B3D);
  static const Color skyBlue = Color(0xFF3FA9F5);
  static const Color orange = Color(0xFFFF7A00);

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: nightBlue,
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    colorScheme: ColorScheme.fromSeed(seedColor: skyBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: nightBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: orange),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: nightBlue,
    scaffoldBackgroundColor: const Color(0xFF08122A),
    colorScheme: ColorScheme.fromSeed(
      seedColor: skyBlue,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF08122A),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: orange),
  );
}
