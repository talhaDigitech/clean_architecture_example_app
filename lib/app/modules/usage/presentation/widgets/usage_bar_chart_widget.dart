import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/usage/domain/entities/usage_record_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsageBarChartWidget extends StatefulWidget {
  final List<BarDataPointEntity> dataPoints;
  final ChartTimeMode timeMode;
  final Function(ChartTimeMode) onModeChanged;

  const UsageBarChartWidget({
    super.key,
    required this.dataPoints,
    required this.timeMode,
    required this.onModeChanged,
  });

  @override
  State<UsageBarChartWidget> createState() => _UsageBarChartWidgetState();
}

class _UsageBarChartWidgetState extends State<UsageBarChartWidget> {
  int touchedIndex = -1;

  double get maxY {
    if (widget.dataPoints.isEmpty) return 5.0;
    double maxVal = 0;
    for (var p in widget.dataPoints) {
      if (p.value > maxVal) maxVal = p.value;
    }
    return (maxVal * 1.25).clamp(2.0, 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Title & Mode Switcher
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consumption Trend',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Water Volume (m³)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Segmented Toggle: Daily / Weekly / Monthly
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    _ModeButton(
                      title: 'Daily',
                      isSelected: widget.timeMode == ChartTimeMode.daily,
                      onTap: () => widget.onModeChanged(ChartTimeMode.daily),
                    ),
                    _ModeButton(
                      title: 'Weekly',
                      isSelected: widget.timeMode == ChartTimeMode.weekly,
                      onTap: () => widget.onModeChanged(ChartTimeMode.weekly),
                    ),
                    _ModeButton(
                      title: 'Monthly',
                      isSelected: widget.timeMode == ChartTimeMode.monthly,
                      onTap: () => widget.onModeChanged(ChartTimeMode.monthly),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          // Main Bar Chart via fl_chart
          SizedBox(
            height: 190.h,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => const Color(0xFF0F172A),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final point = widget.dataPoints[groupIndex];
                      return BarTooltipItem(
                        '${point.label}\n',
                        TextStyle(
                          color: const Color(0xFF94A3B8),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: '${point.value.toStringAsFixed(2)} m³',
                            style: TextStyle(
                              color: const Color(0xFF38BDF8),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          response == null ||
                          response.spot == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = response.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28.h,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= widget.dataPoints.length) {
                          return const SizedBox.shrink();
                        }
                        final label = widget.dataPoints[idx].label;
                        final isSelected = idx == touchedIndex ||
                            (touchedIndex == -1 &&
                                idx == widget.dataPoints.length - 1);
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFF0E5C8A)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 34.w,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const SizedBox.shrink();
                        return Text(
                          value.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (maxY / 4).clamp(1.0, 200.0),
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: const Color(0xFFF1F5F9),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: List.generate(
                  widget.dataPoints.length,
                  (index) {
                    final isTouched = index == touchedIndex ||
                        (touchedIndex == -1 &&
                            index == widget.dataPoints.length - 1);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: widget.dataPoints[index].value,
                          gradient: LinearGradient(
                            colors: isTouched
                                ? [
                                    const Color(0xFF0284C7),
                                    const Color(0xFF0E5C8A),
                                  ]
                                : [
                                    const Color(0xFFBAE6FD),
                                    const Color(0xFF7DD3FC),
                                  ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          width: widget.dataPoints.length > 7 ? 14.w : 22.w,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6.r),
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxY,
                            color: const Color(0xFFF8FAFC),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(7.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10.5.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? const Color(0xFF0E5C8A)
                : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}
