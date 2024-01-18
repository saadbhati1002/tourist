import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/banner/banner.dart';
import 'package:tourist/models/banner/banner_model.dart';
import 'package:tourist/screen/find_people/find_people_screen.dart';
import 'package:tourist/screen/note/note_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBanner1Loading = false;
  bool isBanner2Loading = false;
  bool isSponsorBannerLoading = false;
  List<BannerData> banner1List = [];
  List<BannerData> banner2List = [];
  List<BannerData> sponsorBannerList = [];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  setStateNow() {
    setState(() {});
  }

  int userIndex = 3;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      isBanner1Loading = true;
      isBanner1Loading = true;
      isSponsorBannerLoading = true;
    });
    if (mounted) {
      await getBanner1();
      await getBanner2();
      await getSponsorBanner();
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
      setState(() {
        isBanner1Loading = false;
      });
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
          isBanner1Loading = false;
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
      setState(() {
        isSponsorBannerLoading = false;
      });
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
              banner2List.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customHeadingText(title: 'WHATS ON'),
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
                        color: ColorConstants.white,
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
                        color: ColorConstants.white,
                        size: 30,
                      ),
                      () {},
                    ),
                    customActionButton(
                      "Guest List",
                      FaIcon(
                        FontAwesomeIcons.users,
                        color: ColorConstants.white,
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 0,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: UserListData(),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         if (userIndex == 3) {
              //           setState(() {
              //             userIndex = 6;
              //           });
              //         } else {
              //           setState(() {
              //             userIndex = 3;
              //           });
              //         }
              //       },
              //       child: Text(
              //         userIndex == 3 ? "Load More" : "Show Less",
              //         style: const TextStyle(
              //             fontSize: 14,
              //             color: ColorConstants.greyLight,
              //             fontWeight: FontWeight.w600,
              //             fontFamily: 'inter'),
              //       ),
              //     )
              //   ],
              // ),
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
            color: ColorConstants.mainColor,
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
                    color: ColorConstants.white),
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
      child: Text(
        title!,
        style: TextStyle(
            color: ColorConstants.black,
            fontSize: 14,
            fontFamily: 'inter',
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

  Widget homeBanner1() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .25,
      child: Swiper(
        itemCount: banner1List.length,
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
        scale: 0.75,
        viewportFraction: 0.7,
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
        scale: 0.75,
        viewportFraction: 0.7,
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
