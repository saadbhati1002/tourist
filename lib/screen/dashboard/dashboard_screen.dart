import 'package:flutter/material.dart';
import 'package:tourist/screen/home/home_screen.dart';
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
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
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
              indicatorWeight: 0.1,
              controller: _tabController,
              onTap: (index) {
                _setPage(index);
              },
              labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              indicatorColor: Colors.black,
              isScrollable: true,
              tabs: [
                _barItem(Icons.home, 0, "Home"),
                _barItem(Icons.chat_outlined, 1, "Network"),
                _barItem(Icons.calendar_month_outlined, 2, "Schedule"),
                _barItem(Icons.notifications, 3, "Notifications"),
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

  Widget _barItem(IconData icon, int index, String? title) {
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
                      color: index == _pageIndex
                          ? ColorConstants.mainColor
                          : Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 22,
                        color: ColorConstants.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        title!,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "poppins",
                            color: ColorConstants.white,
                            fontWeight: FontWeight.w500),
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
            child: Icon(
              icon,
              size: 22,
              color: ColorConstants.white,
            ),
          );
  }
}
