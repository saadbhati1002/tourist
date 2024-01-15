import 'dart:io';

import 'package:get/get.dart';
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
      bool? isProfileUpdated,
      File? userImage}) async {
    var body;
    // if (isProfileUpdated == true) {
    String fileName = userImage!.path.split('/').last;
    body = {
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
      "logo3": await MultipartFile(userImage.path, filename: fileName)
    };
    // } else {
    //   body = {
    //     'email': email,
    //     "first_name": firstName,
    //     "middle_name": middleName,
    //     "last_name": lastName,
    //     "Company_Name": companyName,
    //     "mobile": mobileNumber,
    //     "Company_Profile": companyName,
    //     "Personal_Bio": personalBio,
    //     "country": country,
    //     "job_title": jobTitle
    //   };
    // }

    return await AuthNetwork.updateProfile(body);
  }
}
