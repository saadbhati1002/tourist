import 'package:tourist/api/network/user/user.dart';

class UserRepository {
  Future<dynamic> allUsersApiCall() async {
    return await UserNetwork.getAllUsers();
  }

  Future<dynamic> getUserDetailApiCall({String? userID}) async {
    return await UserNetwork.getUserDetails(userID);
  }
}
