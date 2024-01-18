import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/notification/notification.dart';
import 'package:tourist/models/notification/notification_model.dart';
import 'package:tourist/screen/notification_detail/notification_detail_screen.dart';
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
  bool isLoading = false;
  List<Data> notificationList = [];
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      NotificationRes response =
          await NotificationRepository().getNotificationApiCall();
      if (response.data != null) {
        notificationList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        endDrawer: const CustomDrawer(),
        key: _key,
        appBar: customAppBar(_key, context: context, setState: setStateNow),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return notificationSkeleton();
                      },
                    )
                  : ListView.builder(
                      itemCount: notificationList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return notificationWidget(index);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notificationWidget(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Get.to(NotificationDetailScreen(
              notificationData: notificationList[index]));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                notificationList[index].title ?? '',
                maxLines: 2,
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
                notificationList[index].description ?? '',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${notificationList[index].createdDate} | ${notificationList[index].createdTime}',
                maxLines: 3,
                style: const TextStyle(
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
      ),
    );
  }

  Widget notificationSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstants.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstants.mainColor),
          ),
          padding:
              const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonItem(
                child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 6,
                          spacing: 10,
                          lineStyle: SkeletonLineStyle(
                            randomLength: false,
                            // height: 10,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
