import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Color(0xfff4d73c);

  static MaterialColor primarySwatch = MaterialColor(
    primaryColor.value, // The base color (must be the same as primaryColor)
    <int, Color>{
      50: Color(0xFFfefbec),   // 10%
      100: Color(0xFFfdf7d8),  // 20%
      200: Color(0xFFfdf7d8),  // 30%
      300: Color(0xFFfbefb1),  // 40%
      400: Color(0xFFfaeb9e),  // 50%
      500: Color(0xFFf8e78a),  // 60%
      600: Color(0xFFf7e377),  // 70%
      700: Color(0xFFf6df63),  // 80%
      800: Color(0xFFf5db50),  // 90%
      900: Color(0xFFf4d73c),  // 100%
    },
  );


}
