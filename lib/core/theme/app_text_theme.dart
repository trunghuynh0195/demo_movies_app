import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// docs: https://api.flutter.dev/flutter/material/TextTheme-class.html

class AppTextTheme {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const xBold = FontWeight.w800;
  static const black = FontWeight.w900;

  static final TextTheme theme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontWeight: semiBold, fontSize: 57.0),
    displayMedium: GoogleFonts.poppins(fontWeight: semiBold, fontSize: 45.0),
    displaySmall: GoogleFonts.poppins(fontWeight: semiBold, fontSize: 36.0),
    //
    headlineLarge: GoogleFonts.poppins(fontWeight: bold, fontSize: 32.0),
    headlineMedium: GoogleFonts.poppins(fontWeight: bold, fontSize: 28.0),
    headlineSmall: GoogleFonts.poppins(fontWeight: bold, fontSize: 24.0),
    //
    titleLarge: GoogleFonts.poppins(fontWeight: bold, fontSize: 22.0),
    titleMedium: GoogleFonts.poppins(fontWeight: bold, fontSize: 16.0),
    titleSmall: GoogleFonts.poppins(fontWeight: bold, fontSize: 14.0),
    //
    labelLarge: GoogleFonts.poppins(fontWeight: medium, fontSize: 14.0),
    labelMedium: GoogleFonts.poppins(fontWeight: medium, fontSize: 12.0),
    labelSmall: GoogleFonts.poppins(fontWeight: medium, fontSize: 11.0),
    //
    bodyLarge: GoogleFonts.poppins(fontWeight: regular, fontSize: 16.0),
    bodyMedium: GoogleFonts.poppins(fontWeight: regular, fontSize: 14.0),
    bodySmall: GoogleFonts.poppins(fontWeight: regular, fontSize: 12.0),
  );
}
