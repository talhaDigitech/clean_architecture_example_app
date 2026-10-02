import 'package:clean_architecture_example_app/app/core/theme/app_typography.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NotificationItemCard extends StatelessWidget {
  final NotificationEntity item;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const NotificationItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Icon(
          Icons.delete_outline,
          color: const Color(0xFFEF4444),
          size: 22.sp,
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: item.isRead ? Colors.white : const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: item.isRead
                  ? const Color(0xFFE2E8F0)
                  : const Color(0xFFBAE6FD),
              width: item.isRead ? 1 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 19.sp,
                  color: item.color,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 13.5.sp,
                              fontWeight: item.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (!item.isRead) ...[
                          Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0E5C8A),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.message,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (item.meterId != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              item.meterId!,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        Text(
                          DateFormat('MMM dd, hh:mm a').format(item.timestamp),
                          style: TextStyle(
                            fontSize: 10.5.sp,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
