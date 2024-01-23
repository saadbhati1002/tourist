import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/favorite/favorite_model.dart';
import 'package:tourist/models/updateProfile/update_profile_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/constant.dart';

class AuthNetwork {
  static const String emailCheckUrl = "auth-api.php/emailVerify";
  static const String setPasswordUrl = "auth-api.php/passwordSet";
  static const String userLoginUrl = "auth-api.php/login";
  static const String updateProfileUrl = "auth-api.php/updateProfile?id=";
  static const String addFavoriteUsersUrl = "auth-api.php/saveFavoriteUser";
  static const String removeFavoriteUsersUrl =
      "auth-api.php/unFavoriteUser?favorite_user_id=";
  static const String favoriteUsersListUrl =
      "auth-api.php/saveFavoriteUserList?user_id=";

  static Future<dynamic> checkEmail(prams) async {
    final result = await httpManager.post(url: emailCheckUrl, data: prams);

    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> setPassword(prams) async {
    final result = await httpManager.post(url: setPasswordUrl, data: prams);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> userLogin(prams) async {
    final result = await httpManager.post(url: userLoginUrl, data: prams);

    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> updateProfile(prams) async {
    final result = await httpManager.postWithoutJson(
        url: "$updateProfileUrl${AppConstant.userData!.id!}", data: prams);

    UpdateProfile loginRes = UpdateProfile.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> addUserToFavorite(prams) async {
    final result =
        await httpManager.post(url: addFavoriteUsersUrl, data: prams);

    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> removeUserToFavorite(anotherUserID) async {
    final result = await httpManager.deleteWithToken(
        url:
            "$removeFavoriteUsersUrl$anotherUserID&user_id=${AppConstant.userData!.id}");
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> favoriteUserList() async {
    final result = await httpManager.post(
        url: "$favoriteUsersListUrl${AppConstant.userData!.id}");
    FavoriteRes loginRes = FavoriteRes.fromJson(result);
    return loginRes;
  }
}
