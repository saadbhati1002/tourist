import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/utility/color.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:url_launcher/url_launcher.dart';

Widget eventListing(
    {BuildContext? context,
    EventData? eventData,
    VoidCallback? attendEvent,
    VoidCallback? addToMyCalender,
    bool? isEventJoin,
    bool? isMyEvent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      shadowColor: ColorConstants.mainColor,
      child: Container(
        width: MediaQuery.of(context!).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.9, color: ColorConstants.mainColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorConstants.greySimple),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text(
                        eventData!.eventTime ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter'),
                      ),
                    ),
                  ),
                  eventData.eventType != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: eventData.eventType == "Event"
                                ? ColorConstants.teal
                                : ColorConstants.eventBoxColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            child: Text(
                              eventData.eventType ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "inter",
                                  color: eventData.eventType == "Event"
                                      ? ColorConstants.white
                                      : ColorConstants.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                eventData.title ?? '',
                style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.black,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: eventData.eventType != null ? 15 : 0,
              ),
              eventData.place != null
                  ? Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              if (eventData.mapLink != null) {
                                launchUrl(Uri.parse(eventData.mapLink!));
                              }
                            },
                            child: Text(
                              eventData.place ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "inter",
                                  color: ColorConstants.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: isMyEvent == true ? 0 : 15,
              ),
              isMyEvent == true
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AvatarStack(
                          
                          height: 40,
                          width: MediaQuery.of(context).size.width * .22,
                          infoWidgetBuilder: (surplus) {
                            return Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                ' ${eventData.userList!.length}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorConstants.black,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                          avatars: [
                            for (var n = 0; n < eventData.userList!.length; n++)
                              NetworkImage((eventData.userList![n].logo3 !=
                                          null &&
                                      eventData.userList![n].logo3 != "")
                                  ? eventData.userList![n].logo3!
                                  : 'https://dubaiweddingsymposium.com/images/DWS.png')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: attendEvent,
                              child: Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  color: eventData.isAttendingEvent == true
                                      ? ColorConstants.mainColor
                                      : ColorConstants.greyLight,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: ColorConstants.white,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        'Attending',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'inter',
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: addToMyCalender,
                              child: Container(
                                height: 32,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: eventData.isSavedToMyCalender == true
                                      ? ColorConstants.mainColor
                                      : ColorConstants.greyLight,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.calendar_month,
                                  color: ColorConstants.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    ),
  );
}
