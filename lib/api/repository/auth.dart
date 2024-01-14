import 'package:tourist/api/network/auth.dart';

class AuthRepository {
  Future<dynamic> checkEmailApiCall({String? email}) async {
    final body = {'email': email};
    return await AuthNetwork.checkEmail(body);
  }

  Future<dynamic> setPasswordApiCall({String? email, String? password}) async {
    final body = {'email': email, "password": password};
    return await AuthNetwork.setPassword(body);
  }

  Future<dynamic> userLoginApiCall(
      {String? email, String? password, String? deviceToken}) async {
    final body = {
      'email': email,
      "password": password,
      "device_token": deviceToken
    };
    return await AuthNetwork.userLogin(body);
  }
}
