import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_user_list.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  setStateNow() {
    setState(() {});
  }

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
      key: _key,
      appBar: customAppBar(_key, context: context, setState: setStateNow),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
                // controller: email,
                hintText: "Search For Participants",
                suffix: Icon(
                  Icons.search,
                  size: 30,
                  color: ColorConstants.black,
                ),
                context: context,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            customHeadingText(title: 'Recommended Participants'),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return UserListData(
                  userType: userType[index],
                );
              },
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget customHeadingText({String? title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        title!,
        style: const TextStyle(
            color: ColorConstants.greyLight,
            fontSize: 12,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w900),
      ),
    );
  }
}
