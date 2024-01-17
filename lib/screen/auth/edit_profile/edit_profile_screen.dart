import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/models/updateProfile/update_profile_model.dart';
import 'package:tourist/screen/dashboard/dashboard_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';

import 'package:tourist/widgets/custom_image_view.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController personalBio = TextEditingController();
  TextEditingController companyBio = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  File? imageSelected;
  @override
  void initState() {
    checkData();
    super.initState();
  }

  checkData() async {
    if (AppConstant.userData!.firstName != null) {
      firstName = TextEditingController(text: AppConstant.userData!.firstName!);
    }
    if (AppConstant.userData!.middleName != null) {
      middleName =
          TextEditingController(text: AppConstant.userData!.middleName!);
    }
    if (AppConstant.userData!.lastName != null) {
      lastName = TextEditingController(text: AppConstant.userData!.lastName!);
    }
    if (AppConstant.userData!.jobTitle != null) {
      designation =
          TextEditingController(text: AppConstant.userData!.jobTitle!);
    }
    if (AppConstant.userData!.companyName != null) {
      companyName =
          TextEditingController(text: AppConstant.userData!.companyName);
    }
    if (AppConstant.userData!.email != null) {
      email = TextEditingController(text: AppConstant.userData!.email);
    }
    if (AppConstant.userData!.mobile != null) {
      phoneNumber = TextEditingController(text: AppConstant.userData!.mobile);
    }
    if (AppConstant.userData!.country != null) {
      country = TextEditingController(text: AppConstant.userData!.country);
    }
    if (AppConstant.userData!.personalBio != null) {
      personalBio =
          TextEditingController(text: AppConstant.userData!.personalBio);
    }
    if (AppConstant.userData!.companyProfile != null) {
      companyBio =
          TextEditingController(text: AppConstant.userData!.companyProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        imagePickerPopUp();
                      },
                      child: SizedBox(
                        height: 105,
                        width: 105,
                        child: Stack(
                          children: [
                            imageSelected != null
                                ? SizedBox(
                                    height: 105,
                                    width: 105,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          imageSelected!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 105,
                                    width: 105,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 10),
                                      child: CustomImage(
                                        height: 95,
                                        width: 95,
                                        imagePath: AppConstant.userData!.logo3!,
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                commonTextStyle('First Name'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: firstName,
                    hintText: "Enter your first name",
                    context: context,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                commonTextStyle('Middle Name'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: middleName,
                    hintText: "Enter your middle name",
                    context: context,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                commonTextStyle('Last Name'),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextFormField(
                    controller: lastName,
                    hintText: "Enter your Last name",
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
                    controller: personalBio,
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
                    controller: companyBio,
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
                      if (AppConstant.userData!.logo3 != null &&
                          AppConstant.userData!.logo3 != '') {
                        updateProfile(false);
                      } else {
                        if (imageSelected == null) {
                          toastShow(message: 'Please select your image');
                          return;
                        }
                        updateProfile(true);
                      }
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
          isLoading ? const ShowProgressBar() : const SizedBox()
        ],
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
            fontFamily: 'inter',
            fontWeight: FontWeight.w700),
      ),
    );
  }

  void imagePickerPopUp() async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstants.greyLight),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              elevation: 0,
              backgroundColor: ColorConstants.white,
              actionsPadding: const EdgeInsets.symmetric(vertical: 0),
              title: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(15)),
                // height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Encloser',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromGallery();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: Text(
                              'Gallery',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorConstants.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                            imageFromCamera();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ColorConstants.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  imageFromCamera() async {
    try {
      final XFile? result =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);
      if (result != null) {
        imageSelected = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
      // toastShow(message: TagLine.catchError);
    }
  }

  imageFromGallery() async {
    try {
      final XFile? result = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 75);
      if (result != null) {
        imageSelected = File(result.path);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
      // toastShow(message: TagLine.catchError);
    }
  }

  updateProfile(bool updateType) async {
    if (firstName.text.isEmpty) {
      toastShow(message: "Please enter your first name");
      return;
    }
    if (designation.text.isEmpty) {
      toastShow(message: "Please enter your designation");
      return;
    }
    if (companyName.text.isEmpty) {
      toastShow(message: "Please enter your company name");
      return;
    }
    if (email.text.isEmpty) {
      toastShow(message: "Please enter your email");
      return;
    }
    if (!email.text.contains(".com")) {
      toastShow(message: "Please enter correct email");
      return;
    }
    if (phoneNumber.text.isEmpty) {
      toastShow(message: "Please enter your mobile number");
      return;
    }
    if (country.text.isEmpty) {
      toastShow(message: "Please enter your country");
      return;
    }
    if (personalBio.text.isEmpty) {
      toastShow(message: "Please enter personal bio");
      return;
    }
    if (companyBio.text.isEmpty) {
      toastShow(message: "Please enter company bio");
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      UpdateProfile response = await AuthRepository().userProfileUpdateApiCall(
          companyName: companyName.text.toString(),
          companyProfile: companyBio.text.toString(),
          country: country.text.toString(),
          email: email.text.toString(),
          firstName: firstName.text.toString(),
          jobTitle: designation.text.toString(),
          lastName: lastName.text.toString(),
          middleName: middleName.text.toString(),
          mobileNumber: phoneNumber.text.toString(),
          isProfileUpdated: updateType,
          personalBio: personalBio.text.toString(),
          userImage: imageSelected);
      if (response.message == 'Profile updated successfully') {
        AppConstant.userData = response.data;

        AppConstant.userDetailSaved(
          jsonEncode(AppConstant.userData),
        );
        Get.to(() => const DashBoardScreen());
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
