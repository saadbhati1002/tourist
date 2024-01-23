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

  Future<dynamic> addEventToMyCalenderApiCall({String? eventID}) async {
    final params = {
      "event_id": eventID,
      "user_id": AppConstant.userData!.id.toString()
    };
    return await EventNetwork.addEventToMyCalender(params);
  }

  Future<dynamic> removeEventFromMyCalenderApiCall({String? eventID}) async {
    final params = {
      "event_id": eventID,
      "user_id": AppConstant.userData!.id.toString()
    };
    return await EventNetwork.removeEventFromMyCalender(params);
  }

  Future<dynamic> getMyCalenderEventApiCall() async {
    return await EventNetwork.getMySavedEvents();
  }

  Future<dynamic> addEventReviewApiCall(
      {String? review, String? eventID}) async {
    final param = {
      "user_id": AppConstant.userData!.id.toString(),
      "event_id": eventID,
      "review": review
    };
    return await EventNetwork.addEventReview(param);
  }
}
