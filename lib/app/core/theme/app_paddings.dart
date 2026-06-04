import 'package:flutter/material.dart';
import 'app_spacing.dart';

/// App Padding Tokens
///
/// Standardized edge insets for consistent spacing throughout the app.
class AppPaddings {
  AppPaddings._();

  /// Standard screen-edge padding (16px)
  static EdgeInsets get screen => EdgeInsets.all(AppSpacing.lg);

  /// Standard component padding (16px horizontal, 16px vertical)
  static EdgeInsets get component =>
      EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.lg);

  /// Small component padding (12px horizontal, 12px vertical)
  static EdgeInsets get componentSm =>
      EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md);

  /// Extra small component padding (8px)
  static EdgeInsets get componentXs => EdgeInsets.all(AppSpacing.sm);
}
