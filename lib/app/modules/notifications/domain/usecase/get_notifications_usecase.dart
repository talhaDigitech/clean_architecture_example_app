import 'package:clean_architecture_example_app/app/modules/notifications/domain/entities/notification_entity.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/domain/repo/notification_repo.dart';

class GetNotificationsUseCase {
  final NotificationRepo repo;
  GetNotificationsUseCase(this.repo);

  Future<List<NotificationEntity>> call() async {
    final dtos = await repo.getNotifications();
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
