import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF9d02ff);
  static const primaryLight = Color(0xFFF9B382);
  static const accentDark = Color(0xFF64241C);
  static const complement = Color(0xFFACAC4C);
  static const neutralLight = Color(0xFFCFB4B0);
  static const textDark = Color(0xFF2D2D2D);
  static const white = Colors.white;
  static const black = Colors.black;
  static const border = Colors.grey;
  static const hintText = Colors.grey;
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.neutralLight,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.complement,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.russoOne(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white, // or your custom AppColors
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textDark,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textDark,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    labelStyle: TextStyle(color: AppColors.textDark),
  ),
);
