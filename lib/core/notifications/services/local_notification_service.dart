abstract class LocalNotificationService {
  Future<void> initialize();
  Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  });
}
