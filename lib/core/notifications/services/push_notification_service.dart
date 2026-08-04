abstract class PushNotificationService {
  Future<void> initialize();
  Future<void> requestPermission();
  Future<String?> getToken();
  Stream<String> get onTokenRefresh;
}
