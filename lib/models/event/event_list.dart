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
  String? userID;
  String? group1;
  String? group2;
  String? group3;
  String? group4;
  String? group5;
  String? group6;
  String? group7;
  String? group8;
  String? group9;
  String? group_title1;
  String? group_title2;
  String? group_title3;
  String? group_title4;
  String? group_title5;
  String? group_title6;
  String? group_title7;
  String? group_title8;
  String? group_title9;
  String? hotelName;
  String? hotelImage;

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
      this.endTime,
      this.userID,
      this.eventStatus,
      this.isReviewSubmitted,
      this.group1,
      this.group2,
      this.group3,
      this.group4,
      this.group5,
      this.group6,
      this.group7,
      this.group8,
      this.group9,
      this.group_title1,
      this.group_title2,
      this.group_title3,
      this.group_title4,
      this.group_title5,
      this.group_title6,
      this.group_title7,
      this.group_title8,
      this.group_title9,
      this.hotelImage,
      this.hotelName});

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
    userID = json['user_id'];
    group1 = json['group1'] == "1" ? "group1" : "0";
    group2 = json['group2'] == "1" ? "group2" : "0";
    group3 = json['group3'] == "1" ? "group3" : "0";
    group4 = json['group4'] == "1" ? "group4" : "0";
    group5 = json['group5'] == "1" ? "group5" : "0";
    group6 = json['group6'] == "1" ? "group6" : "0";
    group7 = json['group7'] == "1" ? "group7" : "0";
    group8 = json['group8'] == "1" ? "group8" : "0";
    group9 = json['group9'] == "1" ? "group9" : "0";
    group_title1 = json["group_title1"];
    group_title2 = json["group_title2"];
    group_title3 = json["group_title3"];
    group_title4 = json["group_title4"];
    group_title5 = json["group_title5"];
    group_title6 = json["group_title6"];
    group_title7 = json["group_title7"];
    group_title8 = json["group_title8"];
    group_title9 = json["group_title9"];
    hotelImage = json["hotel_image"];
    hotelName = json["hotel_name"];
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
    data['user_id'] = userID;
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
