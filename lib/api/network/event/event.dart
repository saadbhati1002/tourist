import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/event/event_list.dart';

class EventNetwork {
  static const String eventListUrl = "auth-api.php/EventDetail";
  static Future<dynamic> getEventList() async {
    final result = await httpManager.post(
      url: eventListUrl,
    );
    EventRes loginRes = EventRes.fromJson(result);
    return loginRes;
  }
}
