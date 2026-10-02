import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeterSelectorBottomSheet extends StatelessWidget {
  final List<MeterEntity> meters;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const MeterSelectorBottomSheet({
    super.key,
    required this.meters,
    required this.selectedIndex,
    required this.onSelect,
  });

  static Future<void> show(
    BuildContext context, {
    required List<MeterEntity> meters,
    required int selectedIndex,
    required ValueChanged<int> onSelect,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MeterSelectorBottomSheet(
        meters: meters,
        selectedIndex: selectedIndex,
        onSelect: onSelect,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Active Meter',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '${meters.length} Configured',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'Switch between your residential and commercial utility meters.',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 16.h),

          // List of Meters
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: meters.length,
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              final meter = meters[index];
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onSelect(index);
                },
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF0E5C8A).withValues(alpha: 0.04)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0E5C8A)
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0E5C8A)
                              : const Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.speed,
                          size: 18.sp,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meter.meterName,
                              style: TextStyle(
                                fontFamily: AppTypography.fontFamily,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'ID: ${meter.meterId} · Total: ${meter.deviceTotalData.toStringAsFixed(2)} m³',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF0E5C8A),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Add New Meter Action
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 44.h),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pairing new meter with gateway...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 18, color: Color(0xFF0E5C8A)),
            label: const Text(
              'Add Another Meter',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF0E5C8A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
