import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A compact, sleek confirmation dialog component for Winmeter.
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final IconData? icon;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmColor = const Color(0xFFEF4444),
    this.icon,
    this.onCancel,
  });

  /// Helper static method to show the dialog cleanly
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color confirmColor = const Color(0xFFEF4444),
    IconData? icon,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor: confirmColor,
        icon: icon,
        onConfirm: () {
          Navigator.of(ctx).pop(true);
          onConfirm();
        },
        onCancel: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 6,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 42.w),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                if (icon != null) ...[
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: confirmColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 18.sp, color: confirmColor),
                  ),
                  SizedBox(width: 10.w),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Message text (compact and readable)
            Text(
              message,
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),

            SizedBox(height: 18.h),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onCancel ?? () => Navigator.of(context).pop(false),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    minimumSize: Size(0, 36.h),
                  ),
                  onPressed: onConfirm,
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
