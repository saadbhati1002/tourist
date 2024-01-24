import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/all_user/all_user_model.dart';
import 'package:tourist/models/recommended_user/recommended_users_model.dart';
import 'package:tourist/models/user/guest_user_model.dart';
import 'package:tourist/utility/constant.dart';

class UserNetwork {
  static const String allUSersUrl = "auth-api.php/UsersDetail";
  static const String userDetailUrl = "auth-api.php/getUserDetail?id=";
  static const String recommendedUserUrl =
      "auth-api.php/getRecommendedUsers?user_id=";

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

  static Future<dynamic> getRecommendedUsers() async {
    print('$recommendedUserUrl${AppConstant.userData!.id}');
    final result = await httpManager.post(
      url: '$recommendedUserUrl${AppConstant.userData!.id}',
    );
    print(result);
    RecommendedRes loginRes = RecommendedRes.fromJson(result);
    return loginRes;
  }
}
