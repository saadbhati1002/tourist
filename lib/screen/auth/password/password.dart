import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/dashboard/dashboard_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class PasswordScreen extends StatefulWidget {
  final String? email;
  const PasswordScreen({super.key, this.email});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController password = TextEditingController();
  bool isPassword = true;
  String? deviceToken;
  bool isLoading = false;
  @override
  void initState() {
    getDeviceToken();
    super.initState();
  }

  getDeviceToken() async {
    deviceToken = await FirebaseMessaging.instance.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            fit: StackFit.loose,
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .26,
                              alignment: Alignment.center,
                              child: Image.asset(Images.logoName),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "DUBAI WEDDING SYMPOSIUM DUBAI 2024",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .07,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Enter the password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: CustomTextFormField(
                                controller: password,
                                isObscureText: isPassword,
                                hintText: "Enter the password",
                                context: context,
                                suffix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },
                                    child: Icon(isPassword
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye)),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: CommonButton(
                                width: MediaQuery.of(context).size.width,
                                onTap: () {
                                  userLogin();
                                },
                                title: "Login",
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: SizedBox(
                            height: 65,
                            width: 65,
                            child: Image.asset(Images.vivah),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              isLoading ? const ShowProgressBar() : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  userLogin() async {
    if (password.text.isEmpty) {
      toastShow(message: "Please enter password");
      return;
    }
    print(deviceToken);
    try {
      setState(() {
        isLoading = true;
      });
      UserRes response = await AuthRepository().userLoginApiCall(
        deviceToken: deviceToken,
        email: widget.email,
        password: password.text.trim(),
      );
      if (response.success != null) {
        toastShow(message: "Welcome to DWS 2024");
        AppConstant.userData = response.success;
        AppConstant.userDetailSaved(jsonEncode(response.success));
        Get.to(() => const DashBoardScreen());
      } else {
        toastShow(message: "Incorrect password");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
