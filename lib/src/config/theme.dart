import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  textTheme: GoogleFonts.nanumGothicTextTheme(),
  splashColor: Colors.amber,
  focusColor: Colors.amber,
  hintColor: Colors.grey,
  colorScheme: const ColorScheme.light().copyWith(
    primary: kPrimaryColor,
    background: const Color(0xFFFAF9F8),
    secondary: Colors.grey,
    onPrimary: Colors.white,
  ),
);

final msDarkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  textTheme: GoogleFonts.nanumGothicTextTheme().copyWith(
    bodyLarge: GoogleFonts.nanumGothicTextTheme().bodyLarge!.copyWith(
          color: Colors.white,
        ),
  ),
  splashColor: Colors.amber,
  focusColor: Colors.amber,
  hintColor: Colors.grey,
  colorScheme: const ColorScheme.light().copyWith(
    primary: kPrimaryColor,
    // background: const Color(0xFFFAF9F8),
    background: Colors.black,
    secondary: Colors.grey,
    onPrimary: Colors.white,
    surface: const Color(0xFF1C1C1D),
    onSurface: Colors.white,
  ),
);
