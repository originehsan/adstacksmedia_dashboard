import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_radius.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.pageBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        surface: AppColors.cardBg,
        error: AppColors.danger,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        color: AppColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side:  BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: AppColors.transparent,
      ),
      inputDecorationTheme:const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.borderLight,
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide:  BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide:  BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide:  BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        contentPadding:  EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        hintStyle:  TextStyle(
          fontSize: 13,
          color: AppColors.textMuted,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape:const RoundedRectangleBorder(
            borderRadius: AppRadius.mdAll,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.mdAll,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.border),
        trackColor: WidgetStateProperty.all(AppColors.borderLight),
        radius: const Radius.circular(AppRadius.lg),
        thickness: WidgetStateProperty.all(4),
      ),
    );
  }
}