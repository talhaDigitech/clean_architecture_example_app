import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum StatusBadgeType { success, warning, error, info, neutral }

/// Reusable status badge/chip used across the entire Winmeter application.
class StatusBadge extends StatelessWidget {
  final String label;
  final StatusBadgeType type;
  final IconData? icon;
  final bool showDot;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const StatusBadge({
    super.key,
    required this.label,
    this.type = StatusBadgeType.neutral,
    this.icon,
    this.showDot = true,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor;
    Color bgColor;
    Color borderColor;

    switch (type) {
      case StatusBadgeType.success:
        primaryColor = const Color(0xFF10B981);
        bgColor = const Color(0xFFECFDF5);
        borderColor = const Color(0xFFA7F3D0);
        break;
      case StatusBadgeType.warning:
        primaryColor = const Color(0xFFD97706);
        bgColor = const Color(0xFFFEF3C7);
        borderColor = const Color(0xFFFCD34D);
        break;
      case StatusBadgeType.error:
        primaryColor = const Color(0xFFEF4444);
        bgColor = const Color(0xFFFEF2F2);
        borderColor = const Color(0xFFFCA5A5);
        break;
      case StatusBadgeType.info:
        primaryColor = const Color(0xFF0E5C8A);
        bgColor = const Color(0xFFEFF6FF);
        borderColor = const Color(0xFFBFDBFE);
        break;
      case StatusBadgeType.neutral:
        primaryColor = const Color(0xFF64748B);
        bgColor = const Color(0xFFF8FAFC);
        borderColor = const Color(0xFFE2E8F0);
        break;
    }

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: (fontSize ?? 10.sp) + 2, color: primaryColor),
            SizedBox(width: 4.w),
          ] else if (showDot) ...[
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 5.w),
          ],
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize ?? 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                color: primaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
