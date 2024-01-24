import 'package:tourist/models/user/user_model.dart';

class RecommendedRes {
  String? message;
  List<UserData>? recommended;

  RecommendedRes({this.message, this.recommended});

  RecommendedRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Recommended'] != null) {
      recommended = <UserData>[];
      json['Recommended'].forEach((v) {
        recommended!.add(UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (recommended != null) {
      data['Recommended'] = recommended!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
