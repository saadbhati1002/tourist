import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/event/event.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/screen/event_detail/event_detail_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';
import 'package:tourist/widgets/custom_event_list.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<EventData> eventData = [];
  bool isLoading = false;
  bool isAPiCalling = false;
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
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCalender = 0;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .475,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCalender == 0
                        ? ColorConstants.mainColor
                        : ColorConstants.greySimple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendarPlus,
                        color: selectedCalender == 0
                            ? ColorConstants.white
                            : ColorConstants.greyDark,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'My Calendar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'inter',
                          color: selectedCalender == 0
                              ? ColorConstants.white
                              : ColorConstants.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCalender = 1;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .475,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCalender == 1
                        ? ColorConstants.mainColor
                        : ColorConstants.greySimple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.listCheck,
                        color: selectedCalender == 1
                            ? ColorConstants.white
                            : ColorConstants.greyDark,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Event Schedule',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'inter',
                          color: selectedCalender == 1
                              ? ColorConstants.white
                              : ColorConstants.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
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
                                      onTap: () async {
                                        var response = await Get.to(
                                          () => EventDetailScreen(
                                            eventData: eventData[index],
                                          ),
                                        );
                                        if (response != null) {
                                          if (response == 1) {
                                            if (eventData[index]
                                                    .isAttendingEvent ==
                                                false) {
                                              eventData[index]
                                                  .isAttendingEvent = true;
                                              eventData[index]
                                                  .userList!
                                                  .add(AppConstant.userData!);
                                            }
                                          } else {
                                            if (eventData[index]
                                                    .isAttendingEvent ==
                                                true) {
                                              eventData[index]
                                                  .isAttendingEvent = false;
                                              eventData[index]
                                                  .userList!
                                                  .removeWhere(
                                                    (element) =>
                                                        element.id.toString() ==
                                                        AppConstant.userData!.id
                                                            .toString(),
                                                  );
                                            }
                                          }
                                          setState(() {});
                                        }
                                      },
                                      child: eventListing(
                                          isEventJoin:
                                              checkUserJoinInEvent(index),
                                          context: context,
                                          eventData: eventData[index],
                                          attendEvent: () {
                                            if (eventData[index]
                                                    .isAttendingEvent ==
                                                false) {
                                              joinEvent(index);
                                            } else {
                                              leaveEvent(index);
                                            }
                                          },
                                          addToMyCalender: () {
                                            print("saad");
                                            if (eventData[index]
                                                    .isSavedToMyCalender ==
                                                false) {
                                              addEventToMyCalender(index);
                                            } else {
                                              // leaveEvent(index);
                                            }
                                          }),
                                    )
                                  : const SizedBox();
                            },
                          ),
              ),
            ],
          ),
          isAPiCalling ? const ShowProgressBar() : const SizedBox()
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

  checkUserJoinInEvent(index) {
    if (eventData[index].userList != null ||
        eventData[index].userList!.isNotEmpty) {
      var contain = eventData[index].userList!.where((element) =>
          element.id.toString() == AppConstant.userData!.id.toString());

      if (contain.isNotEmpty) {
        eventData[index].isAttendingEvent = true;
      }
    }
  }

  joinEvent(index) async {
    try {
      setState(() {
        isAPiCalling = true;
      });
      Common response = await EventRepository()
          .joinEventApiCall(eventID: eventData[index].id.toString());
      if (response.message == 'JOIN EVENT inserted successfully') {
        toastShow(message: "You are join to this successfully");
        eventData[index].isAttendingEvent = true;
        eventData[index].userList!.add(AppConstant.userData!);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isAPiCalling = false;
      });
    }
  }

  leaveEvent(index) async {
    try {
      setState(() {
        isAPiCalling = true;
      });
      Common response = await EventRepository()
          .leaveEventApiCall(eventID: eventData[index].id.toString());
      if (response.message == 'JOIN EVENT deleted successfully') {
        toastShow(message: "You leaved this event successfully");
        eventData[index].isAttendingEvent = false;
        eventData[index].userList!.removeWhere(
              (element) =>
                  element.id.toString() == AppConstant.userData!.id.toString(),
            );
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isAPiCalling = false;
      });
    }
  }
  //save event to my calender api integration

  addEventToMyCalender(index) async {
    try {
      setState(() {
        isAPiCalling = true;
      });
      Common response = await EventRepository()
          .addEventToMyCalenderApiCall(eventID: eventData[index].id.toString());
      if (response.message == 'Event added to favorites successfully') {
        toastShow(message: "Event added to your calender successfully");
        eventData[index].isSavedToMyCalender = true;
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isAPiCalling = false;
      });
    }
  }
}
