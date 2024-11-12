import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.getFont('Poppins').fontFamily,
    useMaterial3: true,
    appBarTheme: _appBarTheme(),
  );
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0XFF8B8B8B),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}
