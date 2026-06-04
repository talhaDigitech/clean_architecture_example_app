import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

/// App Typography Tokens
class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Lexend';

  // Display
  static TextStyle get displayLarge => TextStyle(
    fontSize: 57.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
  );

  static TextStyle get displayMedium => TextStyle(
    fontSize: 45.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );

  static TextStyle get displaySmall => TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );

  // Headline
  static TextStyle get headlineLarge => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.2,
  );

  // Title
  static TextStyle get titleLarge => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  // Body
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );

  // Label
  static TextStyle get labelLarge => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );
}
