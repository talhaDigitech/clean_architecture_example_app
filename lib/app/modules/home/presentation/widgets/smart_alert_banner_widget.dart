import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartAlertBannerWidget extends StatelessWidget {
  final MeterEntity meter;
  final VoidCallback onActionTap;

  const SmartAlertBannerWidget({
    super.key,
    required this.meter,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine alerts based on priority:
    // 1. Fee Status (Arrears / Low Balance)
    // 2. Valve Status (Closed)
    // 3. Voltage Status (Low Battery / Under-voltage)
    // 4. Abnormal Report Reason

    String? title;
    String? message;
    String? actionLabel;
    IconData iconData = Icons.warning_amber_rounded;
    Color primaryColor = const Color(0xFFEF4444);
    Color bgColor = const Color(0xFFFEF2F2);
    Color borderColor = const Color(0xFFFCA5A5);

    if (meter.valveStatus == 4 || meter.hasLeakage) {
      title = 'Leakage Detected';
      message =
          'Continuous abnormal water flow detected on meter line. Inspect plumbing immediately.';
      actionLabel = 'Check Valve';
      primaryColor = const Color(0xFFDC2626);
      bgColor = const Color(0xFFFEF2F2);
      borderColor = const Color(0xFFF87171);
      iconData = Icons.water_damage_outlined;
    } else if (meter.feeStatus == 2) {
      title = 'Arrears Alert';
      message =
          'Account in arrears. Balance khatam, water supply valve band ho sakta hai.';
      actionLabel = 'Recharge';
      primaryColor = const Color(0xFFDC2626);
      bgColor = const Color(0xFFFEF2F2);
      borderColor = const Color(0xFFF87171);
      iconData = Icons.error_outline;
    } else if (meter.feeStatus == 1) {
      title = 'Low Balance Warning';
      message =
          'Remaining balance is Rs. ${meter.deviceBalance.toStringAsFixed(2)}. Recharge now to avoid interruption.';
      actionLabel = 'Recharge';
      primaryColor = const Color(0xFFF59E0B);
      bgColor = const Color(0xFFFFFBEB);
      borderColor = const Color(0xFFFCD34D);
      iconData = Icons.account_balance_wallet_outlined;
    } else if (meter.valveStatus == 1) {
      title = 'Meter Valve Closed';
      message =
          'Water supply is currently stopped. Open valve from control card below.';
      actionLabel = 'Check Valve';
      primaryColor = const Color(0xFFF59E0B);
      bgColor = const Color(0xFFFFFBEB);
      borderColor = const Color(0xFFFCD34D);
      iconData = Icons.lock_outline;
    } else if (meter.voltageStatus != 0) {
      title = 'Low Meter Battery';
      message =
          'Voltage is ${meter.deviceVoltage}V. Schedule maintenance before communication halts.';
      actionLabel = 'Details';
      primaryColor = const Color(0xFFF59E0B);
      bgColor = const Color(0xFFFFFBEB);
      borderColor = const Color(0xFFFCD34D);
      iconData = Icons.battery_alert_outlined;
    }

    if (title == null) {
      // All systems operational pill
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFBBF7D0)),
        ),
        child: Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'System Status: All parameters optimal · ${meter.reportReason}',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF166534),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 20.sp, color: primaryColor),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  message ?? '',
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11.5.sp,
                    color: const Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (actionLabel != null)
            GestureDetector(
              onTap: onActionTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  actionLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
