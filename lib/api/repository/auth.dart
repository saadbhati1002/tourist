import 'package:tourist/api/network/auth.dart';

class AuthRepository {
  Future<dynamic> checkEmail({String? email}) async {
    final body = {'email': email};
    return await AuthNetwork.checkEmail(body);
  }
}
