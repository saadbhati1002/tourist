import 'package:flutter/material.dart';
import 'package:tourist/api/repository/staff/staff.dart';
import 'package:tourist/models/staff/staff_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/custom_image_view.dart';
import 'package:tourist/widgets/gradient_text.dart';
import 'package:tourist/widgets/user_skeleton.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  bool isLoading = false;
  List<StaffData> staffList = [];
  @override
  void initState() {
    getStaff();
    super.initState();
  }

  getStaff() async {
    try {
      setState(() {
        isLoading = true;
      });
      StaffRes response = await StaffRepository().getStaffApiCall();
      if (response.data!.isNotEmpty) {
        staffList = response.data!;
      }
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: GradientText(
                'Staff',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                gradient: LinearGradient(colors: [
                  Color(0xFFF0D4B6),
                  Color(0xFF6C4D34),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Project Team",
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return const UserSkeleton();
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 0, left: 25, right: 25),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: staffList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return staffWidget(index);
                    },
                  ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget staffWidget(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          CustomImage(
            height: 100,
            width: 100,
            imagePath: staffList[index].staffImage,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * .59,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  staffList[index].staffName ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                  gradient: LinearGradient(colors: [
                    Color(0xFFF0D4B6),
                    Color(0xFF6C4D34),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                Text(
                  staffList[index].staffDesignation ?? '',
                  style: TextStyle(
                      fontSize: 15,
                      color: ColorConstants.black,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
