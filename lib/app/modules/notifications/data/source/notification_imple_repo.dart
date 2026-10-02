import 'package:clean_architecture_example_app/app/core/services/mock_data_service.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/data/dto/notification_dto.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/domain/repo/notification_repo.dart';

class NotificationImpleRepo implements NotificationRepo {
  final MockDataService _mockDataService;

  NotificationImpleRepo([MockDataService? mockDataService])
      : _mockDataService = mockDataService ?? MockDataService();

  @override
  Future<List<NotificationDto>> getNotifications() async {
    // When real API arrives:
    // final response = await _apiService.requestGET(Endpoints.notifications);
    final rawList = await _mockDataService.getNotifications();
    return rawList.map((json) => NotificationDto.fromJson(json)).toList();
  }
}
