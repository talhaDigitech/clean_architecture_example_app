import 'package:clean_architecture_example_app/app/modules/notifications/domain/entities/notification_entity.dart';

class NotificationDto {
  final String id;
  final String title;
  final String message;
  final String category;
  final String severity;
  final bool isRead;
  final String? meterId;
  final String timestamp;

  NotificationDto({
    required this.id,
    required this.title,
    required this.message,
    required this.category,
    required this.severity,
    required this.isRead,
    this.meterId,
    required this.timestamp,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      NotificationDto(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        message: json["message"] ?? "",
        category: json["category"] ?? "system",
        severity: json["severity"] ?? "info",
        isRead: json["isRead"] ?? false,
        meterId: json["meterId"],
        timestamp: json["timestamp"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "category": category,
        "severity": severity,
        "isRead": isRead,
        "meterId": meterId,
        "timestamp": timestamp,
      };

  NotificationEntity toEntity() {
    NotificationCategory cat;
    switch (category.toLowerCase()) {
      case 'alarms':
        cat = NotificationCategory.alarms;
        break;
      case 'billing':
        cat = NotificationCategory.billing;
        break;
      case 'system':
        cat = NotificationCategory.system;
        break;
      default:
        cat = NotificationCategory.all;
    }

    NotificationSeverity sev;
    switch (severity.toLowerCase()) {
      case 'danger':
        sev = NotificationSeverity.danger;
        break;
      case 'warning':
        sev = NotificationSeverity.warning;
        break;
      case 'success':
        sev = NotificationSeverity.success;
        break;
      default:
        sev = NotificationSeverity.info;
    }

    return NotificationEntity(
      id: id,
      title: title,
      message: message,
      category: cat,
      severity: sev,
      isRead: isRead,
      meterId: meterId,
      timestamp: DateTime.tryParse(timestamp) ?? DateTime.now(),
    );
  }
}
