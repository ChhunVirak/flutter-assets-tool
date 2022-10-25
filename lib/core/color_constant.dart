import 'package:flutter/material.dart';

class MaterialColors {
  MaterialColor materialtheme =
      const MaterialColor(_materialthemePrimaryValue, <int, Color>{
    50: Color(0xFFEEE0E5),
    100: Color(0xFFD4B3BF),
    200: Color(0xFFB78094),
    300: Color(0xFF9A4D69),
    400: Color(0xFF852649),
    500: Color(_materialthemePrimaryValue),
    600: Color(0xFF670024),
    700: Color(0xFF5C001F),
    800: Color(0xFF520019),
    900: Color(0xFF40000F),
  });
  static const int _materialthemePrimaryValue = 0xFF6F0029;
}

const Color kPrimary = Color(0xff6f0029);
