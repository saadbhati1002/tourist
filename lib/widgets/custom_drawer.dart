import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';

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
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 50,
                    width: MediaQuery.of(context).size.width * .66,
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
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(Images.user),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              'Thomas Brian Samuel',
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
                const SizedBox(
                  height: 25,
                ),
                headingText(
                  'Share My QR Code',
                  () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                headingText(
                  'Find People',
                  () {},
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Images.dubai),
                    Image.asset(Images.government),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headingText(String? title, Function? onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1.5,
          color: ColorConstants.black,
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
                fontFamily: 'poppins',
                color: ColorConstants.black,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
