import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/custom_image_view.dart';

class UserListData extends StatefulWidget {
  final String? userType;
  final UserData? userData;
  const UserListData({super.key, this.userType, this.userData});

  @override
  State<UserListData> createState() => _UserListDataState();
}

class _UserListDataState extends State<UserListData> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileScreen(
              isFromGuest: true,
              id: widget.userData!.id.toString(),
            ));
      },
      child: SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Stack(
                children: [
                  CustomImage(
                    height: 70,
                    width: 70,
                    imagePath: widget.userData!.logo3!,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 15,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(
                              5,
                            ),
                            bottomRight: Radius.circular(5),
                          ),
                          color: widget.userType == "Delegate"
                              ? ColorConstants.delegateColor
                              : widget.userType == 'Vendor'
                                  ? ColorConstants.vendorColor
                                  : widget.userType == 'Media'
                                      ? ColorConstants.mediaColor
                                      : ColorConstants.speakerColor),
                      alignment: Alignment.center,
                      child: Text(
                        widget.userType!,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'inter',
                            color: widget.userType == "Delegate" ||
                                    widget.userType == "Media"
                                ? ColorConstants.white
                                : ColorConstants.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      getUserName(),
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.black,
                          fontFamily: "inter"),
                    ),
                  ),
                  Text(
                    widget.userData!.jobTitle ?? '',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                        fontFamily: "inter"),
                  ),
                  Text(
                    widget.userData!.country != null
                        ? '${widget.userData!.companyName ?? ''}, ${widget.userData!.country ?? ''}'
                        : widget.userData!.companyName ?? '',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.black,
                        fontFamily: "inter"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 1,
              child: Container(
                height: 37,
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: FaIcon(
                    FontAwesomeIcons.solidCommentDots,
                    size: 25,
                    color: ColorConstants.mainColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserName() {
    String name = widget.userData!.firstName!;
    if (widget.userData!.middleName != null) {
      name = "$name ${widget.userData!.middleName}";
    }
    if (widget.userData!.lastName != null) {
      name = "$name ${widget.userData!.lastName}";
    }
    return name;
  }
}
