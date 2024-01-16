import 'package:tourist/api/network/event/event.dart';
import 'package:tourist/utility/constant.dart';

class EventRepository {
  Future<dynamic> allEventListApiCall() async {
    return await EventNetwork.getEventList();
  }

  Future<dynamic> joinEventApiCall({String? eventID}) async {
    final params = {
      "event_id": eventID,
      "user_id": AppConstant.userData!.id.toString()
    };
    return await EventNetwork.joinEvent(params);
  }

  Future<dynamic> leaveEventApiCall({String? eventID}) async {
    return await EventNetwork.leaveEvent(eventID);
  }
}
