import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/event/event.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/screen/event_detail/event_detail_screen.dart';
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
  List<EventData> eventData = [];
  bool isLoading = false;
  String selectedData = '16-02-2024';
  int selectedCalender = 0;
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    getEventData();
    super.initState();
  }

  getEventData() async {
    try {
      setState(() {
        isLoading = true;
      });
      EventRes response = await EventRepository().allEventListApiCall();
      if (response.event!.isNotEmpty) {
        eventData = response.event!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                        fontFamily: 'inter',
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
                        fontFamily: 'inter',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    dateButton(
                      '16 Feb',
                      () {
                        setState(() {
                          selectedData = '16-02-2024';
                        });
                      },
                      '16-02-2024',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    dateButton(
                      '17 Feb',
                      () {
                        setState(() {
                          selectedData = '17-02-2024';
                        });
                      },
                      '17-02-2024',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    dateButton(
                      '18 Feb',
                      () {
                        setState(() {
                          selectedData = '18-02-2024';
                        });
                      },
                      '18-02-2024',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .615,
            child: isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemCount: 5,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return notificationSkeleton();
                    },
                  )
                : selectedCalender == 0
                    ? const SizedBox()
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 20),
                        shrinkWrap: true,
                        itemCount: eventData.length,
                        itemBuilder: (context, index) {
                          return selectedData == eventData[index].eventDate!
                              ? GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => EventDetailScreen(
                                        eventData: eventData[index],
                                      ),
                                    );
                                  },
                                  child: eventListing(
                                      context: context,
                                      eventData: eventData[index]),
                                )
                              : const SizedBox();
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget notificationSkeleton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          shadowColor: ColorConstants.mainColor,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.9, color: ColorConstants.mainColor),
            ),
            padding:
                const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
            child: SkeletonTheme(
              themeMode: ThemeMode.light,
              child: SkeletonItem(
                  child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 6,
                            spacing: 10,
                            lineStyle: SkeletonLineStyle(
                              randomLength: false,
                              // height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 6,
                              maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ));
  }

  Widget dateButton(String? title, VoidCallback? onTap, String? index) {
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
                fontFamily: 'inter',
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
