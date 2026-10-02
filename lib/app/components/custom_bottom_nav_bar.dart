import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                label: 'Home',
                inactiveIcon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                isSelected: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              _NavItem(
                label: 'History',
                inactiveIcon: Icons.history,
                activeIcon: Icons.bar_chart_rounded,
                isSelected: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              _NavItem(
                label: 'Recharge',
                inactiveIcon: Icons.account_balance_wallet_outlined,
                activeIcon: Icons.account_balance_wallet,
                isSelected: currentIndex == 2,
                onTap: () => onTabSelected(2),
              ),
              _NavItem(
                label: 'Profile',
                inactiveIcon: Icons.person_outline,
                activeIcon: Icons.person_rounded,
                isSelected: currentIndex == 3,
                onTap: () => onTabSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData inactiveIcon;
  final IconData activeIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.inactiveIcon,
    required this.activeIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0E5C8A).withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              size: 24.sp,
              color: isSelected
                  ? const Color(0xFF0E5C8A)
                  : const Color(0xFF64748B),
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily,
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF0E5C8A)
                    : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
