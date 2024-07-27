import 'package:flutter/material.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.kLightGreyColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.kPrimaryColor,
      onPrimary: AppColors.kWhiteColor,
      secondary: AppColors.kSecondaryColor,
    ),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.urbanist(
        color: AppColors.kPrimaryColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: GoogleFonts.urbanist(
        color: AppColors.kSecondaryColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.urbanist(
        color: AppColors.kTextFieldColor,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.kBlackColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kWhiteColor,
      onPrimary: AppColors.kPrimaryColor,
    ),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.urbanist(),
      bodyMedium: GoogleFonts.urbanist(),
      labelMedium: GoogleFonts.urbanist(),
    ),
  );
}
