import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/auth.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/screen/auth/password_set/set_password_screen.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.loose,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(Images.dubai),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .09,
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
                  height: MediaQuery.of(context).size.height * .12,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Enter Your Registered Email Address",
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomTextFormField(
                    controller: email,
                    hintText: "Enter your email address",
                    context: context,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CommonButton(
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      checkEmail();
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
          ),
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
      ),
    );
  }

  checkEmail() async {
    if (email.text.isEmpty) {
      toastShow(message: "Please enter your email");
      return;
    }
    if (!email.text.toString().contains(".com")) {
      toastShow(message: "Please enter a valid email");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      Common response =
          await AuthRepository().checkEmail(email: email.text.trim());
      if (response.success == 'This email is registered but Password not Set') {
        Get.to(
          () => SetPasswordScreen(email: email.text.trim()),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = true;
      });
    }
  }
}
