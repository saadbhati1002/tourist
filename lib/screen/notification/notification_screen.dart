import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  setStateNow() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      key: _key,
      appBar: customAppBar(_key, context: context, setState: setStateNow),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return notificationWidget();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Meeting/event name with description - Lorem ipsem for the dorem',
              style: TextStyle(
                  fontFamily: "inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: ColorConstants.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Lorem ipsum dolor sit amet consectetur. Aliquet commodo maecenas non vestibulum quis blandit neque quis placerat. Eu sit interdum et nibh et ut interdum. Mattis at nisl eu ipsum facilisi turpis laoreet. Pellentesque vel lorem tortor proin a diam rhoncus cursus tellus. Pellentesque vel lorem tortor proin a diam rhoncus cursus tellus.',
              maxLines: 3,
              style: TextStyle(
                  fontFamily: "inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: ColorConstants.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '24.05.2024 | 12:25PM',
              maxLines: 3,
              style: TextStyle(
                  fontFamily: "inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: ColorConstants.greyLight),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: ColorConstants.black,
          )
        ],
      ),
    );
  }
}
