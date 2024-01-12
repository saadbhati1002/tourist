import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';

customAppBar(
  key, {
  BuildContext? context,
  Function? setState,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: Container(
      margin: const EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context!).size.width * .6,
      decoration: BoxDecoration(
        color: ColorConstants.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(Images.user),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .43,
              child: Text(
                'Thomas Brian Samuels',
                maxLines: 1,
                style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 14,
                    color: ColorConstants.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            key.currentState!.openEndDrawer();
          },
          child: Image.asset(Images.menu),
        ),
      )
    ],
  );
}
