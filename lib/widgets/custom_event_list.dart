import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:avatar_stack/avatar_stack.dart';
import 'package:tourist/utility/images.dart';

Widget eventListing({BuildContext? context}) {
  return Container(
    width: MediaQuery.of(context!).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 1.5, color: ColorConstants.greyLight),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Text(
            'Meeting/event name with description - Lorem ipsem for the dorem',
            style: TextStyle(
                fontSize: 14,
                color: ColorConstants.black,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3:30PM - 5:30PM',
                style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins'),
              ),
              Container(
                height: 25,
                decoration: BoxDecoration(
                  color: ColorConstants.blueColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Event Venue Name',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "poppins",
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
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
                      color: ColorConstants.mainColor,
                      borderRadius: BorderRadius.circular(10),
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
                      color: ColorConstants.mainColor,
                      borderRadius: BorderRadius.circular(10),
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
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AvatarStack(
                height: 40,
                width: MediaQuery.of(context).size.width * .3,
                infoWidgetBuilder: (surplus) {
                  return Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '+ ${surplus - 1}',
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorConstants.black,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                avatars: [
                  for (var n = 0; n < 7; n++) const AssetImage(Images.userMain),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}
