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
  bool? isSavedToMyCalender = false;
  bool? isAttendingEvent = false;

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
      this.isSavedToMyCalender});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    place = json['place'];
    description = json['description'];
    joinUser = json['join_user'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    sDate = json['s_date'];
    eventType = json['event_type'];
    mapLink = json['map_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['place'] = place;
    data['description'] = description;
    data['join_user'] = joinUser;
    data['event_date'] = eventDate;
    data['event_time'] = eventTime;
    data['s_date'] = sDate;
    data['event_type'] = eventType;
    data['map_link'] = mapLink;
    return data;
  }
}
