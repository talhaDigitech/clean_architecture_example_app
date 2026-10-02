import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

/// Security, support and about sections in profile screen
class SecuritySupportWidget extends StatelessWidget {
  final VoidCallback onChangePassword;
  final VoidCallback onFaq;
  final VoidCallback onComplaint;

  const SecuritySupportWidget({
    super.key,
    required this.onChangePassword,
    required this.onFaq,
    required this.onComplaint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Security Section
        Text(
          'Security',
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
            child: ListTile(
              leading:
                  const Icon(Icons.lock_outline, color: Color(0xFF0E5C8A)),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.chevron_right),
              onTap: onChangePassword,
            ),
          ),
        ),

        SizedBox(height: 22.h),

        // Support Section
        Text(
          'Customer Support & Helpdesk',
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
                  leading: const Icon(Icons.help_outline,
                      color: Color(0xFF0E5C8A)),
                  title:
                      const Text('Frequently Asked Questions (FAQ)'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onFaq,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.support_agent_outlined,
                      color: Color(0xFF0E5C8A)),
                  title: const Text('Submit Complaint or Feedback'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: onComplaint,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.chat_bubble_outline,
                      color: Color(0xFF10B981)),
                  title: const Text('WhatsApp Helpline'),
                  subtitle: const Text('+92 300 1234567 (24/7)'),
                  trailing: const Icon(Icons.open_in_new, size: 18),
                  onTap: () async {
                    final uri =
                        Uri.parse('https://wa.me/923001234567');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 22.h),

        // About Section
        Text(
          'About',
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
                  title: const Text('Application Name'),
                  trailing: Text(
                    'Winmeter',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: const Color(0xFF0E5C8A),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('App Version'),
                  trailing: Text(
                    'v1.0.0+1 (Build 2026.1)',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF64748B)),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Terms of Service & Privacy Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        title: const Text('Privacy Policy'),
                        content: const Text(
                          'Winmeter respects user telemetry privacy. Data transmitted from water meters is secured via AES-128 and strictly processed for utility metering.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
