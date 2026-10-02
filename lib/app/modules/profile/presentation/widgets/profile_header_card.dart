import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// User info card at the top of profile screen
class ProfileHeaderCard extends StatelessWidget {
  final ProfileController controller;
  final VoidCallback onEditTap;

  const ProfileHeaderCard({
    super.key,
    required this.controller,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 54.w,
            height: 54.w,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0E5C8A), Color(0xFF0284C7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                controller.userName.isNotEmpty
                    ? controller.userName[0].toUpperCase()
                    : 'U',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userName,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  controller.email,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  controller.phone,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEditTap,
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF0E5C8A),
            ),
          ),
        ],
      ),
    );
  }
}
