import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/banner/banner.dart';
import 'package:tourist/api/repository/user/user.dart';
import 'package:tourist/models/banner/banner_model.dart';
import 'package:tourist/models/recommended_user/recommended_users_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/chat/chat_screen.dart';
import 'package:tourist/screen/find_people/find_people_screen.dart';
import 'package:tourist/screen/leader_board/leader_board_screen.dart';
import 'package:tourist/screen/note/note_screen.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:tourist/widgets/gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBanner1Loading = false;
  bool isBanner2Loading = false;
  bool isSponsorBannerLoading = false;
  bool isRecommendedLoading = false;
  List<BannerData> banner1List = [];
  List<BannerData> banner2List = [];
  List<BannerData> sponsorBannerList = [];
  List<UserData> recommendedUsersList = [];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  setStateNow() {
    setState(() {});
  }

  int userIndex = 3;

  @override
  void initState() {
    getData();
    setAnalytics();
    super.initState();
  }

  setAnalytics() async {
    await FirebaseAnalytics.instance.logScreenView(screenName: 'Home Screen');
  }

  getData() async {
    setState(() {
      isBanner1Loading = true;
      isBanner2Loading = true;
      isSponsorBannerLoading = true;
      isRecommendedLoading = true;
    });
    if (mounted) {
      await getBanner1();
      await getBanner2();
      await getRecommendedUsers();
      await getSponsorBanner();
    }
  }

  getRecommendedUsers() async {
    try {
      RecommendedRes response =
          await UserRepository().getRecommendedUsersApiCall();
      if (response.recommended != null) {
        for (int userLength = 0;
            userLength < response.recommended!.length;
            userLength++) {
          if (response.recommended![userLength].userStatus == "1") {
            recommendedUsersList.add(response.recommended![userLength]);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isRecommendedLoading = false;
        });
      }
    }
  }

  getBanner1() async {
    try {
      BannerRes response = await BannerRepository().getBanner1ApiCall();
      if (response.data != null) {
        banner1List = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isBanner1Loading = false;
        });
      }
    }
    return banner1List;
  }

  getBanner2() async {
    try {
      BannerRes response = await BannerRepository().getBanner2ApiCall();
      if (response.data != null) {
        banner2List = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isBanner2Loading = false;
        });
      }
    }
    return banner2List;
  }

  getSponsorBanner() async {
    try {
      BannerRes response = await BannerRepository().getSponsorBannerApiCall();
      if (response.data != null) {
        sponsorBannerList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isSponsorBannerLoading = false;
        });
      }
    }
    return sponsorBannerList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        endDrawer: const CustomDrawer(),
        key: _key,
        appBar: customAppBar(_key, context: context, setState: setStateNow),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isBanner1Loading
                  ? errorImageBuilder()
                  : banner1List.isNotEmpty
                      ? homeBanner1()
                      : const SizedBox(),
              const SizedBox(
                height: 25,
              ),
              (banner2List.isNotEmpty || isBanner2Loading == true)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customHeadingText(title: 'SPEAKERS'),
                        const SizedBox(
                          height: 10,
                        ),
                        isBanner2Loading
                            ? errorImageBuilder()
                            : banner2List.isNotEmpty
                                ? homeBanner2()
                                : const SizedBox(),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    )
                  : const SizedBox(),
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
                      FaIcon(
                        FontAwesomeIcons.solidClipboard,
                        color: ColorConstants.bagColor,
                        size: 30,
                      ),
                      () {
                        Get.to(
                          () => const QuickScreen(),
                        );
                      },
                    ),
                    customActionButton(
                      "Leader Board",
                      FaIcon(
                        FontAwesomeIcons.trophy,
                        color: ColorConstants.bagColor,
                        size: 30,
                      ),
                      () {
                        Get.to(() => const LeaderBoardScreen());
                      },
                    ),
                    customActionButton(
                      "Guest List",
                      FaIcon(
                        FontAwesomeIcons.users,
                        color: ColorConstants.bagColor,
                        size: 30,
                      ),
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
              isRecommendedLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: UserListData(),
                        );
                      },
                    )
                  : recommendedUsersList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: UserListData(
                                userData: recommendedUsersList[index],
                                onProfileTap: () async {
                                  await Get.to(
                                    () => ProfileScreen(
                                      isFromGuest: true,
                                      id: recommendedUsersList[index]
                                          .id
                                          .toString(),
                                    ),
                                  );
                                },
                                onChatTap: () async {
                                  await Get.to(
                                    () => ChatScreen(
                                      userData: recommendedUsersList[index],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 25,
              ),
              banner2List.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customHeadingText(title: 'SPONSORS & PARTNERS'),
                        const SizedBox(
                          height: 10,
                        ),
                        isSponsorBannerLoading
                            ? errorImageBuilder()
                            : sponsorBannerList.isNotEmpty
                                ? sponsorBanner()
                                : const SizedBox(),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customActionButton(String? title, FaIcon? icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * .3,
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
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 20,
            ),
            icon!,
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "inter",
                    color: ColorConstants.bagColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customHeadingText({String? title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: GradientText(
        title!,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        gradient: LinearGradient(colors: [
          Color(0xFFF0D4B6),
          Color(0xFF6C4D34),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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

  Widget homeBanner1() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .3,
      child: Swiper(
        itemCount: banner1List.length,
        autoplay: banner1List.length > 1 ? true : false,
        onTap: (index) {
          if (banner1List[index].bannerLink != null ||
              banner1List[index].bannerLink != "") {
            launchUrl(Uri.parse(banner1List[index].bannerLink!));
          }
        },
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: banner1List[index].bannerImage!,
            imageBuilder: (context, imageProvider) {
              return Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return errorImageBuilder();
            },
            errorWidget: (context, url, error) {
              return errorImageBuilder();
            },
          );
        },
      ),
    );
  }

  Widget homeBanner2() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .25,
      child: Swiper(
        autoplay: banner2List.length > 1 ? true : false,
        scale: 0.75,
        viewportFraction: 0.9,
        itemCount: banner2List.length,
        onTap: (index) {
          if (banner2List[index].bannerLink != null ||
              banner2List[index].bannerLink != "") {
            launchUrl(Uri.parse(banner2List[index].bannerLink!));
          }
        },
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: banner2List[index].bannerImage!,
            imageBuilder: (context, imageProvider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return errorImageBuilder();
            },
            errorWidget: (context, url, error) {
              return errorImageBuilder();
            },
          );
        },
      ),
    );
  }

  Widget sponsorBanner() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .25,
      child: Swiper(
        autoplay: sponsorBannerList.length > 1 ? true : false,
        scale: 0.75,
        viewportFraction: 0.9,
        itemCount: sponsorBannerList.length,
        onTap: (index) {
          if (sponsorBannerList[index].bannerLink != null ||
              sponsorBannerList[index].bannerLink != "") {
            launchUrl(Uri.parse(sponsorBannerList[index].bannerLink!));
          }
        },
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: sponsorBannerList[index].bannerImage!,
            imageBuilder: (context, imageProvider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * .75,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return errorImageBuilder();
            },
            errorWidget: (context, url, error) {
              return errorImageBuilder();
            },
          );
        },
      ),
    );
  }

  Widget errorImageBuilder() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      child: SkeletonTheme(
        themeMode: ThemeMode.light,
        child: SkeletonAvatar(
          style: SkeletonAvatarStyle(
            shape: BoxShape.rectangle,
            height: MediaQuery.of(context).size.height * .24,
            width: MediaQuery.of(context).size.width * 1,
          ),
        ),
      ),
    );
  }
}
