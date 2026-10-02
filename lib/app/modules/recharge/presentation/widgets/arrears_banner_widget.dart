import 'package:clean_architecture_example_app/app/modules/recharge/presentation/controller/recharge_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows the arrears warning banner when feeStatus == 2
class ArrearsBannerWidget extends StatelessWidget {
  const ArrearsBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFFCA5A5)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: const BoxDecoration(
              color: Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arrears Warning',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFDC2626),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Balance khatam, valve band ho sakta hai. Top up now to restore water flow.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF7F1D1D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows the pending sync banner after payment
class PendingSyncBannerWidget extends StatelessWidget {
  final RechargeController controller;

  const PendingSyncBannerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: const BoxDecoration(
              color: Color(0xFFF59E0B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sync,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Received · Sync Pending',
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.dismissPendingSync,
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Payment of Rs. ${controller.pendingAmount.toStringAsFixed(0)} received. Balance meter par update hone ka intezar hai. Meter battery par hone ki wajah se agle periodic transmission mein update hoga.',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF78350F),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
