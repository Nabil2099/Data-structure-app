import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF0C8159);
  static const Color accentGreen = Color(0xFF3FB950);
  static const Color darkBackground = Color(0xFF121212);
  static const Color cardDark = Color(0xFF181A1B);
  static const Color cardDark2 = Color(0xFF232323);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: accentGreen,
        secondary: primaryGreen,
        surface: cardDark,
        background: darkBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        elevation: 2.5,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardDark,
        selectedItemColor: accentGreen,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
