import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/find_people/find_people_screen.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/screen/qr_code/qr_code_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_image_view.dart';

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
                  'Find People',
                  () {
                    Get.to(() => const FindPeopleScreen());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Favorite',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Guest List',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Notification Settings',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'External Link 1',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'External Link 2',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'External Link 3',
                  () {},
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
}
