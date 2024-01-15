import 'package:tourist/api/http_manager.dart';
import 'package:tourist/models/all_user/all_user_model.dart';

class UserNetwork {
  static const String allUSersUrl = "auth-api.php/UsersDetail";

  static Future<dynamic> getAllUsers() async {
    final result = await httpManager.post(
      url: allUSersUrl,
    );
    AllUserRes loginRes = AllUserRes.fromJson(result);
    return loginRes;
  }
}
