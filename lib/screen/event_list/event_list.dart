import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';
import 'package:tourist/widgets/custom_event_list.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int selectedData = 14;
  int selectedCalender = 0;
  setStateNow() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      key: _key,
      appBar: customAppBar(
        _key,
        context: context,
        setState: setStateNow,
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedCalender = 0;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .43,
                height: 37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedCalender == 0
                      ? ColorConstants.mainColor
                      : ColorConstants.greyLight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: selectedCalender == 0
                          ? ColorConstants.white
                          : ColorConstants.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'My Calendar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins',
                        color: selectedCalender == 0
                            ? ColorConstants.white
                            : ColorConstants.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedCalender = 1;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .43,
                height: 37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedCalender == 1
                      ? ColorConstants.mainColor
                      : ColorConstants.greyLight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: selectedCalender == 1
                          ? ColorConstants.white
                          : ColorConstants.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Event Schedule',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins',
                        color: selectedCalender == 1
                            ? ColorConstants.white
                            : ColorConstants.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dateButton(
                  '14 Feb',
                  () {
                    setState(() {
                      selectedData = 14;
                    });
                  },
                  14,
                ),
                const SizedBox(
                  width: 20,
                ),
                dateButton(
                  '15 Feb',
                  () {
                    setState(() {
                      selectedData = 15;
                    });
                  },
                  15,
                ),
                const SizedBox(
                  width: 20,
                ),
                dateButton(
                  '16 Feb',
                  () {
                    setState(() {
                      selectedData = 16;
                    });
                  },
                  16,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return eventListing(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dateButton(String? title, VoidCallback? onTap, int? index) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color:
              index == selectedData ? ColorConstants.mainColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: index == selectedData
                    ? ColorConstants.white
                    : ColorConstants.black,
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
