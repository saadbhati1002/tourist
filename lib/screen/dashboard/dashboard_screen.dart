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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
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
}
