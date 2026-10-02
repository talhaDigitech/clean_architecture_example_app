import 'package:clean_architecture_example_app/app/core/theme/app_colors.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? buttonWidth;
  final double? buttonHeight;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
    this.buttonWidth,
    this.buttonHeight,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = buttonHeight ?? 48.h;
    final effectiveWidth = buttonWidth ?? double.infinity;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12.r);
    final effectiveBgColor = backgroundColor ?? AppColors.primary;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          disabledBackgroundColor: effectiveBgColor.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: effectiveRadius,
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.h,
                height: 22.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    buttonText,
                    style: textStyle ??
                        AppTypography.labelLarge.copyWith(
                          color: textColor ?? Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
