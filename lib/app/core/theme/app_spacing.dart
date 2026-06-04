import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App Spacing Tokens
class AppSpacing {
  AppSpacing._();

  /// 2px spacing
  static double get xxs => 2.w;

  /// 4px spacing
  static double get xs => 4.w;

  /// 8px spacing
  static double get sm => 8.w;

  /// 12px spacing
  static double get md => 12.w;

  /// 16px spacing
  static double get lg => 16.w;

  /// 20px spacing
  static double get mlg => 20.w;

  /// 24px spacing
  static double get xl => 24.w;

  /// 32px spacing
  static double get xxl => 32.w;

  /// 48px spacing
  static double get huge => 48.w;

  /// 64px spacing
  static double get giant => 64.w;

  // Vertical variants for clarity in some contexts
  static double get vxxs => 2.h;
  static double get vxs => 4.h;
  static double get vsm => 8.h;
  static double get vmd => 12.h;
  static double get vlg => 16.h;
  static double get vxl => 24.h;
  static double get vxxl => 32.h;
  static double get vhuge => 48.h;
  static double get vgiant => 64.h;
}
