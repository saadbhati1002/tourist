import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';

class AuthNetwork {
  static const String emailCheckUrl = "auth-api.php/emailVerify";
  static const String setPasswordUrl = "auth-api.php/passwordSet";

  static Future<dynamic> checkEmail(prams) async {
    final result = await httpManager.post(url: emailCheckUrl, data: prams);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }

  static Future<dynamic> setPassword(prams) async {
    final result = await httpManager.post(url: setPasswordUrl, data: prams);
    print(result);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }
}
