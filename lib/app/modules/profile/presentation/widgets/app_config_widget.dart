import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App configuration widget (language, theme, units)
class AppConfigWidget extends StatelessWidget {
  final ProfileController controller;

  const AppConfigWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Configuration',
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
                ListTile(
                  title: const Text('Language'),
                  trailing: DropdownButton<String>(
                    value: controller.selectedLanguage,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(value: 'English', child: Text('English')),
                      DropdownMenuItem(
                          value: 'Urdu', child: Text('اردو (Urdu)')),
                    ],
                    onChanged: (val) {
                      if (val != null) controller.setLanguage(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Theme'),
                  trailing: DropdownButton<String>(
                    value: controller.selectedTheme,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                          value: 'System', child: Text('System Default')),
                      DropdownMenuItem(
                          value: 'Light', child: Text('Light Mode')),
                      DropdownMenuItem(value: 'Dark', child: Text('Dark Mode')),
                    ],
                    onChanged: (val) {
                      if (val != null) controller.setTheme(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Measurement Units'),
                  trailing: DropdownButton<String>(
                    value: controller.selectedUnit,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                          value: 'm³', child: Text('Cubic Meters (m³)')),
                      DropdownMenuItem(
                          value: 'Liters', child: Text('Liters (L)')),
                    ],
                    onChanged: (val) {
                      if (val != null) controller.setUnit(val);
                    },
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
