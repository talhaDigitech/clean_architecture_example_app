import 'package:clean_architecture_example_app/app/components/custom_app_bar.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/presentation/controller/notification_controller.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/presentation/widgets/notification_category_tabs.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/presentation/widgets/notification_empty_state.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/presentation/widgets/notification_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(notificationControllerProvider);
    final items = controller.filteredNotifications;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar.standard(
              title: 'Notifications',
              subtitle: '${controller.unreadCount} unread alerts',
              showBackButton: true,
              onBackTap: () => Navigator.pop(context),
              actions: [
                if (controller.allNotifications.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      controller.markAllAsRead();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All notifications marked as read.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.done_all_rounded,
                      size: 16.sp,
                      color: const Color(0xFF0E5C8A),
                    ),
                    label: Text(
                      'Read all',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0E5C8A),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            NotificationCategoryTabs(
              selectedCategory: controller.selectedCategory,
              totalCount: controller.allNotifications.length,
              onCategoryChanged: controller.setCategory,
            ),
            SizedBox(height: 14.h),
            Expanded(
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : items.isEmpty
                      ? const NotificationEmptyState()
                      : ListView.separated(
                          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                          itemCount: items.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return NotificationItemCard(
                              item: item,
                              onTap: () => controller.markAsRead(item.id),
                              onDismissed: () =>
                                  controller.deleteNotification(item.id),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
