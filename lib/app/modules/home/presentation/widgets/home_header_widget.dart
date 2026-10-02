import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  final MeterEntity meter;
  final int unreadCount;
  final VoidCallback onMeterTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onLogoutTap;

  const HomeHeaderWidget({
    super.key,
    required this.meter,
    required this.unreadCount,
    required this.onMeterTap,
    required this.onNotificationTap,
    required this.onLogoutTap,
  });

  String get _computedGreeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Greeting & Name only (No circle avatar)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _computedGreeting,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    meter.deviceUserName.isNotEmpty
                        ? meter.deviceUserName
                        : 'User',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Notification Bell with unread badge
            GestureDetector(
              onTap: onNotificationTap,
              child: Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: 21.sp,
                      color: const Color(0xFF334155),
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        top: 7.h,
                        right: 7.w,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          constraints: BoxConstraints(
                            minWidth: 15.w,
                            minHeight: 15.w,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF4444),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unreadCount',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        // Multi-Meter Selector Chip
        GestureDetector(
          onTap: onMeterTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
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
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E5C8A).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.water_drop_outlined,
                    size: 18.sp,
                    color: const Color(0xFF0E5C8A),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meter.meterName,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'ID: ${meter.meterId} · ${meter.meterType}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Switch',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0E5C8A),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16.sp,
                        color: const Color(0xFF0E5C8A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
