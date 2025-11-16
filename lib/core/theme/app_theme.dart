import 'package:flutter/material.dart';

class AppTheme {

  static const Color ink = Color(0xFF0B0B0B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF7F7F7);
  static const Color mutedDivider = Color(0xFFEEEEEE);
  static const Color mutedText = Color(0xDD000000);


  static const Color logoPurple = Color(0xFF7B4BFF);
  static const Color accentPurple = Color(0xFF9F7CFA);
  static const Color lighterPurple = Color(0xFFCAB7FA);
  static const Color accentPink = Color(0xFFE862FD);
  static const Color surfaceDeep = Color(0xFF17121B);


  //snackbar helper colors
  static const Color successColor = Color(0xFF2E7D32);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFED6C02);



  static ThemeData lightTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      brightness: Brightness.light,


      primaryColor: ink,
      scaffoldBackgroundColor: white,
      canvasColor: white,
      cardColor: surface,


      colorScheme: ColorScheme.light(
        primary: ink,
        onPrimary: white,
        secondary: ink,
        onSecondary: white,
        surface: surface,
        background: white,
        onBackground: ink,
        onSurface: ink,
        error: Colors.red.shade700,
      ),

      // Text
      textTheme: base.textTheme.apply(
        bodyColor: mutedText,
        displayColor: mutedText,
      ),


      appBarTheme: AppBarTheme(
        color: white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ink),
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: ink,
          fontWeight: FontWeight.w700,
        ),
      ),


      dividerColor: mutedDivider,
      shadowColor: Colors.black.withOpacity(0.06),


      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ink,
          foregroundColor: white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0x1F0B0B0B)), // subtle black outline (~12%)
          foregroundColor: ink,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ink),
      ),


      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: Colors.black54),
        labelStyle: TextStyle(color: ink),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mutedDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mutedDivider),
        ),
      ),


      iconTheme: const IconThemeData(color: ink),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ink,
        foregroundColor: white,
      ),
    );
  }


  static ThemeData darkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: ink,
      scaffoldBackgroundColor: logoPurple,
      canvasColor: surfaceDeep,
      cardColor: surfaceDeep,
      shadowColor: Colors.black.withOpacity(0.6),
      colorScheme: ColorScheme.dark(
        primary: ink,
        onPrimary: Colors.white,
        secondary: accentPink,
        onSecondary: Colors.white,
        surface: surfaceDeep,
        background: logoPurple,
        onBackground: Colors.white,
        error: Colors.red.shade400,
        onSurface: Colors.white,
      ),
      dividerColor: accentPink.withOpacity(0.25),
      textTheme: base.textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
      appBarTheme: AppBarTheme(
        color: logoPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: base.textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ink,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: accentPink.withOpacity(0.9)),
          foregroundColor: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: accentPink)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        hintStyle: TextStyle(color: Colors.white70),
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: accentPink, foregroundColor: Colors.white),
    );
  }
}
