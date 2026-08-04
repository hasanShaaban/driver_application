import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:driver_application/core/notifications/services/local_notification_service.dart';
import 'package:driver_application/core/notifications/services/push_notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
}

class FirebasePushNotificationServiceImpl implements PushNotificationService {
  final FirebaseMessaging? _customFirebaseMessaging;
  final LocalNotificationService _localNotificationService;

  FirebasePushNotificationServiceImpl({
    required LocalNotificationService localNotificationService,
    FirebaseMessaging? firebaseMessaging,
  })  : _localNotificationService = localNotificationService,
        _customFirebaseMessaging = firebaseMessaging;

  FirebaseMessaging get _firebaseMessaging =>
      _customFirebaseMessaging ?? FirebaseMessaging.instance;

  @override
  Future<void> initialize() async {
    await requestPermission();

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _localNotificationService.initialize();

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
  }

  @override
  Future<void> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint(
      'User notification permission status: ${settings.authorizationStatus}',
    );
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  @override
  Stream<String> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground Message received: ${message.notification?.title}');
    final notification = message.notification;
    if (notification != null) {
      _localNotificationService.showNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        payload: message.data.toString(),
      );
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('App opened from notification: ${message.data}');
  }

  void _handleInitialMessage(RemoteMessage message) {
    debugPrint('App launched from initial message: ${message.data}');
  }
}
