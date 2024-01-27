import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/constant.dart';

class EventRes {
  List<EventData>? event;

  EventRes({data});

  EventRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      event = <EventData>[];
      json['data'].forEach((v) {
        event!.add(EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['data'] = event!.map((v) => v.toJson()).toList();

    return data;
  }
}

class EventData {
  String? id;
  String? title;
  String? place;
  String? description;
  String? joinUser;
  String? eventDate;
  String? eventTime;
  String? sDate;
  String? mapLink;
  String? eventType;
  String? endTime;
  bool? isSavedToMyCalender = false;
  bool? isAttendingEvent = false;
  bool? isReviewSubmitted = false;
  List<UserData>? userList = [];
  List<EventReview>? eventReview;
  String? eventStatus;

  EventData(
      {this.id,
      this.title,
      this.place,
      this.description,
      this.joinUser,
      this.eventDate,
      this.eventTime,
      this.sDate,
      this.mapLink,
      this.eventType,
      this.isAttendingEvent,
      this.isSavedToMyCalender,
      this.userList,
      this.eventReview,
      this.endTime});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['event_id'];
    title = json['event_name'];
    place = json['place'];
    description = json['description'];
    joinUser = json['join_user'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    sDate = json['s_date'];
    eventType = json['event_type'];
    mapLink = json['map_link'];
    endTime = json['end_time'];
    if (AppConstant.isMyEvent == true) {
      userList!.add(UserData.fromJson(json['joined_users']));
    } else {
      if (json['joined_users'].toString() != "[null]") {
        userList = <UserData>[];
        json['joined_users'].forEach((v) {
          userList!.add(UserData.fromJson(v));
        });
      }
    }
    if (json['EVENT_REVIEW'] != null) {
      eventReview = <EventReview>[];
      json['EVENT_REVIEW'].forEach((v) {
        eventReview!.add(EventReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = id;
    data['event_name'] = title;
    data['place'] = place;
    data['description'] = description;
    data['join_user'] = joinUser;
    data['event_date'] = eventDate;
    data['event_time'] = eventTime;
    data['s_date'] = sDate;
    data['event_type'] = eventType;
    data['map_link'] = mapLink;
    data['end_time'] = endTime;
    data['joined_users'] = userList!.map((v) => v.toJson()).toList();
    return data;
  }
}

class EventReview {
  String? id;
  String? eventId;
  String? userId;
  String? review;
  String? createdDate;

  EventReview(
      {this.id, this.eventId, this.userId, this.review, this.createdDate});

  EventReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    userId = json['user_id'];
    review = json['review'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['user_id'] = userId;
    data['review'] = review;
    data['created_date'] = createdDate;
    return data;
  }
}
