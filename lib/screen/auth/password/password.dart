import 'package:flutter/material.dart';
import 'package:tourist/screen/auth/password_set/set_password_screen.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController password = TextEditingController();
  bool isPassword = true;

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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CommonButton(
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetPasswordScreen(),
                        ),
                      );
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
    );
  }
}
