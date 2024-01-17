import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/updateProfile/update_profile_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/constant.dart';

class AuthNetwork {
  static const String emailCheckUrl = "auth-api.php/emailVerify";
  static const String setPasswordUrl = "auth-api.php/passwordSet";
  static const String userLoginUrl = "auth-api.php/login";
  static const String updateProfileUrl = "auth-api.php/updateProfile?id=";

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
    print(result);
    UserRes loginRes = UserRes.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> updateProfile(prams) async {
    final result = await httpManager.postWithoutJson(
        url: "$updateProfileUrl${AppConstant.userData!.id!}", data: prams);
    print(result);
    UpdateProfile loginRes = UpdateProfile.fromJson(result);
    return loginRes;
  }
}
