import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/controller/home_controller.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/meter_selector_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceHeroCard extends ConsumerWidget {
  final MeterEntity meter;

  const BalanceHeroCard({super.key, required this.meter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.watch(homeControllerProvider);
    final isArrears = meter.feeStatus == 2;
    final isLowBalance = meter.feeStatus == 1;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E5C8A), Color(0xFF0369A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E5C8A).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  MeterSelectorBottomSheet.show(
                    context,
                    meters: homeController.meters,
                    selectedIndex: homeController.selectedMeterIndex,
                    onSelect: homeController.selectMeter,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        meter.meterName,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              // Status Badge: Normal / Low / Arrears
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: isArrears
                      ? const Color(0xFFEF4444)
                      : (isLowBalance
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFF10B981)),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  meter.feeStatusLabel.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            'Available Meter Balance',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Rs. ',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                meter.deviceBalance.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meter ID: ${meter.meterId}',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              Text(
                'Recharges: ${meter.deviceBuyTimes} times',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
