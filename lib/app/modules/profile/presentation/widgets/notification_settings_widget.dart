import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Notification preferences section for profile screen
class NotificationSettingsWidget extends StatelessWidget {
  final ProfileController controller;

  const NotificationSettingsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notification Preferences',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SwitchListTile(
                title: const Text('Push Notifications (Master)'),
                value: controller.pushEnabled,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.togglePush,
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Leakage Alarm'),
                subtitle: const Text('Immediate alert on abnormal flow'),
                value: controller.leakageAlert,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.pushEnabled
                    ? controller.toggleLeakage
                    : null,
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Low Balance Warning'),
                value: controller.lowBalanceAlert,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.pushEnabled
                    ? controller.toggleLowBalance
                    : null,
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Arrears Notice'),
                value: controller.arrearsAlert,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.pushEnabled
                    ? controller.toggleArrears
                    : null,
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Low Battery Alert'),
                value: controller.lowBatteryAlert,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.pushEnabled
                    ? controller.toggleLowBattery
                    : null,
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Offline / Stale Telemetry Alert'),
                value: controller.offlineAlert,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.pushEnabled
                    ? controller.toggleOffline
                    : null,
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Valve Execution Result'),
                value: controller.valveResultAlert,
                activeThumbColor: const Color(0xFF0E5C8A),
                onChanged: controller.pushEnabled
                    ? controller.toggleValveResult
                    : null,
              ),
            ],
          ),
        ),
      ),
    ],
    );
  }
}
