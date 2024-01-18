import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourist/screen/event_list/event_list.dart';
import 'package:tourist/screen/home/home_screen.dart';
import 'package:tourist/screen/network/network_screen.dart';
import 'package:tourist/screen/notification/notification_screen.dart';
import 'package:tourist/utility/color.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  int _pageIndex = 0;
  TabController? _tabController;
  final _screens = [
    const HomeScreen(),
    const NetworkScreen(),
    const EventListScreen(),
    const NotificationScreen(),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  Future<bool> willPopScope() {
    appClosePopUP();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: SafeArea(
        top: true,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: ColorConstants.white,
            bottomNavigationBar: Material(
              color: ColorConstants.black,
              child: TabBar(
                indicatorWeight: 0.01,
                controller: _tabController,
                onTap: (index) {
                  _setPage(index);
                },
                labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                indicatorColor: Colors.black,
                isScrollable: true,
                tabs: [
                  _barItem(
                      FaIcon(
                        FontAwesomeIcons.houseUser,
                        size: 22,
                        color: _pageIndex == 0
                            ? ColorConstants.white
                            : ColorConstants.greyDark,
                      ),
                      0,
                      "Home"),
                  _barItem(
                      FaIcon(
                        FontAwesomeIcons.circleNodes,
                        size: 22,
                        color: _pageIndex == 1
                            ? ColorConstants.white
                            : ColorConstants.greyDark,
                      ),
                      1,
                      "Network"),
                  _barItem(
                      FaIcon(
                        FontAwesomeIcons.calendarDay,
                        size: 22,
                        color: _pageIndex == 2
                            ? ColorConstants.white
                            : ColorConstants.greyDark,
                      ),
                      2,
                      "Schedule"),
                  _barItem(
                      FaIcon(
                        FontAwesomeIcons.solidBell,
                        size: 22,
                        color: _pageIndex == 3
                            ? ColorConstants.white
                            : ColorConstants.greyDark,
                      ),
                      3,
                      "Notifications"),
                ],
              ),
            ),
            body: _screens[_pageIndex],
          ),
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  Widget _barItem(FaIcon? icon, int index, String? title) {
    return index == _pageIndex
        ? SizedBox(
            height: 65,
            width: MediaQuery.of(context).size.width * .37,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 5),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 3,
                shadowColor: Colors.yellowAccent,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.4],
                      colors: [
                        ColorConstants.gradientColor,
                        ColorConstants.mainColor,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon!,
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        title!,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "inter",
                            color: ColorConstants.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: 65,
            width: MediaQuery.of(context).size.width * .2,
            alignment: Alignment.center,
            child: icon!);
  }

  void appClosePopUP() async {
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
                      'Do you want to close this app?',
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
                            exit(0);
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
}
