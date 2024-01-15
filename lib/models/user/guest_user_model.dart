import 'package:tourist/models/user/user_model.dart';

class GuestDetailRes {
  String? message;
  UserData? data;

  GuestDetailRes({this.message, this.data});

  GuestDetailRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = UserData.fromJson(json['data'][0]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['message'] = message;
    if (data != null) {
      dataResponse['data'][0] = data!.toJson();
    }
    return dataResponse;
  }
}
