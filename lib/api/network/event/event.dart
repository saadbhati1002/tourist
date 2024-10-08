import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/utility/constant.dart';

class EventNetwork {
  static const String eventListUrl = "auth-api.php/EventDetail";
  static const String joinEventUrl = "auth-api.php/JoinEvent";
  static const String getMyCalenderEventUrl =
      "auth-api.php/FavoriteList?user_id=";
  static const String addEventToMyCalenderUrl = "auth-api.php/AddFavorite";
  static const String leaveEventUrl = "auth-api.php/UnJoinEvent?event_id=";
  static const String removeEventFromMyCalenderUrl =
      "auth-api.php/RemoveFavorite";
  static const String saveEventReviewUrl = "auth-api.php/addEventReview";

  static Future<dynamic> getEventList() async {
    final result = await httpManager.post(
      url: eventListUrl,
    );
    print(result);
    EventRes loginRes = EventRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> joinEvent(params) async {
    final result = await httpManager.post(url: joinEventUrl, data: params);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> leaveEvent(eventID) async {
    final result = await httpManager.deleteWithToken(
      url: '$leaveEventUrl$eventID&user_id=${AppConstant.userData!.id}',
    );
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> addEventToMyCalender(params) async {
    final result =
        await httpManager.post(url: addEventToMyCalenderUrl, data: params);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> removeEventFromMyCalender(params) async {
    final result =
        await httpManager.post(url: removeEventFromMyCalenderUrl, data: params);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getMySavedEvents() async {
    final result = await httpManager.post(
      url: "$getMyCalenderEventUrl${AppConstant.userData!.id}",
    );
    EventRes loginRes = EventRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> addEventReview(params) async {
    final result =
        await httpManager.post(url: saveEventReviewUrl, data: params);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }
}
