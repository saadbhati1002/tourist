import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';

customAppBarBack({
  BuildContext? context,
  Function? setState,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context!);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 5),
              height: 23,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: ColorConstants.black,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorConstants.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Back',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    ),
  );
}
