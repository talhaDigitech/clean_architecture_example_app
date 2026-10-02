import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroConsumptionCard extends StatelessWidget {
  final MeterEntity meter;
  final VoidCallback onTopUpTap;

  const HeroConsumptionCard({
    super.key,
    required this.meter,
    required this.onTopUpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A3A5B),
            Color(0xFF0E5C8A),
            Color(0xFF1672A7),
          ],
        ),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E5C8A).withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Total Consumption Label + Status Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.speed_outlined,
                    size: 16.sp,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'TOTAL CONSUMPTION',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Live Meter',
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Total Reading Display (Feature 4)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                meter.deviceTotalData.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1.0,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'm³',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF67E8F9),
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),
          Divider(color: Colors.white.withValues(alpha: 0.15), height: 1),
          SizedBox(height: 16.h),

          // Feature 5: Balance Display + Fee Status + Quick Top Up
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'AVAILABLE BALANCE',
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      // Fee Status Chip
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: meter.feeStatus == 0
                              ? const Color(0xFF10B981).withValues(alpha: 0.25)
                              : const Color(0xFFEF4444).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          meter.feeStatus == 0 ? 'Normal' : 'Arrears',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: meter.feeStatus == 0
                                ? const Color(0xFF6EE7B7)
                                : const Color(0xFFFCA5A5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Rs. ${meter.deviceBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // Top Up Quick Action Button
              GestureDetector(
                onTap: onTopUpTap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_card_outlined,
                        size: 15.sp,
                        color: const Color(0xFF0E5C8A),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Top Up',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0E5C8A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
