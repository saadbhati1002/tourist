class NotificationRes {
  List<Data>? data;

  NotificationRes({this.data});

  NotificationRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? description;
  String? createdDate;
  String? createdTime;

  Data(
      {this.id,
      this.title,
      this.description,
      this.createdDate,
      this.createdTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdDate = json['created_date'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['created_date'] = createdDate;
    data['createdTime'] = createdTime;
    return data;
  }
}
