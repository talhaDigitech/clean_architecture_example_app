import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/data/source/notification_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/domain/entities/notification_entity.dart';
import 'package:clean_architecture_example_app/app/modules/notifications/domain/usecase/get_notifications_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final notificationControllerProvider =
    ChangeNotifierProvider<NotificationController>(
  (ref) => NotificationController(
    getNotificationsUseCase:
        GetNotificationsUseCase(NotificationImpleRepo()),
  ),
);

class NotificationController extends ChangeNotifier with Buffers {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationController({
    required GetNotificationsUseCase getNotificationsUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase {
    loadNotifications();
  }

  NotificationCategory _selectedCategory = NotificationCategory.all;
  NotificationCategory get selectedCategory => _selectedCategory;

  bool get isLoading => hasLoader('getNotifications');

  List<NotificationEntity> _notifications = [];

  List<NotificationEntity> get allNotifications => _notifications;

  List<NotificationEntity> get filteredNotifications {
    if (_selectedCategory == NotificationCategory.all) {
      return _notifications;
    }
    return _notifications
        .where((n) => n.category == _selectedCategory)
        .toList();
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> loadNotifications() async {
    await executeAPI(
      apiEndPoint: 'getNotifications',
      showPrompt: false,
      onExecute: () async {
        _notifications = await _getNotificationsUseCase();
      },
      onError: (e) async {
        _notifications = [];
      },
    );
  }

  void setCategory(NotificationCategory cat) {
    _selectedCategory = cat;
    notifyListeners();
  }

  void markAsRead(String id) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1 && !_notifications[idx].isRead) {
      _notifications[idx] = _notifications[idx].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications =
        _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}
