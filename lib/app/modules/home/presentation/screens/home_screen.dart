import 'package:clean_architecture_example_app/app/components/confirm_dialog.dart';
import 'package:clean_architecture_example_app/app/core/handlers/auth_handler.dart';
import 'package:clean_architecture_example_app/app/modules/authantication/presentation/screens/login_screen.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/controller/home_controller.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/hero_consumption_card.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/home_header_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/home_states_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/meter_health_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/meter_selector_bottom_sheet.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/quick_actions_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/quick_stats_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/smart_alert_banner_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/usage_chart_widget.dart';
import 'package:clean_architecture_example_app/app/modules/home/presentation/widgets/valve_control_widget.dart';
import 'package:clean_architecture_example_app/app/modules/main_nav/presentation/controller/main_nav_controller.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/presentation/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    ConfirmDialog.show(
      context,
      title: 'Confirm Logout',
      message: 'Are you sure you want to sign out from your Winmeter session?',
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);

    // Feature 13: Loading / Error / Empty States
    if (controller.isLoading || controller.state == HomeViewState.loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: SafeArea(child: HomeLoadingSkeleton()),
      );
    }

    if (controller.state == HomeViewState.error) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: HomeErrorWidget(
            errorMessage: 'Gateway timed out. Unable to fetch telemetry.',
            onRetry: () =>
                controller.setViewState(HomeViewState.loaded),
          ),
        ),
      );
    }

    if (controller.state == HomeViewState.empty || controller.meters.isEmpty || controller.currentMeter == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: HomeEmptyWidget(
            onAddMeter: () =>
                controller.setViewState(HomeViewState.loaded),
          ),
        ),
      );
    }

    final meter = controller.currentMeter!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: RefreshIndicator(
          // Feature 11: Pull-to-refresh
          color: const Color(0xFF0E5C8A),
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Feature 1: Greeting + Notification Bell + Feature 3: Multi-Meter Selector
                HomeHeaderWidget(
                  meter: meter,
                  unreadCount: controller.unreadNotifications,
                  onMeterTap: () {
                    MeterSelectorBottomSheet.show(
                      context,
                      meters: controller.meters,
                      selectedIndex: controller.selectedMeterIndex,
                      onSelect: controller.selectMeter,
                    );
                  },
                  onNotificationTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    );
                  },
                  onLogoutTap: () => _showLogoutDialog(context),
                ),

                SizedBox(height: 16.h),

                // Feature 2: Smart Alert Banner
                SmartAlertBannerWidget(
                  meter: meter,
                  onActionTap: () {
                    if (meter.feeStatus != 0) {
                      ref.read(mainNavIndexProvider.notifier).state = 2;
                    } else if (meter.valveStatus == 1 || meter.valveStatus == 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Use the Valve Control card below to operate water valve.',
                          ),
                        ),
                      );
                    }
                  },
                ),

                SizedBox(height: 18.h),

                // Feature 4: Total Consumption + Feature 5: Balance Display
                HeroConsumptionCard(
                  meter: meter,
                  onTopUpTap: () {
                    ref.read(mainNavIndexProvider.notifier).state = 2;
                  },
                ),

                SizedBox(height: 18.h),

                // Feature 6: Valve Status + Control Card
                ValveControlWidget(
                  meter: meter,
                  isOperating: controller.isValveOperating,
                  onToggleRequested: () async {
                    final willOpen = await controller.toggleValve();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: willOpen
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          content: Text(
                            willOpen
                                ? 'Valve opened successfully. Water flowing.'
                                : 'Valve closed successfully. Supply stopped.',
                          ),
                        ),
                      );
                    }
                  },
                ),

                SizedBox(height: 20.h),

                // Feature 7: Quick Stats (4 key readings & settle day)
                QuickStatsWidget(meter: meter),

                SizedBox(height: 20.h),

                // Feature 8: Usage Mini Chart (7-day interactive bar chart)
                UsageChartWidget(usageData: meter.weeklyUsage),

                SizedBox(height: 20.h),

                // Feature 9: Quick Actions (Recharge, Usage History, Reports, Settings)
                QuickActionsWidget(
                  onRechargeTap: () =>
                      ref.read(mainNavIndexProvider.notifier).state = 2,
                  onHistoryTap: () =>
                      ref.read(mainNavIndexProvider.notifier).state = 1,
                  onReportsTap: () =>
                      ref.read(mainNavIndexProvider.notifier).state = 1,
                  onSettingsTap: () =>
                      ref.read(mainNavIndexProvider.notifier).state = 3,
                ),

                SizedBox(height: 20.h),

                // Feature 10: Meter Health + Feature 12: Stale Data Indicator
                MeterHealthWidget(meter: meter),

                SizedBox(height: 24.h),

                // Footer branding
                Center(
                  child: Text(
                    'Winmeter Enterprise · Firmware v2.4.1',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
