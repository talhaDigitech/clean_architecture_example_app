import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _SkeletonBox(width: 44.w, height: 44.w, isCircle: true),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(width: 90.w, height: 12.h),
                      SizedBox(height: 6.h),
                      _SkeletonBox(width: 130.w, height: 16.h),
                    ],
                  ),
                ],
              ),
              _SkeletonBox(width: 40.w, height: 40.w, isCircle: true),
            ],
          ),

          SizedBox(height: 18.h),
          _SkeletonBox(width: double.infinity, height: 44.h, radius: 12.r),
          SizedBox(height: 18.h),
          _SkeletonBox(width: double.infinity, height: 180.h, radius: 22.r),
          SizedBox(height: 18.h),
          _SkeletonBox(width: double.infinity, height: 80.h, radius: 18.r),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _SkeletonBox(width: double.infinity, height: 95.h, radius: 14.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _SkeletonBox(width: double.infinity, height: 95.h, radius: 14.r),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const HomeErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: const BoxDecoration(
                color: Color(0xFFFEF2F2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 48.sp,
                color: const Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Failed to Load Meter Telemetry',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              errorMessage.isNotEmpty
                  ? errorMessage
                  : 'Unable to communicate with Winmeter gateway. Check internet connection or retry.',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E5C8A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text(
                'Retry Connection',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeEmptyWidget extends StatelessWidget {
  final VoidCallback onAddMeter;

  const HomeEmptyWidget({super.key, required this.onAddMeter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: const BoxDecoration(
                color: Color(0xFFF0F9FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.electric_meter_outlined,
                size: 48.sp,
                color: const Color(0xFF0284C7),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'No Connected Meters Found',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'No smart meters linked to your account. Pair your meter to track live consumption and manage utilities.',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF64748B),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E5C8A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              onPressed: onAddMeter,
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'Pair New Meter',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final bool isCircle;

  const _SkeletonBox({
    required this.width,
    required this.height,
    this.radius = 8.0,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(radius),
      ),
    );
  }
}
