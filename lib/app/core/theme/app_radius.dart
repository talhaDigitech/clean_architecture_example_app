import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Radius Tokens
class AppRadius {
  AppRadius._();

  /// 4px radius
  static double get xs => 4.r;

  /// 8px radius
  static double get sm => 8.r;

  /// 12px radius
  static double get md => 12.r;

  /// 16px radius
  static double get lg => 16.r;

  /// 24px radius
  static double get xl => 24.r;

  /// 100px radius (Stadium)
  static double get full => 100.r;

  // BorderRadius helpers
  static BorderRadius get brXs => BorderRadius.circular(xs);
  static BorderRadius get brSm => BorderRadius.circular(sm);
  static BorderRadius get brMd => BorderRadius.circular(md);
  static BorderRadius get brLg => BorderRadius.circular(lg);
  static BorderRadius get brXl => BorderRadius.circular(xl);
  static BorderRadius get brFull => BorderRadius.circular(full);
}
