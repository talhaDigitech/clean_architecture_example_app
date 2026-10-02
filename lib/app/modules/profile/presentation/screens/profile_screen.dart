import 'package:clean_architecture_example_app/app/components/confirm_dialog.dart';
import 'package:clean_architecture_example_app/app/core/handlers/auth_handler.dart';
import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/presentation/screens/login_screen.dart';
import 'package:clean_architecture_example_app/app/modules/home/domain/entities/meter_entity.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/controller/home_controller.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/controller/profile_controller.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/widgets/app_config_widget.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/widgets/meters_section_widget.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/widgets/notification_settings_widget.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/widgets/profile_header_card.dart';
import 'package:clean_architecture_example_app/app/modules/profile/presentation/widgets/security_support_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  // ── Dialogs ──────────────────────────────────────────────────────────────

  void _showEditProfileDialog(
      BuildContext context, ProfileController controller) {
    final nameCtrl = TextEditingController(text: controller.userName);
    final emailCtrl = TextEditingController(text: controller.email);
    final phoneCtrl = TextEditingController(text: controller.phone);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 17.sp,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5C8A),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              controller.updateProfile(
                newName: nameCtrl.text.trim(),
                newEmail: emailCtrl.text.trim(),
                newPhone: phoneCtrl.text.trim(),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully.')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddMeterDialog(BuildContext context, HomeController homeCtrl) {
    final idCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: Row(
          children: [
            const Icon(Icons.add_circle_outline, color: Color(0xFF0E5C8A)),
            SizedBox(width: 8.w),
            const Text('Link New Meter'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter the WINMETER serial number to verify device parameters.',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
            ),
            SizedBox(height: 14.h),
            TextField(
              controller: idCtrl,
              decoration: const InputDecoration(
                labelText: 'Meter Number (e.g. WM-2026-9901)',
                prefixIcon: Icon(Icons.pin_outlined),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Custom Label (e.g. Guest House)',
                prefixIcon: Icon(Icons.label_outline),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                labelText: 'Installation Address',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5C8A),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final id = idCtrl.text.trim();
              if (id.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a meter number.')),
                );
                return;
              }
              homeCtrl.addMeter(
                meterId: id,
                meterName: nameCtrl.text.trim().isEmpty
                    ? 'Water Meter $id'
                    : nameCtrl.text.trim(),
                address: addressCtrl.text.trim().isEmpty
                    ? 'Registered Residential Address'
                    : addressCtrl.text.trim(),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color(0xFF10B981),
                  content: Text('Meter linked & verified via Device Info API!'),
                ),
              );
            },
            child: const Text('Verify & Link'),
          ),
        ],
      ),
    );
  }

  void _showMeterDetailSheet(BuildContext context, MeterEntity meter) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              meter.meterName,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${meter.meterType} · Water Telemetry Node',
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
            ),
            SizedBox(height: 18.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _DetailRow(label: 'Meter Number', value: meter.meterId),
                  const Divider(height: 14, color: Color(0xFFE2E8F0)),
                  _DetailRow(
                      label: 'Account Holder', value: meter.deviceUserName),
                  const Divider(height: 14, color: Color(0xFFE2E8F0)),
                  _DetailRow(label: 'Address', value: meter.deviceAddress),
                  const Divider(height: 14, color: Color(0xFFE2E8F0)),
                  _DetailRow(
                      label: 'Billing Settle Day',
                      value: meter.deviceSettleDay),
                  const Divider(height: 14, color: Color(0xFFE2E8F0)),
                  _DetailRow(
                    label: 'Battery & Signal',
                    value: '${meter.deviceVoltage}V · ${meter.deviceRSSI} dBm',
                  ),
                  const Divider(height: 14, color: Color(0xFFE2E8F0)),
                  _DetailRow(
                    label: 'Valve Status',
                    value: meter.valveStatusLabel,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E5C8A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5C8A),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password updated securely.')),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showFaqDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: const Text('Help & FAQs'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: const [
              Text(
                '1. What does "Leakage" status mean?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                'In Winmeter Water meters, valve status 4 indicates abnormal continuous flow (leakage). Please inspect your indoor plumbing immediately.',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              SizedBox(height: 12),
              Text(
                '2. Why is my recharge balance delayed?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                'Winmeter hardware operates on battery power to conserve life. It synchronizes pending balances upon its next scheduled wake-up cycle.',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              SizedBox(height: 12),
              Text(
                '3. How do I open a closed valve?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                'Navigate to Home, ensure balance is cleared, and tap the "Open Valve" button on the Valve Control card.',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showComplaintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        title: const Text('Submit Support Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              decoration: InputDecoration(labelText: 'Subject / Issue Type'),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Describe your issue or query...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5C8A),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Complaint submitted. Ticket ID: #WM-84920'),
                ),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    ConfirmDialog.show(
      context,
      title: 'Confirm Logout',
      message: 'Are you sure you want to log out from Winmeter?',
      confirmText: 'Logout',
      confirmColor: const Color(0xFFEF4444),
      icon: Icons.logout_outlined,
      onConfirm: () async {
        await AuthHandler.ref.logout();
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    ConfirmDialog.show(
      context,
      title: 'Delete Account?',
      message:
          'This action is irreversible. All linked meters, telemetry history, and prepaid credentials will be permanently erased.',
      confirmText: 'Delete Permanently',
      confirmColor: const Color(0xFFDC2626),
      icon: Icons.delete_forever_outlined,
      onConfirm: () async {
        await AuthHandler.ref.logout();
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);
    final homeController = ref.watch(homeControllerProvider);

    if (profileController.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0E5C8A)),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Header
              Text(
                'Account & Settings',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Manage meters, notifications and preferences',
                style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
              ),

              SizedBox(height: 16.h),

              // Feature: User Info Card
              ProfileHeaderCard(
                controller: profileController,
                onEditTap: () =>
                    _showEditProfileDialog(context, profileController),
              ),

              SizedBox(height: 20.h),

              // Feature: My Meters Section
              MetersSectionWidget(
                homeController: homeController,
                onAddMeter: () => _showAddMeterDialog(context, homeController),
                onMeterDetail: _showMeterDetailSheet,
                onShowSnackBar: (context, msg) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg)),
                ),
              ),

              SizedBox(height: 22.h),

              // Feature: Notification Preferences
              NotificationSettingsWidget(controller: profileController),

              SizedBox(height: 22.h),

              // Feature: App Configuration (language, theme, units)
              AppConfigWidget(controller: profileController),

              SizedBox(height: 22.h),

              // Feature: Security + Support + About
              SecuritySupportWidget(
                onChangePassword: () => _showChangePasswordDialog(context),
                onFaq: () => _showFaqDialog(context),
                onComplaint: () => _showComplaintDialog(context),
              ),

              SizedBox(height: 24.h),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFDC2626),
                    side: const BorderSide(color: Color(0xFFFCA5A5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('Sign Out'),
                ),
              ),

              SizedBox(height: 12.h),

              // Delete Account
              Center(
                child: TextButton(
                  onPressed: () => _showDeleteAccountDialog(context),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF94A3B8),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private helper used only in the meter detail sheet ─────────────────────

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
