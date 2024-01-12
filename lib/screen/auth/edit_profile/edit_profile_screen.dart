import 'package:flutter/material.dart';
import 'package:tourist/screen/dashboard/dashboard_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullName = TextEditingController(text: 'Demo User');
  TextEditingController designation =
      TextEditingController(text: 'Founder, CEO');
  TextEditingController companyName =
      TextEditingController(text: 'Demo Company');
  TextEditingController email = TextEditingController(text: 'demo@gmail.com');
  TextEditingController phoneNumber =
      TextEditingController(text: '+971501234567');
  TextEditingController country = TextEditingController(text: 'UAE');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 105,
                  width: 105,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 105,
                        width: 105,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: Image.asset(
                            Images.userMain,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.black),
                          child: Image.asset(
                            Images.edit,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            commonTextStyle('Full Name'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: fullName,
                hintText: "Enter your full name",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Designation'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: designation,
                hintText: "Enter your designation",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Company Name'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: companyName,
                hintText: "Enter your company name",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Email'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: email,
                hintText: "Enter your email",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Phone Number'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: phoneNumber,
                hintText: "Enter your phone number",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Country'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                controller: country,
                hintText: "Enter your country",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Personal Bio'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                isMaxLine: true,
                hintText: "Enter your personal bio",
                context: context,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            commonTextStyle('Company Bio'),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                isMaxLine: true,
                hintText: "Enter your company bio",
                context: context,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CommonButton(
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashBoardScreen()));
                },
                title: "Update",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTextStyle(String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title!,
        style: TextStyle(
            fontSize: 14,
            color: ColorConstants.black,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
