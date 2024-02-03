import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/custom_image_view.dart';

class LeaderBoardUser extends StatefulWidget {
  final UserData? userData;
  final bool? isFromChat;
  final VoidCallback? onChatTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFavoriteTap;
  final String? index;
  const LeaderBoardUser(
      {super.key,
      this.userData,
      this.isFromChat,
      this.onChatTap,
      this.onProfileTap,
      this.onFavoriteTap,
      this.index});

  @override
  State<LeaderBoardUser> createState() => _LeaderBoardUserState();
}

class _LeaderBoardUserState extends State<LeaderBoardUser> {
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
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 7),
              child: Text(
                "#${widget.index}",
                style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w800),
              ),
            ),
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
                                gradient: LinearGradient(
                                  stops: [0, 1],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: widget.userData!.userType ==
                                          "Delegate"
                                      ? [
                                          Color(0xFF433C3D),
                                          Color(0xFF1B1819),
                                        ]
                                      : widget.userData!.userType == 'Vendor'
                                          ? [
                                              ColorConstants.bagColor,
                                              ColorConstants.bagColor,
                                            ]
                                          : widget.userData!.userType == 'Media'
                                              ? [
                                                  Color(0xFFF8A57E),
                                                  Color(0xFFBB6358),
                                                ]
                                              : [
                                                  Color(0xFF85153E),
                                                  Color(0xFF30141D),
                                                ],
                                ),
                                color: widget.userData!.userType == "Delegate"
                                    ? ColorConstants.delegateColor
                                    : widget.userData!.userType == 'Vendor'
                                        ? ColorConstants.vendorColor
                                        : widget.userData!.userType == 'Media'
                                            ? ColorConstants.mediaColor
                                            : ColorConstants.mainColor),
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
                                      : ColorConstants.white),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .49,
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
              width: 7,
            ),
            AppConstant.userData!.id == widget.userData!.id
                ? const SizedBox()
                : GestureDetector(
                    onTap: widget.onChatTap,
                    child: Container(
                      height: 37,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0, 2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF433C3D),
                            Color(0xFF1B1819),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 14),
                        child: GradientIcon(
                          icon: Icons.chat,
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFFF0D4B6),
                                Color(0xFF6C4D34),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          size: 20,
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
    String name = widget.userData!.firstName!.replaceAll(" ", "").trim();
    if (widget.userData!.middleName != null &&
        widget.userData!.middleName != "null" &&
        widget.userData!.middleName != "") {
      name = "$name ${widget.userData!.middleName!.replaceAll(" ", "").trim()}";
    }
    if (widget.userData!.lastName != null) {
      name = "$name ${widget.userData!.lastName!.replaceAll(" ", "").trim()}";
    }
    return name;
  }
}
