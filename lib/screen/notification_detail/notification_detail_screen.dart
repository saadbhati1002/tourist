import 'package:flutter/material.dart';
import 'package:tourist/models/notification/notification_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Data? notificationData;
  const NotificationDetailScreen({super.key, this.notificationData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  notificationData!.title ?? '',
                  style: TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: ColorConstants.black),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '${notificationData!.createdDate} | ${notificationData!.createdTime}',
                  maxLines: 3,
                  style: const TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: ColorConstants.greyLight),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  notificationData!.description ?? '',
                  style: TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorConstants.black),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
