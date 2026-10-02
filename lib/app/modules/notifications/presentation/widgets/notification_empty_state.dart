import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 68.w,
            height: 68.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0).withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 32.sp,
              color: const Color(0xFF94A3B8),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'No notifications found',
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'You are all caught up with water meter alerts.',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
