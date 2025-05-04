import 'dart:ui';

import 'package:flutter/material.dart';
import 'pages/homepage.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   MaterialColor customGreen = MaterialColor(
    0xFF3FB950,
    <int, Color>{
      50: Color(0xFFE3F6E8),
      100: Color(0xFFC8EFD2),
      200: Color(0xFFA9E7B9),
      300: Color(0xFF89DE9F),
      400: Color(0xFF70D98C),
      500: Color(0xFF3FB950), // اللون الأساسي
      600: Color(0xFF3AAC4B),
      700: Color(0xFF339644),
      800: Color(0xFF2C803C),
      900: Color(0xFF205E2D),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customGreen,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 2.5,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          )
        )
      ),
      home: Homepage()
    );
  }
}
