import 'package:flutter/material.dart';
import 'package:tourist/api/repository/auth.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/screen/account_setup/question_screen.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

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
                  height: MediaQuery.of(context).size.height * .12,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(Images.dubai),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CommonButton(
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      setNewPassword();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const QuestionScreen(),
                      //   ),
                      // );
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
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
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
      setState(() {
        isLoading = true;
      });
      Common response = await AuthRepository()
          .setPassword(email: widget.email, password: password.text.trim());
      print(response.success);
      if (response.success == 'Password Set Successfully') {
        toastShow(message: response.success);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
