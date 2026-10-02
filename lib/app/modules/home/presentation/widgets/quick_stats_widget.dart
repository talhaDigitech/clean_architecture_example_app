import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickStatsWidget extends StatelessWidget {
  final MeterEntity meter;

  const QuickStatsWidget({super.key, required this.meter});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Statistics',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12.h),

        // 2x2 Grid of Stat Cards
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: "Today's Usage",
                value: '${meter.deviceCurrentData.toStringAsFixed(2)} m³',
                subtitle: 'Live consumption',
                icon: Icons.today_outlined,
                color: const Color(0xFF0284C7),
                bg: const Color(0xFFE0F2FE),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _StatCard(
                title: 'Last Reading',
                value: '${meter.deviceLastData.toStringAsFixed(2)} m³',
                subtitle: 'Previous billing',
                icon: Icons.history_outlined,
                color: const Color(0xFF6366F1),
                bg: const Color(0xFFEEF2FF),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Cycle Usage',
                value: '${meter.deviceSettleDayData.toStringAsFixed(2)} m³',
                subtitle: 'Current billing period',
                icon: Icons.pie_chart_outline,
                color: const Color(0xFF0D9488),
                bg: const Color(0xFFCCFBF1),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _StatCard(
                title: 'Settlement Day',
                value: meter.deviceSettleDay,
                subtitle: 'Billing reset date',
                icon: Icons.calendar_month_outlined,
                color: const Color(0xFFD97706),
                bg: const Color(0xFFFEF3C7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bg;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: bg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 14.sp, color: color),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.sp,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
