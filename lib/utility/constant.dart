import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstant {
  static const String appName = 'DWS 2024';
  static const String baseUrl = 'https://dubaiweddingsymposium.com/API/v1/';
  static List roleType = ['Delegate', 'Speaker', 'Vendor', 'Media'];
  static List rolesSubRole = ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'];
  static String? selectedRole;
  static String? selectedSubRole;
  static bool isMyEvent = true;
  static UserData? userData;
  static userDetailSaved(String userDetail) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('userDetail', userDetail);
  }

  static Future getUserDetail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userDetail');
  }
}

toastShow({String? message}) {
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
