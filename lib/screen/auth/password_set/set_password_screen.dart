import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/account_setup/question_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/show_progress_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SetPasswordScreen extends StatefulWidget {
  final String? email;
  const SetPasswordScreen({super.key, this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  bool isPassword = true;
  bool isConfirmPassword = true;
  String? deviceToken;

  // @override
  // void initState() {
  //   getDeviceToken();
  //   super.initState();
  // }

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
                              height: MediaQuery.of(context).size.height * .07,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .26,
                              alignment: Alignment.center,
                              child: Image.asset(Images.logoName),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .07,
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
                              height: MediaQuery.of(context).size.height * .1,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                "Set New Password",
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
                                hintText: "Set a new password",
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
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: CustomTextFormField(
                                controller: confirmPassword,
                                isObscureText: isConfirmPassword,
                                hintText: "Confirm password",
                                context: context,
                                suffix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isConfirmPassword = !isConfirmPassword;
                                      });
                                    },
                                    child: Icon(isConfirmPassword
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
                                  setNewPassword();
                                },
                                title: "Proceed",
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
                      ),
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

  setNewPassword() async {
    if (password.text.isEmpty) {
      toastShow(message: "Please enter password");
      return;
    }
    if (confirmPassword.text.isEmpty) {
      toastShow(message: "Please enter confirm password");
      return;
    }
    if (password.text.trim() != confirmPassword.text.trim()) {
      toastShow(message: 'Password and confirm password does not match');
      return;
    }
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        isLoading = true;
      });
      Common response = await AuthRepository().setPasswordApiCall(
          email: widget.email, password: password.text.trim());

      if (response.success == 'Password Set Successfully') {
        await userLogin();
      } else {
        toastShow(message: "Password is already set");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  userLogin() async {
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
        toastShow(message: "Password set successfully");
        AppConstant.userData = response.success;
        AppConstant.userDetailSaved(jsonEncode(response.success));
        Get.to(() => const QuestionScreen());
      } else {
        toastShow(message: "You entered wrong password");
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
