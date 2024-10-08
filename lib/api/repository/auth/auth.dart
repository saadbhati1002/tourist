import 'dart:io';

import 'package:dio/dio.dart';

import 'package:tourist/api/network/auth/auth.dart';
import 'package:tourist/utility/constant.dart';

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

  Future<dynamic> userProfileUpdateApiCall(
      {String? firstName,
      String? lastName,
      String? middleName,
      String? email,
      String? mobileNumber,
      String? companyName,
      String? companyProfile,
      String? country,
      String? personalBio,
      String? jobTitle,
      String? dietaryRestrictions,
      File? userImage}) async {
    FormData body;
    if (userImage != null) {
      String fileName = userImage.path.split('/').last;
      body = FormData.fromMap({
        'email': email,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "Company_Name": companyName,
        "mobile": mobileNumber,
        "Company_Profile": companyProfile,
        "Personal_Bio": personalBio,
        "country": country,
        "job_title": jobTitle,
        "logo3":
            await MultipartFile.fromFile(userImage.path, filename: fileName)
      });
    } else if (dietaryRestrictions != null && dietaryRestrictions != "") {
      body = FormData.fromMap({
        'email': email,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "Company_Name": companyName,
        "mobile": mobileNumber,
        "Company_Profile": companyName,
        "Personal_Bio": personalBio,
        "country": country,
        "job_title": jobTitle,
        "dietary_restrictions": dietaryRestrictions
      });
    } else {
      body = FormData.fromMap({
        'email': email,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "Company_Name": companyName,
        "mobile": mobileNumber,
        "Company_Profile": companyName,
        "Personal_Bio": personalBio,
        "country": country,
        "job_title": jobTitle,
      });
    }
    return await AuthNetwork.updateProfile(body);
  }

  Future<dynamic> updateUserTypeApiCall({
    String? userType,
  }) async {
    var body = {"user_type": userType};

    return await AuthNetwork.updateProfile(body);
  }

  Future<dynamic> updateUserNotesApiCall({
    String? notes,
  }) async {
    var body = {"notes": notes};

    return await AuthNetwork.updateProfile(body);
  }

  Future<dynamic> addFavoriteUsersApiCall({
    String? favoriteUserID,
  }) async {
    var body = {
      "user_id": AppConstant.userData!.id.toString(),
      "favorite_user_id": favoriteUserID
    };
    return await AuthNetwork.addUserToFavorite(body);
  }

  Future<dynamic> removeFavoriteUsersApiCall({
    String? favoriteUserID,
  }) async {
    return await AuthNetwork.removeUserToFavorite(favoriteUserID);
  }

  Future<dynamic> favoriteUsersListApiCall() async {
    return await AuthNetwork.favoriteUserList();
  }
}
