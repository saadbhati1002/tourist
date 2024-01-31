import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/custom_image_view.dart';

class UserListData extends StatefulWidget {
  final UserData? userData;
  final bool? isFromChat;
  final VoidCallback? onChatTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFavoriteTap;
  const UserListData(
      {super.key,
      this.userData,
      this.isFromChat,
      this.onChatTap,
      this.onProfileTap,
      this.onFavoriteTap});

  @override
  State<UserListData> createState() => _UserListDataState();
}

class _UserListDataState extends State<UserListData> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onProfileTap,
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
                  widget.userData!.userType != null
                      ? Align(
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
                                color: widget.userData!.userType == "Delegate"
                                    ? ColorConstants.delegateColor
                                    : widget.userData!.userType == 'Vendor'
                                        ? ColorConstants.vendorColor
                                        : widget.userData!.userType == 'Media'
                                            ? ColorConstants.mediaColor
                                            : ColorConstants.speakerColor),
                            alignment: Alignment.center,
                            child: Text(
                              widget.userData!.userType!,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'inter',
                                  color: widget.userData!.userType ==
                                              "Delegate" ||
                                          widget.userData!.userType == "Media"
                                      ? ColorConstants.white
                                      : ColorConstants.black),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              width: 9,
            ),
            SizedBox(
              width: widget.isFromChat == true
                  ? MediaQuery.of(context).size.width * .47
                  : MediaQuery.of(context).size.width * .6,
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
                    widget.userData!.country != null &&
                            widget.userData!.country != "null" &&
                            widget.userData!.country != ""
                        ? '${widget.userData!.companyName!.trim()}, ${widget.userData!.country ?? ''}'
                        : widget.userData!.companyName!.trim(),
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
              width: 6,
            ),
            AppConstant.userData!.id == widget.userData!.id
                ? const SizedBox()
                : widget.isFromChat == true
                    ? GestureDetector(
                        onDoubleTap: widget.onFavoriteTap,
                        child: Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 1,
                          child: Container(
                            height: 37,
                            decoration: BoxDecoration(
                              color: (widget.userData!.isUserFavorite == true)
                                  ? ColorConstants.mainColor
                                  : ColorConstants.greyLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.star,
                                      size: 20,
                                      color: (widget.userData!.isUserFavorite ==
                                              true)
                                          ? ColorConstants.white
                                          : ColorConstants.black),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Favorite",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            (widget.userData!.isUserFavorite ==
                                                    true)
                                                ? ColorConstants.white
                                                : ColorConstants.black,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: widget.onChatTap,
                        child: Material(
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
                      ),
          ],
        ),
      ),
    );
  }

  getUserName() {
    String name = widget.userData!.firstName!.replaceAll(" ", "");
    if (widget.userData!.middleName != null) {
      name = "$name ${widget.userData!.middleName!.replaceAll(" ", "")}";
    }
    if (widget.userData!.lastName != null) {
      name = "$name ${widget.userData!.lastName!.replaceAll(" ", "")}";
    }
    return name;
  }
}
