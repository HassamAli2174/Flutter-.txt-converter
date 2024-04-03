import 'package:flutter/material.dart';

class AppTheme {
  static const Color dark = Color(0xFF1E1E1E);
  static const Color medium = Color(0x50FFFFFF);
  static const Color light = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFFFF500);
  static const Color blue = Color(0xFF267DEA);
  static const Color disabledbgButtoncolor = Colors.black12;
  static const Color disabledfgButtoncolor = Colors.white12;
  static const TextStyle inputStyle =
      TextStyle(color: light, fontSize: 20, fontFamily: 'Poppins');
  static const TextStyle hintStyle = TextStyle(color: medium);
  static const TextStyle counterStyle = TextStyle(color: medium, fontSize: 14);
  static const TextStyle splashStyle = TextStyle(
      color: blue,
      fontSize: 60,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500);
}
