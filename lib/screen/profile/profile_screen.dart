import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:tourist/api/repository/user/user.dart';
import 'package:tourist/models/user/guest_user_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/custom_image_view.dart';
import 'package:tourist/widgets/show_progress_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ProfileScreen extends StatefulWidget {
  final bool? isFromGuest;
  final String? id;
  const ProfileScreen({super.key, this.isFromGuest, this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey _globalKey = GlobalKey();

  UserData? userData;
  bool isLoading = false;
  final vcardData = 'BEGIN:VCARD\n'
      'VERSION:3.0\n'
      'N:${AppConstant.userData!.firstName};${AppConstant.userData!.lastName};\n'
      'TEL;TYPE=CELL:${AppConstant.userData!.mobile}\n'
      'EMAIL:${AppConstant.userData!.email}\n'
      'ORG:${AppConstant.userData!.companyName}\n'
      'TITLE:${AppConstant.userData!.jobTitle}\n'
      'END:VCARD';
  @override
  void initState() {
    if (widget.isFromGuest == true) {
      getUserDetails();
    } else {
      setState(() {
        userData = AppConstant.userData;
      });
    }
    super.initState();
  }

  getUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      GuestDetailRes response =
          await UserRepository().getUserDetailApiCall(userID: widget.id);
      if (response.message == 'Success') {
        userData = response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
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
          qrImage(),
          Container(
            color: ColorConstants.white,
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: SingleChildScrollView(
              child: isLoading
                  ? const ShowProgressBar()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: Image.asset(
                                    Images.profileBox,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 90,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 90,
                                                      width: 90,
                                                      child: Stack(
                                                        children: [
                                                          CustomImage(
                                                            height: 90,
                                                            width: 90,
                                                            imagePath: userData!
                                                                .logo3!,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Container(
                                                              height: 15,
                                                              width: 90,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                          10,
                                                                        ),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                      ),
                                                                      color: ColorConstants
                                                                          .delegateColor),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'Delegate',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontFamily:
                                                                        'inter',
                                                                    color: ColorConstants
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .5,
                                                      child: Text(
                                                        userData!.companyName ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .white,
                                                            fontFamily: 'inter',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                userData!.username ??
                                                    getUserName(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorConstants.white,
                                                    fontFamily: 'inter',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                userData!.jobTitle ?? '',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: ColorConstants.white,
                                                    fontFamily: 'inter',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userData!.mobile!,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: ColorConstants.white,
                                                    fontFamily: 'inter',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    userData!.email ?? '',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: ColorConstants
                                                            .white,
                                                        fontFamily: 'inter',
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    userData!.country ?? '',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: ColorConstants
                                                            .white,
                                                        fontFamily: 'inter',
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (widget.isFromGuest == true) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                customButtons(
                                  Images.star,
                                  'Favorite',
                                  () {
                                    Get.to(() => const EditProfileScreen());
                                  },
                                ),
                                customButtons(
                                  Images.save,
                                  'Save as contact',
                                  () async {
                                    if (await FlutterContacts
                                        .requestPermission()) {
                                      final newContact = Contact()
                                        ..name.first = 'John'
                                        ..name.last = 'Smith'
                                        ..emails.first =
                                            Email('test@test.gmail.com')
                                        ..organizations.first = Organization(
                                            company: "test",
                                            title: "CEO",
                                            officeLocation: "Sikar")
                                        ..phones = [Phone('555-123-4567')];
                                      var response = await newContact.insert();
                                      print(response);
                                    }
                                  },
                                ),
                                customButtons(
                                  Images.chat,
                                  'Chat',
                                  () {
                                    orCodeBottomSheet();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                customButtons(
                                  Images.edit,
                                  'Edit profile',
                                  () {
                                    Get.to(() => const EditProfileScreen());
                                  },
                                ),
                                customButtons(
                                  Images.qr,
                                  'Share Card',
                                  () {
                                    orCodeBottomSheet();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                        customDataBox("Bio", userData!.personalBio ?? ''),
                        const SizedBox(
                          height: 20,
                        ),
                        customDataBox(
                            "Company Bio", userData!.companyProfile ?? ''),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customButtons(String? image, String? title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: ColorConstants.mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image!,
                color: ColorConstants.white,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'inter',
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customDataBox(String? title, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        elevation: 2,
        shadowColor: ColorConstants.greyLight,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: "inter",
                      color: ColorConstants.black),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  data!,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: "inter",
                      color: ColorConstants.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getUserName() {
    String name = userData!.firstName!;
    if (userData!.middleName != null) {
      name = "$name ${userData!.middleName}";
    }
    if (userData!.lastName != null) {
      name = "$name ${userData!.lastName}";
    }
    return name;
  }

  orCodeBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QrImage(
                              data: vcardData,
                              version: QrVersions.auto,
                              size: 180.0,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.all(25.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          getUserName(),
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.black,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          AppConstant.userData!.jobTitle!,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.black,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          AppConstant.userData!.companyName!,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.black,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            _saveLocalImage();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .65,
                            height: 35,
                            decoration: BoxDecoration(
                                color: ColorConstants.black,
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.download,
                                  color: ColorConstants.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Download As Image',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.white,
                                      fontFamily: 'inter',
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.cancel_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget qrImage() {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: vcardData,
                  version: QrVersions.auto,
                  size: 300.0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(25.0),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              getUserName(),
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              AppConstant.userData!.jobTitle!,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              AppConstant.userData!.companyName!,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * .8,
              child: Image.asset(Images.logoName),
            ),
          ],
        ),
      ),
    );
  }

  _saveLocalImage() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      if (result["isSuccess"] == true) {
        toastShow(message: "Image saved to gallery");
      }
    }
  }
}
