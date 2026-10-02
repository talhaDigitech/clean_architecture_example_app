import 'package:clean_architecture_example_app/app/core/theme/app_colors.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPasswordField;
  final bool isForgotPasswordTextShow;
  final VoidCallback? onForgotPassword;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final AutovalidateMode autovalidateMode;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.inputFormatters,
    this.isPasswordField = false,
    this.isForgotPasswordTextShow = false,
    this.onForgotPassword,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label!,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                ),
              ),
              if (widget.isForgotPasswordTextShow)
                GestureDetector(
                  onTap: widget.onForgotPassword,
                  child: Text(
                    "Forgot Password?",
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.isPasswordField ? _obscureText : false,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          autovalidateMode: widget.autovalidateMode,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            prefixIcon: widget.prefix ??
                (widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: AppColors.textSecondary,
                        size: 20.sp,
                      )
                    : null),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
