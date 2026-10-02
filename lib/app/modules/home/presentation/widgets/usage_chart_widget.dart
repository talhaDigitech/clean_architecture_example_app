import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsageChartWidget extends StatefulWidget {
  final List<DailyUsageEntity> usageData;

  const UsageChartWidget({super.key, required this.usageData});

  @override
  State<UsageChartWidget> createState() => _UsageChartWidgetState();
}

class _UsageChartWidgetState extends State<UsageChartWidget> {
  int _selectedIndex = 6; // default to today (last item)

  double get _maxValue {
    if (widget.usageData.isEmpty) return 1.0;
    double max = 0;
    for (var u in widget.usageData) {
      if (u.value > max) max = u.value;
    }
    return max == 0 ? 1.0 : max;
  }

  double get _totalWeekly {
    return widget.usageData.fold(0.0, (sum, item) => sum + item.value);
  }

  @override
  Widget build(BuildContext context) {
    final selectedUsage = widget.usageData.isNotEmpty &&
            _selectedIndex < widget.usageData.length
        ? widget.usageData[_selectedIndex]
        : null;

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
          // Header with Title & 7-Day Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7-Day Consumption',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Total: ${_totalWeekly.toStringAsFixed(2)} m³ this week',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              // Tooltip badge for selected bar
              if (selectedUsage != null)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E5C8A),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${selectedUsage.day}: ${selectedUsage.value.toStringAsFixed(2)} m³',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 20.h),

          // Bar Chart Rendering
          SizedBox(
            height: 130.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.usageData.length, (index) {
                final usage = widget.usageData[index];
                final isSelected = index == _selectedIndex;
                final heightFactor =
                    (usage.value / _maxValue).clamp(0.08, 1.0);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Animated Bar
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 32.w,
                        height: (90 * heightFactor).h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: isSelected
                                ? [
                                    const Color(0xFF0E5C8A),
                                    const Color(0xFF0284C7),
                                  ]
                                : [
                                    const Color(0xFFE2E8F0),
                                    const Color(0xFFCBD5E1),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF0E5C8A)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Day Label
                      Text(
                        usage.day,
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF0E5C8A)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
