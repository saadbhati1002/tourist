import 'package:tourist/api/network/event/event.dart';

class EventRepository {
  Future<dynamic> allEventListApiCall() async {
    return await EventNetwork.getEventList();
  }
}
