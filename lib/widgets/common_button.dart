import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({Key? key, this.width, this.onTap, this.title})
      : super(key: key);
  final double? width;
  final Function()? onTap;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF85153E),
                Color(0xFF30141D),
              ],
            ),
            color: ColorConstants.black),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: TextStyle(
              fontSize: 16,
              color: ColorConstants.bagColor,
              fontFamily: "inter",
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
