import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/common.dart';

class AuthNetwork {
  static const String emailCheckUrl = "auth-api.php/emailVerify";

  static Future<dynamic> checkEmail(prams) async {
    print(prams);
    final result = await httpManager.post(url: emailCheckUrl, data: prams);
    print(result);
    Common loginRes = Common.fromJson(result);
    return loginRes;
  }
}
