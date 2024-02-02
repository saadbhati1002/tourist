import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/custom_image_view.dart';

customAppBar(
  key, {
  BuildContext? context,
  Function? setState,
}) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 60,
    titleSpacing: 0,
    backgroundColor: ColorConstants.white,
    centerTitle: false,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        Get.to(() => const ProfileScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 9.5, bottom: 9.5, left: 9.5),
        height: 47,
        width: MediaQuery.of(context!).size.width * .6,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.7],
            colors: [
              ColorConstants.gradientColor,
              ColorConstants.mainColor,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImage(
                height: 32,
                width: 32,
                isFromAppBar: true,
                imagePath: AppConstant.userData!.logo3,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .37,
                child: Text(
                  getUserName(),
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: "inter",
                      fontSize: 14,
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 3, right: 10),
        child: GestureDetector(
          onTap: () {
            key.currentState!.openEndDrawer();
          },
          child: const FaIcon(
            FontAwesomeIcons.bars,
            color: ColorConstants.mainColor,
          ),
        ),
      )
    ],
  );
}

getUserName() {
  String name = AppConstant.userData!.firstName!.replaceAll(" ", "").trim();
  if (AppConstant.userData!.middleName != null &&
      AppConstant.userData!.middleName != "null" &&
      AppConstant.userData!.middleName != "") {
    name =
        "$name ${AppConstant.userData!.middleName!.replaceAll(" ", "").trim()}";
  }
  if (AppConstant.userData!.lastName != null) {
    name =
        "$name ${AppConstant.userData!.lastName!.replaceAll(" ", "").trim()}";
  }
  return name;
}
