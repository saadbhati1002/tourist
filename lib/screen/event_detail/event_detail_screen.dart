import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/custom_user_list.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  List userType = [
    'Delegate',
    'Vendor',
    'Speaker',
    'Delegate',
    'Media',
    'Vendor'
  ];
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
                'Meeting/event name with description - Lorem ipsem for the dorem',
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.black,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
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
                height: 20,
              ),
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
                    width: 15,
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'About the event',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Lorem ipsum dolor sit amet consectetur. Aliquet commodo maecenas non vestibulum quis blandit neque quis placerat. Eu sit interdum et nibh et ut interdum. \n\nMattis at nisl eu ipsum facilisi turpis laoreet. Pellentesque vel lorem tortor proin a diam rhoncus cursus tellus. Pellentesque vel lorem tortor proin a diam rhoncus cursus tellus.',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'poppins',
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
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.greyLight),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: userType.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: UserListData(
                      userType: userType[index],
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
