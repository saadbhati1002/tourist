import 'package:tourist/models/user/user_model.dart';

class FavoriteRes {
  List<Data>? data;

  FavoriteRes({this.data});

  FavoriteRes.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  UserData? joinedUsers;

  Data({this.userId, this.joinedUsers});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    joinedUsers = json['joined_users'] != null
        ? UserData.fromJson(json['joined_users'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (joinedUsers != null) {
      data['joined_users'] = joinedUsers!.toJson();
    }
    return data;
  }
}
