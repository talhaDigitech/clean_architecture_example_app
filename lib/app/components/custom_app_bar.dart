import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A universal, premium App Bar component for Winmeter.
///
/// Can be used as:
/// 1. Standard screen AppBar (Title, subtitle, back button, custom actions)
/// 2. User Greeting / Profile Header (Avatar, greeting, user name, notification bell, action buttons)
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Standard mode properties
  final String? title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;

  /// Greeting / Profile mode properties
  final bool isProfileMode;
  final String? userName;
  final String? greeting;
  final int unreadNotifications;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLogoutTap;
  final VoidCallback? onAvatarTap;

  /// Styling
  final Color? backgroundColor;
  final double? elevation;
  final double? bottomPadding;
  final double? horizontalPadding;

  const CustomAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBackButton = true,
    this.onBackTap,
    this.actions,
    this.isProfileMode = false,
    this.userName,
    this.greeting,
    this.unreadNotifications = 0,
    this.onNotificationTap,
    this.onLogoutTap,
    this.onAvatarTap,
    this.backgroundColor,
    this.elevation = 0,
    this.bottomPadding,
    this.horizontalPadding,
  });

  /// Factory constructor for Standard Screens (History, Settings, Top-up, etc.)
  factory CustomAppBar.standard({
    Key? key,
    required String title,
    String? subtitle,
    bool showBackButton = true,
    VoidCallback? onBackTap,
    List<Widget>? actions,
    Color? backgroundColor,
    double? horizontalPadding,
    double? bottomPadding,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      subtitle: subtitle,
      showBackButton: showBackButton,
      onBackTap: onBackTap,
      actions: actions,
      backgroundColor: backgroundColor,
      horizontalPadding: horizontalPadding,
      bottomPadding: bottomPadding,
      isProfileMode: false,
    );
  }

  /// Factory constructor for Profile/Greeting Mode (Home screen top header)
  factory CustomAppBar.greeting({
    Key? key,
    required String userName,
    String? greeting,
    int unreadNotifications = 0,
    VoidCallback? onNotificationTap,
    VoidCallback? onLogoutTap,
    VoidCallback? onAvatarTap,
    List<Widget>? extraActions,
    Color? backgroundColor,
    double? horizontalPadding,
    double? bottomPadding,
  }) {
    return CustomAppBar(
      key: key,
      isProfileMode: true,
      userName: userName,
      greeting: greeting,
      unreadNotifications: unreadNotifications,
      onNotificationTap: onNotificationTap,
      onLogoutTap: onLogoutTap,
      onAvatarTap: onAvatarTap,
      actions: extraActions,
      backgroundColor: backgroundColor,
      horizontalPadding: horizontalPadding,
      bottomPadding: bottomPadding,
    );
  }

  String get _computedGreeting {
    if (greeting != null && greeting!.isNotEmpty) return greeting!;
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 20.w,
        vertical: bottomPadding ?? 8.h,
      ),
      child: isProfileMode
          ? _buildProfileHeader(context)
          : _buildStandardHeader(context),
    );
  }

  Widget _buildStandardHeader(BuildContext context) {
    return Row(
      children: [
        if (showBackButton) ...[
          GestureDetector(
            onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16.sp,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        ...?actions,
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final name = userName ?? 'User';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar + User Info
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: onAvatarTap,
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0E5C8A), Color(0xFF1C7FB1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0E5C8A).withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _computedGreeting,
                      style: AppTypography.bodySmall.copyWith(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamily,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),

        // Action Buttons: Notification Bell, Logout & Extra actions
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onNotificationTap != null)
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 20.sp,
                        color: const Color(0xFF334155),
                      ),
                      if (unreadNotifications > 0)
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            if (onLogoutTap != null) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onLogoutTap,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.logout_outlined,
                    size: 19.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
            ...?actions,
          ],
        ),
      ],
    );
  }
}
