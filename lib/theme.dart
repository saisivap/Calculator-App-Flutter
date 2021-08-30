import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Color(0XFFF4F5F8),
    colorScheme: ColorScheme.light(
      primary: Colors.orange.shade300,
      secondary: Colors.purple.shade300,
    ),
  );
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0XFF35373B),
    colorScheme: ColorScheme.dark(
      primary: Colors.orange.shade600,
      secondary: Colors.purple.shade900,
    ),
  );
}
