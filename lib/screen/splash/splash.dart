import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/auth/login/login_screen.dart';
import 'package:tourist/screen/dashboard/dashboard_screen.dart';
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
    Future.delayed(const Duration(seconds: 2), () {
      checkLogin();
      // Get.to(() => const LoginScreen());
    });
    super.initState();
  }

  checkLogin() async {
    try {
      var response = await AppConstant.getUserDetail();

      if (response != null && response != "null") {
        UserData responseUser = UserData.fromJson(jsonDecode(response));
        AppConstant.userData = responseUser;
        Get.to(() => const DashBoardScreen());
      } else {
        Get.to(() => const LoginScreen());
      }
    } catch (e) {
      Get.to(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width * .8,
          child: Image.asset(Images.logoName),
        ),
      ),
    );
  }
}
