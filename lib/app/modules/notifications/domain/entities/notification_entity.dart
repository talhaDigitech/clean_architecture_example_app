import 'package:flutter/material.dart';

enum NotificationCategory { all, alarms, billing, system }

enum NotificationSeverity { info, warning, danger, success }

class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationCategory category;
  final NotificationSeverity severity;
  final bool isRead;
  final String? meterId;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.category,
    required this.severity,
    this.isRead = false,
    this.meterId,
  });

  Color get color {
    switch (severity) {
      case NotificationSeverity.danger:
        return const Color(0xFFEF4444);
      case NotificationSeverity.warning:
        return const Color(0xFFF59E0B);
      case NotificationSeverity.success:
        return const Color(0xFF10B981);
      case NotificationSeverity.info:
        return const Color(0xFF0E5C8A);
    }
  }

  IconData get icon {
    switch (category) {
      case NotificationCategory.alarms:
        return severity == NotificationSeverity.danger
            ? Icons.water_damage_outlined
            : Icons.warning_amber_rounded;
      case NotificationCategory.billing:
        return Icons.account_balance_wallet_outlined;
      case NotificationCategory.system:
        return Icons.cloud_sync_outlined;
      case NotificationCategory.all:
        return Icons.notifications_none_rounded;
    }
  }

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationCategory? category,
    NotificationSeverity? severity,
    bool? isRead,
    String? meterId,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      category: category ?? this.category,
      severity: severity ?? this.severity,
      isRead: isRead ?? this.isRead,
      meterId: meterId ?? this.meterId,
    );
  }
}
