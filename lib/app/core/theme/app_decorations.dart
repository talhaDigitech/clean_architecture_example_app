import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';

/// App Decorations
///
/// Reusable decoration tokens for containers and components.
class AppDecorations {
  AppDecorations._();

  /// Standard outline decoration used for inputs and selectors.
  static BoxDecoration get outline => BoxDecoration(
    border: Border.all(color: AppColors.disabled, width: 1),
    borderRadius: AppRadius.brSm,
    color: AppColors.backgroundPrimary,
  );

  /// InputDecoration
  static InputDecoration get input => InputDecoration(
    border: OutlineInputBorder(
      borderRadius: AppRadius.brSm,
      borderSide: BorderSide(color: AppColors.disabled, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.brSm,
      borderSide: BorderSide(color: AppColors.disabled, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.brSm,
      borderSide: BorderSide(color: AppColors.disabled, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.brSm,
      borderSide: BorderSide(color: AppColors.disabled, width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.brSm,
      borderSide: BorderSide(color: AppColors.disabled, width: 1),
    ),
  );

  /// Shadow decoration for cards and elevated components.
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
}
