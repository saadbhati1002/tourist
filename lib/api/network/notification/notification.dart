import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/notification/notification_model.dart';

class NotificationNetwork {
  static const String notificationUrl = "auth-api.php/getNotifications";
  static Future<dynamic> getNotifications() async {
    final result = await httpManager.post(
      url: notificationUrl,
    );

    NotificationRes loginRes = NotificationRes.fromJson(result);
    return loginRes;
  }
}
