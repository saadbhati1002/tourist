import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/auth/login/login_screen.dart';
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
      Get.to(() => const LoginScreen());
    });
    super.initState();
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
