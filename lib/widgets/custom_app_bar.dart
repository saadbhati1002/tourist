import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/custom_image_view.dart';

customAppBar(
  key, {
  BuildContext? context,
  Function? setState,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        Get.to(() => const ProfileScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        height: 50,
        width: MediaQuery.of(context!).size.width * .6,
        decoration: BoxDecoration(
          color: ColorConstants.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImage(
                height: 32,
                width: 32,
                imagePath: AppConstant.userData!.logo2!,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .43,
                child: Text(
                  AppConstant.userData!.username ?? getUserName(),
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 14,
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            key.currentState!.openEndDrawer();
          },
          child: Image.asset(
            Images.menu,
            color: ColorConstants.mainColor,
          ),
        ),
      )
    ],
  );
}

getUserName() {
  String name = AppConstant.userData!.firstName!;
  if (AppConstant.userData!.middleName != null) {
    name = "$name ${AppConstant.userData!.middleName}";
  }
  if (AppConstant.userData!.lastName != null) {
    name = "$name ${AppConstant.userData!.lastName}";
  }
  return name;
}
