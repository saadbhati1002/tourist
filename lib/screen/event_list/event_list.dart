import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/event/event.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/screen/event_detail/event_detail_screen.dart';
import 'package:tourist/screen/event_review/event_review_screen.dart';
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
  List<EventData> myEventData = [];
  bool isLoading = false;
  bool isAPiCalling = false;
  String selectedData = '16-02-2024';
  int selectedCalender = 0;
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  void dispose() {
    AppConstant.isMyEvent = true;
    super.dispose();
  }

  getData() async {
    // await getMyEvent();
    await getEventData();
  }

  getEventData() async {
    eventData = [];
    try {
      setState(() {
        isLoading = true;
      });
      if (selectedCalender == 0) {
        EventRes response = await EventRepository().getMyCalenderEventApiCall();
        eventData = response.event!;
        myEventData = response.event!;
        for (int i = 0; i < eventData.length; i++) {
          eventData[i].isSavedToMyCalender = true;
        }
      } else {
        EventRes response = await EventRepository().allEventListApiCall();
        eventData = response.event!;
        if (response.event!.isNotEmpty) {
          eventData = response.event!;
          checkForSavedEvents();
        }
      }

      return eventData;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  checkForSavedEvents() {
    for (int i = 0; i < myEventData.length; i++) {
      for (int j = 0; j < eventData.length; j++) {
        if (myEventData[i].id == eventData[j].id) {
          eventData[j].isSavedToMyCalender = true;
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
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
                    if (selectedCalender == 0) {
                      return;
                    }
                    AppConstant.isMyEvent = true;
                    setState(() {
                      selectedCalender = 0;
                    });
                    getData();
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
                    if (selectedCalender == 1) {
                      return;
                    }
                    AppConstant.isMyEvent = false;

                    setState(() {
                      selectedCalender = 1;
                    });
                    getData();
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Material(
                    elevation: 2,
                    child: Container(
                      color: ColorConstants.white,
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
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .59,
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
                      : eventData.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    (selectedCalender == 0)
                                        ? "No event saved to your calendar"
                                        : "No event found",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.greyLight,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      (selectedCalender == 0)
                                          ? "Go to event calendar and start saving events to my calendar"
                                          : "No event found",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ColorConstants.greyLight,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 20),
                              shrinkWrap: true,
                              itemCount: eventData.length,
                              itemBuilder: (context, index) {
                                return selectedData ==
                                        eventData[index].eventDate!
                                    ? GestureDetector(
                                        onTap: () async {
                                          var response = await Get.to(
                                            () => EventDetailScreen(
                                              eventData: eventData[index],
                                            ),
                                          );
                                          checkIsAnyEventLaved(response, index);
                                        },
                                        child: eventListing(
                                            isMyEvent: selectedCalender == 0
                                                ? true
                                                : false,
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
                                              if (eventData[index]
                                                      .isSavedToMyCalender ==
                                                  false) {
                                                addEventToMyCalender(index);
                                              } else {
                                                removeEventFromMyCalender(
                                                    index);
                                              }
                                            },
                                            onTapReview: () async {
                                              var response = await Get.to(
                                                () => EventReviewScreen(
                                                  eventID: eventData[index].id,
                                                ),
                                              );
                                              if (response != null) {
                                                eventData[index]
                                                    .eventReview!
                                                    .insert(
                                                      0,
                                                      EventReview(
                                                        createdDate:
                                                            DateTime.now()
                                                                .toString(),
                                                        eventId:
                                                            eventData[index]
                                                                .id
                                                                .toString(),
                                                        review:
                                                            response.toString(),
                                                        userId: AppConstant
                                                            .userData!.id
                                                            .toString(),
                                                      ),
                                                    );
                                                setState(() {});
                                              }
                                            },
                                            isEventEnded:
                                                checkEventStatus(index),
                                            isReviewSubmitted:
                                                checkForUsersReview(index)),
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

//checking user is join the event or not
  checkUserJoinInEvent(index) {
    if (eventData[index].userList != null ||
        eventData[index].userList!.isNotEmpty) {
      var contain = eventData[index].userList!.where((element) =>
          element.id.toString() == AppConstant.userData!.id.toString());

      if (contain.isNotEmpty) {
        eventData[index].isAttendingEvent = true;
      }
    }
    return false;
  }

  //check event is working or not
  checkEventStatus(index) {
    bool isEventEnded = false;
    DateTime endTime = DateTime.parse(eventData[index].endTime!);
    DateTime startTime = DateTime.parse(eventData[index].sDate!);
    if (endTime.isBefore(DateTime.now())) {
      isEventEnded = true;
    } else {
      isEventEnded = false;
    }
    if (startTime.isBefore(DateTime.now())) {
      eventData[index].eventStatus = "In Progress";
    }
    if (endTime.isBefore(DateTime.now())) {
      eventData[index].eventStatus = "Ended";
    }
    return isEventEnded;
  }

//check for users review
  checkForUsersReview(index) {
    if (eventData[index].eventReview != null &&
        eventData[index].eventReview!.isNotEmpty) {
      var contain = eventData[index].eventReview!.where((element) =>
          element.userId.toString() == AppConstant.userData!.id.toString());

      if (contain.isNotEmpty) {
        eventData[index].isReviewSubmitted = true;
      }
    }
    return false;
  }
//Join event api call

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
  //Leave event api call

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

  //remove event from my calender api call
  removeEventFromMyCalender(index) async {
    try {
      setState(() {
        isAPiCalling = true;
      });
      Common response = await EventRepository()
          .removeEventFromMyCalenderApiCall(
              eventID: eventData[index].id.toString());
      if (response.message == 'Event Remove to favorites successfully') {
        toastShow(message: "Event removed from your calender successfully");
        eventData[index].isSavedToMyCalender = false;
        if (selectedCalender == 0) {
          for (int i = 0; i < myEventData.length; i++) {
            if (eventData[index] == myEventData[i]) {
              myEventData.removeAt(i);
            }
          }
          eventData.removeAt(index);
        }
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isAPiCalling = false;
      });
    }
  }

  //checking if any any event leaved or not
  checkIsAnyEventLaved(response, index) {
    if (response != null) {
      if (response == 1) {
        if (eventData[index].isAttendingEvent == false) {
          eventData[index].isAttendingEvent = true;
          eventData[index].userList!.add(AppConstant.userData!);
        }
        if (eventData[index].isSavedToMyCalender == false) {
          eventData[index].isAttendingEvent = true;
          eventData[index].userList!.add(AppConstant.userData!);
          myEventData.add(eventData[index]);
        }
      } else if (response == 0) {
        if (eventData[index].isAttendingEvent == true) {
          eventData[index].isAttendingEvent = false;
          eventData[index].userList!.removeWhere(
                (element) =>
                    element.id.toString() ==
                    AppConstant.userData!.id.toString(),
              );
        }
        if (eventData[index].isSavedToMyCalender == true) {
          eventData[index].isAttendingEvent = false;
          eventData[index].userList!.removeWhere(
                (element) =>
                    element.id.toString() ==
                    AppConstant.userData!.id.toString(),
              );
          myEventData
              .removeWhere((element) => element.id == eventData[index].id);
        }
      } else if (response == 2) {
        if (eventData[index].isAttendingEvent == false) {
          eventData[index].isAttendingEvent = true;
          eventData[index].userList!.add(AppConstant.userData!);
        }
        if (eventData[index].isSavedToMyCalender == true) {
          eventData[index].isAttendingEvent = false;
          eventData[index].userList!.removeWhere(
                (element) =>
                    element.id.toString() ==
                    AppConstant.userData!.id.toString(),
              );
          myEventData
              .removeWhere((element) => element.id == eventData[index].id);
        }
      } else if (response == 3) {
        if (eventData[index].isAttendingEvent == true) {
          eventData[index].isAttendingEvent = false;
          eventData[index].userList!.removeWhere(
                (element) =>
                    element.id.toString() ==
                    AppConstant.userData!.id.toString(),
              );
        }
        if (eventData[index].isSavedToMyCalender == false) {
          eventData[index].isAttendingEvent = true;
          eventData[index].userList!.add(AppConstant.userData!);
          myEventData.add(eventData[index]);
        }
      }
      setState(() {});
    }
  }
}
