import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsageSummaryGrid extends StatelessWidget {
  final double totalUsage;
  final double dailyAverage;
  final String peakDayLabel;
  final double peakDayValue;
  final String comparisonText;

  const UsageSummaryGrid({
    super.key,
    required this.totalUsage,
    required this.dailyAverage,
    required this.peakDayLabel,
    required this.peakDayValue,
    required this.comparisonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Total Usage',
                value: '${totalUsage.toStringAsFixed(2)} m³',
                subtitle: 'Selected period volume',
                icon: Icons.water_drop_outlined,
                accentColor: const Color(0xFF0E5C8A),
                bgColor: const Color(0xFFF0F9FF),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _MetricCard(
                title: 'Daily Average',
                value: '${dailyAverage.toStringAsFixed(2)} m³',
                subtitle: 'Per day run-rate',
                icon: Icons.speed_outlined,
                accentColor: const Color(0xFF0284C7),
                bgColor: const Color(0xFFF0FDF4),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Highest Day',
                value: '${peakDayValue.toStringAsFixed(2)} m³',
                subtitle: 'Peak ($peakDayLabel)',
                icon: Icons.show_chart_rounded,
                accentColor: const Color(0xFFF59E0B),
                bgColor: const Color(0xFFFFFBEB),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _MetricCard(
                title: 'Period Variance',
                value: '+8.4%',
                subtitle: comparisonText,
                icon: Icons.trending_up_rounded,
                accentColor: const Color(0xFF10B981),
                bgColor: const Color(0xFFECFDF5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final Color bgColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 14.sp, color: accentColor),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.sp,
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
