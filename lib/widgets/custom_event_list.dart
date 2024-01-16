import 'package:flutter/material.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/utility/color.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:tourist/utility/images.dart';

Widget eventListing({BuildContext? context, EventData? eventData}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
              Container(
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.boxColorTime),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    eventData!.eventTime ?? '',
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorConstants.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'inter'),
                  ),
                ),
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
              eventData.eventType != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: eventData.eventType == "Event"
                            ? ColorConstants.blueColor
                            : ColorConstants.eventBoxColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Text(
                          eventData.eventType ?? '',
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
              SizedBox(
                height: eventData.place != null ? 15 : 0,
              ),
              eventData.place != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(
                          eventData.place ?? '',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "inter",
                              color: ColorConstants.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 32,
                        width: 40,
                        decoration: BoxDecoration(
                          color: eventData.isAttendingEvent == true
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
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: eventData.isAttendingEvent == true
                              ? ColorConstants.mainColor
                              : ColorConstants.greyLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    ],
                  ),
                  // AvatarStack(
                  //   height: 40,
                  //   width: MediaQuery.of(context).size.width * .3,
                  //   infoWidgetBuilder: (surplus) {
                  //     return Container(
                  //       height: 40,
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         '+ ${surplus - 1}',
                  //         style: TextStyle(
                  //             fontSize: 12,
                  //             color: ColorConstants.black,
                  //             fontWeight: FontWeight.w700),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     );
                  //   },
                  //   avatars: [
                  //     for (var n = 0; n < 7; n++)
                  //       const AssetImage(Images.userMain),
                  //   ],
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
