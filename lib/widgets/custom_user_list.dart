import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';

class UserListData extends StatefulWidget {
  final String? userType;
  const UserListData({super.key, this.userType});

  @override
  State<UserListData> createState() => _UserListDataState();
}

class _UserListDataState extends State<UserListData> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: Stack(
              children: [
                SizedBox(
                  height: 90,
                  width: 90,
                  child: Image.asset(
                    Images.userMain,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 15,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(
                            10,
                          ),
                          bottomRight: Radius.circular(10),
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
                          fontFamily: 'poppins',
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
            width: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .43,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hugo Fabrazi',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.black,
                      fontFamily: "poppins"),
                ),
                Text(
                  'Founder & CEO',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.black,
                      fontFamily: "poppins"),
                ),
                Text(
                  'Company name, Country',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.black,
                      fontFamily: "poppins"),
                ),
              ],
            ),
          ),
          Container(
            height: 37,
            decoration: BoxDecoration(
              color: ColorConstants.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_outlined,
                    color: ColorConstants.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "poppins"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
