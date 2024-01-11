import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstant {
  static List roleType = ['Delegate', 'Speaker', 'Vendor', 'Media'];
  static List rolesSubRole = ['Answer 1', 'Answer 2', 'Answer 3', 'Answer 4'];
  static String? selectedRole;
  static String? selectedSubRole;
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
