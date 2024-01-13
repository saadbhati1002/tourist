import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/find_people/find_people_screen.dart';
import 'package:tourist/screen/note/note_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';
import 'package:tourist/widgets/custom_user_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  setStateNow() {
    setState(() {});
  }

  int userIndex = 3;
  List userType = [
    'Delegate',
    'Vendor',
    'Speaker',
    'Delegate',
    'Media',
    'Vendor'
  ];
  List whatsON = [Images.homeBanner2, Images.homeBanner1];
  List sponsorList = [Images.sponsor];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      key: _key,
      appBar: customAppBar(_key, context: context, setState: setStateNow),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: Image.asset(
                Images.homeBanner1,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            customHeadingText(title: 'WHATS ON'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: whatsON.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return customBannerImage(whatsON[index], () {});
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            customHeadingText(title: 'QUICK ACTIONS'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customActionButton(
                    "Quick Notes",
                    Images.notes,
                    () {
                      Get.to(
                        () => const QuickScreen(),
                      );
                    },
                  ),
                  customActionButton(
                    "Leader Board",
                    Images.leaderboard,
                    () {},
                  ),
                  customActionButton(
                    "Guest List",
                    Images.meeting,
                    () {
                      Get.to(
                        () => const FindPeopleScreen(),
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            customHeadingText(title: 'RECOMMENDED CONNECTIONS'),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: userIndex,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: UserListData(
                    userType: userType[index],
                  ),
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (userIndex == 3) {
                      setState(() {
                        userIndex = 6;
                      });
                    } else {
                      setState(() {
                        userIndex = 3;
                      });
                    }
                  },
                  child: Text(
                    userIndex == 3 ? "Load More" : "Show Less",
                    style: const TextStyle(
                        fontSize: 14,
                        color: ColorConstants.greyLight,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'inter'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            customHeadingText(title: 'SPONSORS & PARTNERS'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sponsorList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return customBannerImage(sponsorList[index], () {});
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget customActionButton(String? title, String? image, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
            color: ColorConstants.mainColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image!),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "poppins",
                  color: ColorConstants.white),
            )
          ],
        ),
      ),
    );
  }

  Widget customHeadingText({String? title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        title!,
        style: TextStyle(
            color: ColorConstants.black,
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget customBannerImage(String? image, Function? onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width * .65,
          child: Image.asset(
            image!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
