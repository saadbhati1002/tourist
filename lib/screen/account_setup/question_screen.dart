import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/models/updateProfile/update_profile_model.dart';
import 'package:tourist/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:tourist/screen/dashboard/dashboard_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/gradient_text.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isLoading = false;
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.loose,
          children: [
            Container(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .4,
                          alignment: Alignment.center,
                          child: Image.asset(Images.logoName),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        pageIndex == 1
                            ? "Whats your role?"
                            : "Question if ${AppConstant.selectedRole}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: ColorConstants.bagColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: ListView.builder(
                        itemCount: pageIndex == 1
                            ? AppConstant.roleType.length
                            : AppConstant.rolesSubRole.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return optionBox(
                              index: index,
                              title: pageIndex == 1
                                  ? AppConstant.roleType[index]
                                  : AppConstant.rolesSubRole[index]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CommonButton(
                        width: MediaQuery.of(context).size.width,
                        onTap: () {
                          checkNavigation();
                        },
                        title: "Proceed",
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
    );
  }

  Widget optionBox({String? title, int? index}) {
    return GestureDetector(
      onTap: () {
        if (pageIndex == 1) {
          setState(() {
            AppConstant.selectedRole = title;
          });
        } else if (pageIndex == 2) {
          setState(() {
            AppConstant.selectedSubRole = title;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 40,
        width: MediaQuery.of(context).size.width * .1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          gradient: AppConstant.selectedRole == title
              ? LinearGradient(
                  stops: [0, 1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF85153E),
                    Color(0xFF30141D),
                  ],
                )
              : LinearGradient(
                  colors: [ColorConstants.white, ColorConstants.white],
                ),
        ),
        alignment: Alignment.center,
        child: AppConstant.selectedRole == title
            ? Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.bagColor,
                    fontWeight: FontWeight.w600),
              )
            : GradientText(
                title!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF8A57E),
                    Color(0xFFBB6358),
                  ],
                ),
              ),
      ),
    );
  }

  getColorBoxCOlor({String? title}) {
    Color color = ColorConstants.greyLight;
    if (pageIndex == 1) {
      if (AppConstant.selectedRole == title!) {
        color = ColorConstants.mainColor;
      }
    }
    if (pageIndex == 2) {
      if (AppConstant.selectedSubRole == title!) {
        color = ColorConstants.mainColor;
      }
    }
    return color;
  }

  getTextColor({String? title}) {
    Color color = ColorConstants.black;
    if (pageIndex == 1) {
      if (AppConstant.selectedRole == title!) {
        color = ColorConstants.white;
      }
    }
    if (pageIndex == 2) {
      if (AppConstant.selectedSubRole == title!) {
        color = ColorConstants.white;
      }
    }
    return color;
  }

  checkNavigation() {
    if (pageIndex == 1) {
      if (AppConstant.selectedRole == null) {
        toastShow(message: "Please select your role.");
        return;
      } else if (AppConstant.selectedRole != null) {
        setUserType();
        // setState(() {
        //   // pageIndex = 2;
        // });
      }
    } else if (pageIndex == 2) {
      if (AppConstant.selectedSubRole == null) {
        toastShow(message: "Please select your sub role.");
        return;
      } else {
        Get.to(() => const DashBoardScreen());
      }
    }
  }

  setUserType() async {
    try {
      setState(() {
        isLoading = true;
      });
      UpdateProfile response = await AuthRepository()
          .updateUserTypeApiCall(userType: AppConstant.selectedRole);
      if (response.message == 'Profile updated successfully') {
        AppConstant.userData = response.data;

        AppConstant.userDetailSaved(
          jsonEncode(AppConstant.userData),
        );
        Get.to(
          () => const EditProfileScreen(
            isFromAccountSetup: true,
          ),
        );
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
