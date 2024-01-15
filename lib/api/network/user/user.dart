import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/all_user/all_user_model.dart';
import 'package:tourist/models/user/guest_user_model.dart';

class UserNetwork {
  static const String allUSersUrl = "auth-api.php/UsersDetail";
  static const String userDetailUrl = "auth-api.php/getUserDetail?id=";

  static Future<dynamic> getAllUsers() async {
    final result = await httpManager.post(
      url: allUSersUrl,
    );
    AllUserRes loginRes = AllUserRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> getUserDetails(userID) async {
    final result = await httpManager.post(
      url: '$userDetailUrl$userID',
    );
    GuestDetailRes loginRes = GuestDetailRes.fromJson(result);
    return loginRes;
  }
}
