// import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// /// Top-level background handler — must be a top-level function.
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint("🔙 Background message received: ${message.messageId}");
//   debugPrint("🔙 Background message data: ${message.data}");
//   debugPrint(
//     "🔙 Background notification title: ${message.notification?.title}",
//   );

//   // Show notification for both data-only AND notification messages in background
//   // If message.notification is not null, the OS handles it automatically.
//   // We only show an AwesomeNotification manually if it's data-only.
//   if (message.notification == null) {
//     await NotificationService.showNotification(message);
//   }
// }

// class NotificationService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   // ──────────────────────────────────────────────────────────────────────────
//   // Channel keys (keep in sync with main.dart initialization)
//   // ──────────────────────────────────────────────────────────────────────────
//   static const String _highImportanceChannelKey = 'high_importance_channel';

//   // ──────────────────────────────────────────────────────────────────────────
//   // Initialization
//   // ──────────────────────────────────────────────────────────────────────────
//   static Future<void> initialize() async {
//     // 1. Request permission for iOS / Android 13+
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: false,
//       carPlay: false,
//       criticalAlert: true,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint('🔔 User granted notification permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       debugPrint('🔔 User granted provisional permission');
//     } else {
//       debugPrint('🔔 User declined or has not accepted permission');
//     }

//     // 2. iOS Foreground Presentation — ensures heads-up even when app is open
//     await _messaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     // 3. Get FCM Token
//     await getFcmToken();

//     // 4. Listen for token refresh
//     _messaging.onTokenRefresh.listen((newToken) {
//       debugPrint("🔄 FCM Token refreshed: $newToken");
//       // TODO: Send updated token to your backend
//     });

//     // 5. Register the top-level background handler
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // 6. Handle Foreground Messages (app is open and visible)
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('📨 Foreground message received: ${message.messageId}');
//       debugPrint('📨 Notification Title: ${message.notification?.title}');
//       debugPrint('📨 Notification Body: ${message.notification?.body}');
//       debugPrint('📨 Message Data: ${message.data}');

//       // Prevent duplicate notification on iOS:
//       // Firebase natively shows the notification in foreground when alert: true
//       if (Platform.isIOS && message.notification != null) {
//         return;
//       }

//       // Always show an Awesome Notification popup in foreground
//       showNotification(message);
//     });

//     // 7. Handle when user taps on notification while app is in background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('📬 User opened app from notification: ${message.messageId}');
//       _handleNotificationTap(message);
//     });

//     // 8. Handle initial message if the app was opened from terminated state
//     RemoteMessage? initialMessage = await _messaging.getInitialMessage();
//     if (initialMessage != null) {
//       debugPrint('🌅 App opened from terminated state via notification');
//       _handleNotificationTap(initialMessage);
//     }

//     // 9. Initialize Awesome Notifications Listeners
//     _initializeAwesomeListeners();

//     debugPrint('✅ NotificationService initialized successfully');
//   }

//   static Future<String?> getFcmToken() async {
//     try {
//       String? token = await _messaging.getToken();
//       debugPrint("🚀 FCM Token: $token");
//       return token;
//     } catch (e) {
//       debugPrint("❌ Error getting FCM token: $e");
//       return null;
//     }
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // Show Notification (popup / heads-up)
//   // ──────────────────────────────────────────────────────────────────────────
//   static Future<void> showNotification(RemoteMessage message) async {
//     final notification = message.notification;
//     final data = message.data;

//     final String title =
//         notification?.title ?? data['title'] ?? 'Naikify Notification';
//     final String body = notification?.body ?? data['body'] ?? 'Tap to see more';

//     debugPrint("🔥 Creating Awesome Notification → title: $title, body: $body");

//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         icon: 'resource://mipmap/launcher_icon',
//         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//         channelKey: _highImportanceChannelKey,
//         title: title,
//         body: body,
//         notificationLayout: NotificationLayout.Default,
//         payload: Map<String, String>.from(data),

//         // ── Ensure popup / heads-up visibility ──
//         wakeUpScreen: true,
//         fullScreenIntent: false,
//         autoDismissible: true,
//         displayOnForeground: true,
//         displayOnBackground: true,
//         category: NotificationCategory.Message,
//       ),
//     );
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // Show a custom local notification (for use elsewhere in the app)
//   // ──────────────────────────────────────────────────────────────────────────
//   static Future<void> showCustomNotification({
//     required String title,
//     required String body,
//     Map<String, String>? payload,
//     NotificationLayout layout = NotificationLayout.Default,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//         channelKey: _highImportanceChannelKey,
//         icon: 'resource://mipmap/launcher_icon',
//         title: title,
//         body: body,
//         notificationLayout: layout,
//         payload: payload,
//         wakeUpScreen: true,
//         fullScreenIntent: false,
//         autoDismissible: true,
//         displayOnForeground: true,
//         displayOnBackground: true,
//         category: NotificationCategory.Message,
//       ),
//     );
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // Notification tap handler
//   // ──────────────────────────────────────────────────────────────────────────
//   static void _handleNotificationTap(RemoteMessage message) {
//     debugPrint("TAP DATA: ${message.data}");
//     // TODO: Implement navigation logic here based on message.data
//     // For example:
//     // final String? screen = message.data['screen'];
//     // if (screen != null) {
//     //   navigatorKey.currentState?.pushNamed(screen);
//     // }
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // Awesome Notifications Listeners
//   // ──────────────────────────────────────────────────────────────────────────
//   static void _initializeAwesomeListeners() {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );
//   }

//   /// Called when a new notification is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//     ReceivedNotification receivedNotification,
//   ) async {
//     debugPrint(
//       "✅ Notification CREATED: id=${receivedNotification.id}, "
//       "title=${receivedNotification.title}",
//     );
//   }

//   /// Called when a notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//     ReceivedNotification receivedNotification,
//   ) async {
//     debugPrint(
//       "📱 Notification DISPLAYED: id=${receivedNotification.id}, "
//       "title=${receivedNotification.title}",
//     );
//   }

//   /// Called when the user dismisses a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//     ReceivedAction receivedAction,
//   ) async {
//     debugPrint(
//       "❌ Notification DISMISSED: id=${receivedAction.id}, "
//       "title=${receivedAction.title}",
//     );
//   }

//   /// Called when the user taps on a notification
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//     ReceivedAction receivedAction,
//   ) async {
//     debugPrint(
//       "👆 Notification TAPPED: id=${receivedAction.id}, "
//       "title=${receivedAction.title}, "
//       "payload=${receivedAction.payload}",
//     );

//     // Navigate based on payload
//     final payload = receivedAction.payload;
//     if (payload != null) {
//       final String? screen = payload['screen'];
//       if (screen != null) {
//         debugPrint("🧭 Navigating to: $screen");
//         // MyApp.navigatorKey.currentState?.pushNamed(screen, arguments: payload);
//       }
//     }
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // Utility methods
//   // ──────────────────────────────────────────────────────────────────────────

//   /// Cancel a specific notification by ID
//   static Future<void> cancelNotification(int id) async {
//     await AwesomeNotifications().cancel(id);
//   }

//   /// Cancel all notifications
//   static Future<void> cancelAllNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }

//   /// Reset badge counter (iOS)
//   static Future<void> resetBadge() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }
// }
