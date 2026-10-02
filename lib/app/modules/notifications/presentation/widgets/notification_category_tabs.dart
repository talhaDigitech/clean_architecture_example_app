import 'package:clean_architecture_example_app/app/modules/notifications/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCategoryTabs extends StatelessWidget {
  final NotificationCategory selectedCategory;
  final int totalCount;
  final ValueChanged<NotificationCategory> onCategoryChanged;

  const NotificationCategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.totalCount,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          _CategoryChip(
            label: 'All ($totalCount)',
            isSelected: selectedCategory == NotificationCategory.all,
            onTap: () => onCategoryChanged(NotificationCategory.all),
          ),
          SizedBox(width: 8.w),
          _CategoryChip(
            label: 'Alarms',
            isSelected: selectedCategory == NotificationCategory.alarms,
            onTap: () => onCategoryChanged(NotificationCategory.alarms),
            icon: Icons.water_damage_outlined,
          ),
          SizedBox(width: 8.w),
          _CategoryChip(
            label: 'Billing',
            isSelected: selectedCategory == NotificationCategory.billing,
            onTap: () => onCategoryChanged(NotificationCategory.billing),
            icon: Icons.account_balance_wallet_outlined,
          ),
          SizedBox(width: 8.w),
          _CategoryChip(
            label: 'System',
            isSelected: selectedCategory == NotificationCategory.system,
            onTap: () => onCategoryChanged(NotificationCategory.system),
            icon: Icons.cloud_outlined,
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E5C8A) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0E5C8A)
                : const Color(0xFFCBD5E1),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0E5C8A).withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 13.sp,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
              SizedBox(width: 5.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
