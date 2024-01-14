import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/user/user_model.dart';

class AuthNetwork {
  static const String emailCheckUrl = "auth-api.php/emailVerify";
  static const String setPasswordUrl = "auth-api.php/passwordSet";
  static const String userLoginUrl = "auth-api.php/login";

  static Future<dynamic> checkEmail(prams) async {
    print(prams);
    final result = await httpManager.post(url: emailCheckUrl, data: prams);
    print(result);
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
}
