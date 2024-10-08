import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/account_setup/question_screen.dart';
import 'package:tourist/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:tourist/screen/auth/login/login_screen.dart';
import 'package:tourist/screen/dashboard/dashboard_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _requestPermission();
    Future.delayed(const Duration(seconds: 2), () {
      checkLogin();
      // Get.to(() => const LoginScreen());
    });
    super.initState();
  }

  _requestPermission() async {
    await Permission.storage.request();
    await Permission.contacts.request();
    await Permission.notification.request();
    if (await Permission.storage.isPermanentlyDenied) {
      // await openAppSettings();
    }
    if (await Permission.storage.isDenied) {
      // await openAppSettings();
    }
  }

  checkLogin() async {
    try {
      var response = await AppConstant.getUserDetail();

      if (response != null && response != "null") {
        UserData responseUser = UserData.fromJson(jsonDecode(response));
        AppConstant.userData = responseUser;
        if (AppConstant.userData!.userType == null ||
            AppConstant.userData!.userType == "") {
          Get.to(() => const QuestionScreen());
        } else if (AppConstant.userData!.logo3 == null ||
            AppConstant.userData!.logo3 == "") {
          Get.to(() => const EditProfileScreen());
        } else {
          Get.to(() => const DashBoardScreen());
        }
      } else {
        Get.to(() => const LoginScreen());
      }
    } catch (e) {
      Get.to(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0, 2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF433C3D),
                Color(0xFF1B1819),
              ],
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .26,
                  alignment: Alignment.center,
                  child: Image.asset(Images.logoName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
