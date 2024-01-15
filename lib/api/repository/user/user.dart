import 'package:tourist/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> allUsersApiCall() async {
    return await UserNetwork.getAllUsers();
  }
}
