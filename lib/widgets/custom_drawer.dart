import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/favourite/favourite_screen.dart';
import 'package:tourist/screen/find_people/find_people_screen.dart';
import 'package:tourist/screen/qr_code/qr_code_screen.dart';
import 'package:tourist/screen/splash/splash.dart';
import 'package:tourist/screen/users/users_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        color: ColorConstants.white,
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingText(
                  'Share My QR Code',
                  () {
                    Get.to(() => const QRCodeScreen());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Delegates',
                  () {
                    Get.to(() => const FindPeopleScreen());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Speakers',
                  () {
                    Get.to(
                      () => UsersScreen(
                        userType: "Speaker",
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Media',
                  () {
                    Get.to(
                      () => UsersScreen(
                        userType: "Media",
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Staff',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Favorite',
                  () {
                    Get.to(() => const FavoriteScreen());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                // headingText(
                //   'Guest List',
                //   () {},
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // headingText(
                //   'Notification Settings',
                //   () {},
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // headingText(
                //   'External Link 1',
                //   () {},
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // headingText(
                //   'External Link 2',
                //   () {},
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                // headingText(
                //   'External Link 3',
                //   () {},
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                headingText(
                  'Log Out',
                  () {
                    Navigator.pop(context);
                    logOutPopUp();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: ColorConstants.mainColor,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.squareXmark,
                    color: ColorConstants.mainColor,
                    size: 35,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headingText(String? title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: ColorConstants.mainColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title!,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'inter',
                  color: ColorConstants.black,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  void logOutPopUp() async {
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
                      'Are you sure?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      'Do you want to logout from this app?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstants.black,
                        fontSize: 14,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstants.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            userLogOut();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstants.white),
                              ),
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

  userLogOut() async {
    await AppConstant.userDetailSaved("null");
    toastShow(message: "Log out successfully");
    Get.to(() => const SplashScreen());
  }
}
