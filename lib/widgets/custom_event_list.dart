import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/utility/color.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:tourist/utility/constant.dart';
import 'package:url_launcher/url_launcher.dart';

Widget eventListing({
  String? title,
  BuildContext? context,
  EventData? eventData,
  VoidCallback? attendEvent,
  VoidCallback? onTapReview,
  VoidCallback? addToMyCalender,
  bool? isEventJoin,
  bool? isMyEvent,
  bool? isEventEnded,
  bool? isReviewSubmitted,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      shadowColor: ColorConstants.mainColor,
      child: Container(
        width: MediaQuery.of(context!).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0, 2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isEventEnded == true
                ? [
                    ColorConstants.greyLight.withOpacity(0.6),
                    ColorConstants.greyLight.withOpacity(0.6)
                  ]
                : [
                    Color(0xFFF8A57E),
                    Color(0xFFBB6358),
                  ],
          ),
          borderRadius: BorderRadius.circular(10),
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
                        gradient: LinearGradient(
                          stops: [0, 2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isEventEnded == true
                              ? [
                                  ColorConstants.white.withOpacity(0.6),
                                  ColorConstants.white.withOpacity(0.6)
                                ]
                              : [
                                  Color(0xFF433C3D),
                                  Color(0xFF1B1819),
                                ],
                        ),
                        color: isEventEnded == true
                            ? ColorConstants.white.withOpacity(0.6)
                            : ColorConstants.greySimple),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Text(
                        eventData!.eventTime ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            color: isEventEnded == true
                                ? ColorConstants.greyLight
                                : ColorConstants.bagColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter'),
                      ),
                    ),
                  ),
                  eventData.eventType != null
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0, 1],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: eventData.eventType == "Event"
                                  ? [
                                      Color(0xFF85153E),
                                      Color(0xFF30141D),
                                    ]
                                  : [
                                      ColorConstants.eventBoxColor,
                                      ColorConstants.eventBoxColor,
                                    ],
                            ),
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
              title != null
                  ? Text(
                      title == "Pickup From"
                          ? "$title ${AppConstant.userData!.userHotel}"
                          : title == "Departure to"
                              ? "$title ${AppConstant.userData!.userHotel}"
                              : title,
                      style: TextStyle(
                          fontSize: 14,
                          color: isEventEnded == true
                              ? ColorConstants.black.withOpacity(0.5)
                              : ColorConstants.black,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      eventData.title ?? '',
                      style: TextStyle(
                          fontSize: 14,
                          color: isEventEnded == true
                              ? ColorConstants.black.withOpacity(0.5)
                              : ColorConstants.black,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w700),
                    ),
              SizedBox(
                height: eventData.eventType != null ? 15 : 0,
              ),
              eventData.eventStatus == "In Progress"
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .66,
                            child: eventData.place != null
                                ? Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.locationDot,
                                        color: isEventEnded == true
                                            ? ColorConstants.black
                                                .withOpacity(0.5)
                                            : ColorConstants.black,
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
                                              launchUrl(Uri.parse(
                                                  eventData.mapLink!));
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
                                                color: isEventEnded == true
                                                    ? ColorConstants.black
                                                        .withOpacity(0.5)
                                                    : ColorConstants.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                eventData.eventStatus ?? '',
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : eventData.place != null
                      ? Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.locationDot,
                              color: isEventEnded == true
                                  ? ColorConstants.black.withOpacity(0.5)
                                  : ColorConstants.black,
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
                                      color: isEventEnded == true
                                          ? ColorConstants.black
                                              .withOpacity(0.5)
                                          : ColorConstants.black,
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
                        eventData.userList!.isEmpty
                            ? Text(
                                ' ${eventData.userList!.length} participants',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorConstants.black,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              )
                            : AvatarStack(
                                height: 40,
                                width: MediaQuery.of(context).size.width * .25,
                                infoWidgetBuilder: (surplus) {
                                  return Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      ' ${eventData.userList!.length} participants',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstants.black,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                                avatars: [
                                  for (var n = 0;
                                      n < eventData.userList!.length;
                                      n++)
                                    NetworkImage((eventData
                                                    .userList![n].logo3 !=
                                                null &&
                                            eventData.userList![n].logo3 != "")
                                        ? eventData.userList![n].logo3!
                                        : 'https://dubaiweddingsymposium.com/images/DWS.png')
                                ],
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isEventEnded == true
                                ? eventData.isReviewSubmitted == true
                                    ? Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: ColorConstants.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            'Completed',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'inter',
                                                fontWeight: FontWeight.w500,
                                                color: ColorConstants.white),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: onTapReview,
                                        child: Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              stops: [0, 2],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFF433C3D),
                                                Color(0xFF1B1819),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                  'Give Feedback',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'inter',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorConstants.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                : GestureDetector(
                                    onTap: attendEvent,
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          stops: [0, 1],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors:
                                              eventData.isAttendingEvent == true
                                                  ? [
                                                      Color(0xFF85153E),
                                                      Color(0xFF30141D),
                                                    ]
                                                  : [
                                                      ColorConstants.white,
                                                      ColorConstants.white,
                                                    ],
                                        ),
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
                                              color:
                                                  eventData.isAttendingEvent ==
                                                          true
                                                      ? ColorConstants.white
                                                      : ColorConstants.greyDark,
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
                                                color: eventData
                                                            .isAttendingEvent ==
                                                        true
                                                    ? ColorConstants.white
                                                    : ColorConstants.greyDark,
                                              ),
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
                                  gradient: LinearGradient(
                                    stops: [0, 1],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors:
                                        eventData.isSavedToMyCalender == true
                                            ? [
                                                Color(0xFF85153E),
                                                Color(0xFF30141D),
                                              ]
                                            : [
                                                ColorConstants.white,
                                                ColorConstants.white,
                                              ],
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.calendar_month,
                                  color: eventData.isSavedToMyCalender == true
                                      ? ColorConstants.white
                                      : ColorConstants.greyDark,
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
