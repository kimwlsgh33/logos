import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//================================================
// Colors
//================================================
const kPrimaryColor = Color(0xFF366CF6);
//================================================
// Theme
//================================================
final msLightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xFFFAF9F8),
  textTheme: GoogleFonts.nanumGothicTextTheme(),
  splashColor: Colors.amber,
  focusColor: Colors.amber,
  colorScheme: const ColorScheme.light().copyWith(
    primary: kPrimaryColor,
    background: const Color(0xFFFAF9F8),
    secondary: Colors.grey,
    onPrimary: Colors.white,
  ),
);
final msDarkTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
);
