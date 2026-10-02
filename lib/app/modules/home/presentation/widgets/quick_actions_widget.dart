import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActionsWidget extends StatelessWidget {
  final VoidCallback onRechargeTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onReportsTap;
  final VoidCallback onSettingsTap;

  const QuickActionsWidget({
    super.key,
    required this.onRechargeTap,
    required this.onHistoryTap,
    required this.onReportsTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ActionButton(
              title: 'Recharge',
              icon: Icons.account_balance_wallet_outlined,
              color: const Color(0xFF0E5C8A),
              bg: const Color(0xFFE0F2FE),
              onTap: onRechargeTap,
            ),
            _ActionButton(
              title: 'History',
              icon: Icons.insights_outlined,
              color: const Color(0xFF10B981),
              bg: const Color(0xFFECFDF5),
              onTap: onHistoryTap,
            ),
            _ActionButton(
              title: 'Reports',
              icon: Icons.description_outlined,
              color: const Color(0xFFF59E0B),
              bg: const Color(0xFFFFFBEB),
              onTap: onReportsTap,
            ),
            _ActionButton(
              title: 'Settings',
              icon: Icons.tune_outlined,
              color: const Color(0xFF6366F1),
              bg: const Color(0xFFEEF2FF),
              onTap: onSettingsTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: color, size: 20.sp),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }
}
