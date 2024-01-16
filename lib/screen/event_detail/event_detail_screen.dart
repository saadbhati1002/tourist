import 'package:flutter/material.dart';
import 'package:tourist/models/event/event_list.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/custom_user_list.dart';

class EventDetailScreen extends StatefulWidget {
  final EventData? eventData;
  const EventDetailScreen({super.key, this.eventData});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                widget.eventData!.title ?? '',
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.black,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.eventData!.eventTime ?? '',
                style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter'),
              ),
              SizedBox(
                height: widget.eventData!.eventType != null ? 15 : 0,
              ),
              widget.eventData!.eventType != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: widget.eventData!.eventType == "Event"
                            ? ColorConstants.blueColor
                            : ColorConstants.eventBoxColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Text(
                          widget.eventData!.eventType ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "inter",
                              color: widget.eventData!.eventType == "Event"
                                  ? ColorConstants.white
                                  : ColorConstants.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: widget.eventData!.place != null ? 15 : 0,
              ),
              widget.eventData!.place != null
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
                          widget.eventData!.place ?? '',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 32,
                    width: 40,
                    decoration: BoxDecoration(
                      color: widget.eventData!.isAttendingEvent == true
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
                      color: widget.eventData!.isAttendingEvent == true
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'About the event',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.eventData!.description ?? '',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.black),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Participants',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.greyLight),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 0,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: UserListData(
                      userType: 'D',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
