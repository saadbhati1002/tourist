import 'dart:ui' as ui;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/api/repository/user/user.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/favorite/favorite_model.dart';
import 'package:tourist/models/user/guest_user_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:tourist/screen/chat/chat_screen.dart';
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
  final GlobalKey _globalKey = GlobalKey();
  bool isApiLoading = false;
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
    setAnalytics();
    if (widget.isFromGuest == true) {
      getData();
    } else {
      setState(() {
        userData = AppConstant.userData;
      });
    }
    super.initState();
  }

  setAnalytics() async {
    await FirebaseAnalytics.instance
        .logScreenView(screenName: 'Profile Detail Screen');
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    await getUserDetails();
    await getFavoriteUserList();
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
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  getFavoriteUserList() async {
    setState(() {
      isLoading = true;
    });
    FavoriteRes response = await AuthRepository().favoriteUsersListApiCall();
    if (response.data != null) {
      var checked = response.data!.where((element) =>
          element.joinedUsers!.id.toString() == userData!.id.toString());
      if (checked.isNotEmpty) {
        setState(() {
          userData!.isUserFavorite = true;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> willPopScope() {
    if (userData!.isUserFavorite == true) {
      Navigator.pop(context, 1);
    } else {
      Navigator.pop(context, 0);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: customAppBarBack(
            context: context,
            onTap: () {
              if (userData!.isUserFavorite == true) {
                Navigator.pop(context, 1);
              } else {
                Navigator.pop(context, 0);
              }
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
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .8,
                          width: MediaQuery.of(context).size.width * 1,
                          child: const ShowProgressBar())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .3,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          stops: [0, 1],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF85153E),
                                            Color(0xFF30141D),
                                          ],
                                        ),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 90,
                                                          width: 90,
                                                          child: Stack(
                                                            children: [
                                                              CustomImage(
                                                                height: 90,
                                                                width: 90,
                                                                imagePath:
                                                                    userData!
                                                                        .logo3!,
                                                              ),
                                                              userData!.userType !=
                                                                      null
                                                                  ? Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomLeft,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            90,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: const BorderRadius.only(
                                                                              bottomLeft: Radius.circular(
                                                                                5,
                                                                              ),
                                                                              bottomRight: Radius.circular(5),
                                                                            ),
                                                                            gradient: LinearGradient(
                                                                              stops: [
                                                                                0,
                                                                                1
                                                                              ],
                                                                              begin: Alignment.topLeft,
                                                                              end: Alignment.bottomRight,
                                                                              colors: userData!.userType == "Delegate"
                                                                                  ? [
                                                                                      Color(0xFF433C3D),
                                                                                      Color(0xFF1B1819),
                                                                                    ]
                                                                                  : userData!.userType == 'Holders '
                                                                                      ? [
                                                                                          ColorConstants.bagColor,
                                                                                          ColorConstants.bagColor,
                                                                                        ]
                                                                                      : userData!.userType == 'Media'
                                                                                          ? [
                                                                                              Color(0xFFF8A57E),
                                                                                              Color(0xFFBB6358),
                                                                                            ]
                                                                                          : [
                                                                                              ColorConstants.white,
                                                                                              ColorConstants.white,
                                                                                            ],
                                                                            ),
                                                                            color: userData!.userType == "Delegate"
                                                                                ? ColorConstants.delegateColor
                                                                                : userData!.userType == 'Holders '
                                                                                    ? ColorConstants.vendorColor
                                                                                    : userData!.userType == 'Media'
                                                                                        ? ColorConstants.mediaColor
                                                                                        : ColorConstants.speakerColor),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          userData!
                                                                              .userType!,
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontFamily: 'inter',
                                                                              color: userData!.userType == "Delegate" || userData!.userType == "Media" ? ColorConstants.bagColor : ColorConstants.black),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .5,
                                                          child: Text(
                                                            userData!.companyName ==
                                                                    "null"
                                                                ? ''
                                                                : userData!
                                                                    .companyName!,
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    ColorConstants
                                                                        .bagColor,
                                                                fontFamily:
                                                                    'inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Text(
                                                    getUserName(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: ColorConstants
                                                            .bagColor,
                                                        fontFamily: 'inter',
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    userData!.jobTitle ?? '',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: ColorConstants
                                                            .bagColor,
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
                                                        color: ColorConstants
                                                            .bagColor,
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
                                                            color:
                                                                ColorConstants
                                                                    .bagColor,
                                                            fontFamily: 'inter',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        userData!.country !=
                                                                "null"
                                                            ? userData!.country
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                ColorConstants
                                                                    .bagColor,
                                                            fontFamily: 'inter',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    favoriteDesign(
                                      FaIcon(FontAwesomeIcons.star,
                                          size: 18,
                                          color:
                                              (userData!.isUserFavorite == true)
                                                  ? ColorConstants.bagColor
                                                  : ColorConstants.black),
                                      'Favorite',
                                      () {
                                        if (userData!.isUserFavorite == true) {
                                          removeUserFromFavorite();
                                        } else {
                                          saveToFavorite();
                                        }
                                      },
                                    ),
                                    customButtons(
                                      FaIcon(
                                        FontAwesomeIcons.floppyDisk,
                                        color: ColorConstants.bagColor,
                                        size: 18,
                                      ),
                                      'Save as contact',
                                      () async {
                                        try {
                                          if (await FlutterContacts
                                              .requestPermission()) {
                                            final newContact = Contact()
                                              ..name.first =
                                                  userData!.firstName ?? ''
                                              ..name.last =
                                                  userData!.lastName ?? ''
                                              ..emails = [
                                                Email(userData!.email ?? '')
                                              ]
                                              ..organizations = [
                                                Organization(
                                                    company:
                                                        userData!.companyName ??
                                                            '',
                                                    title: userData!.jobTitle ??
                                                        '',
                                                    officeLocation:
                                                        userData!.country ?? '')
                                              ]
                                              ..phones = [
                                                Phone(userData!.mobile ?? '')
                                              ];
                                            await newContact.insert();

                                            toastShow(
                                                message:
                                                    "Contact Saved Successfully to your contact");
                                          }
                                        } catch (e) {
                                          toastShow(message: e.toString());
                                        }
                                      },
                                    ),
                                    customButtons(
                                      FaIcon(
                                        FontAwesomeIcons.solidCommentDots,
                                        size: 18,
                                        color: ColorConstants.bagColor,
                                      ),
                                      'Chat',
                                      () async {
                                        var response = await Get.to(
                                          () => ChatScreen(
                                            userData: userData,
                                          ),
                                        );
                                        if (response == 1) {
                                          userData!.isUserFavorite = true;
                                        } else {
                                          userData!.isUserFavorite = false;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    customButtons(
                                      FaIcon(
                                        FontAwesomeIcons.penToSquare,
                                        size: 18,
                                        color: ColorConstants.bagColor,
                                      ),
                                      'Edit profile',
                                      () {
                                        Get.to(() => const EditProfileScreen());
                                      },
                                    ),
                                    customButtons(
                                      FaIcon(
                                        FontAwesomeIcons.qrcode,
                                        size: 18,
                                        color: ColorConstants.bagColor,
                                      ),
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
              isApiLoading ? const ShowProgressBar() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButtons(FaIcon? icon, String? title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF85153E),
              Color(0xFF30141D),
            ],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              const SizedBox(
                width: 5,
              ),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'inter',
                  color: ColorConstants.bagColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget favoriteDesign(FaIcon? icon, String? title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: (userData!.isUserFavorite == true)
                ? [
                    Color(0xFF85153E),
                    Color(0xFF30141D),
                  ]
                : [
                    ColorConstants.white,
                    ColorConstants.white,
                  ],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!,
              const SizedBox(
                width: 5,
              ),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'inter',
                  color: (userData!.isUserFavorite == true)
                      ? ColorConstants.bagColor
                      : ColorConstants.black,
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.white),
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
    String name = userData!.firstName!.replaceAll(" ", "").trim();
    if (userData!.middleName != null &&
        userData!.middleName != "null" &&
        userData!.middleName != "") {
      name = "$name ${userData!.middleName!.replaceAll(" ", "").trim()}";
    }
    if (userData!.lastName != null) {
      name = "$name ${userData!.lastName!.replaceAll(" ", "").trim()}";
    }
    return name;
  }

  getMainUserName() {
    String name = AppConstant.userData!.firstName!;
    if (AppConstant.userData!.middleName != null) {
      name = "$name ${AppConstant.userData!.middleName}";
    }
    if (AppConstant.userData!.lastName != null) {
      name = "$name ${AppConstant.userData!.lastName}";
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
            child: Container(
              color: ColorConstants.white,
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  isLoading
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  QrImageView(
                                    constrainErrorBounds: true,
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
                                getMainUserName(),
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
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        stops: [0, 1],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF85153E),
                                          Color(0xFF30141D),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.download,
                                        color: ColorConstants.bagColor,
                                        size: 17,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Download As Image',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.bagColor,
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
                QrImageView(
                  data: vcardData,
                  constrainErrorBounds: true,
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
              getMainUserName(),
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

  saveToFavorite() async {
    try {
      setState(() {
        isApiLoading = true;
      });
      Common response = await AuthRepository()
          .addFavoriteUsersApiCall(favoriteUserID: userData!.id);
      if (response.message == 'User saved to favorite successfully') {
        setState(() {
          userData!.isUserFavorite = true;
        });
        toastShow(message: "Added to favorite");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }

  removeUserFromFavorite() async {
    try {
      setState(() {
        isApiLoading = true;
      });
      Common response = await AuthRepository()
          .removeFavoriteUsersApiCall(favoriteUserID: userData!.id);
      if (response.message == 'User saved to favorite successfully') {
        setState(() {
          userData!.isUserFavorite = false;
        });
        toastShow(message: "Removed from favorite");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }
}
