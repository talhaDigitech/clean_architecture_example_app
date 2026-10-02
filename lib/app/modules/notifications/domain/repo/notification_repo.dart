import 'package:clean_architecture_example_app/app/modules/notifications/data/dto/notification_dto.dart';

abstract interface class NotificationRepo {
  Future<List<NotificationDto>> getNotifications();
}
