import 'package:tourist/models/user/user_model.dart';

class UpdateProfile {
  String? message;
  UserData? data;

  UpdateProfile({message, data});

  UpdateProfile.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataResponse = <String, dynamic>{};
    dataResponse['message'] = message;
    if (data != null) {
      dataResponse['data'] = data!.toJson();
    }
    return dataResponse;
  }
}
