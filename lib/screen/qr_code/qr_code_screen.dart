import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(
        context: context,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_2,
                size: 180,
                color: ColorConstants.black,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Thomas Brian Samuel',
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.black,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500),
          ),
          Text(
            'FOUNDER & CEO',
            style: TextStyle(
                fontSize: 14,
                color: ColorConstants.black,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500),
          ),
          Text(
            'Company Name',
            style: TextStyle(
                fontSize: 14,
                color: ColorConstants.black,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .65,
            height: 35,
            decoration: BoxDecoration(
                color: ColorConstants.black,
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Images.download,
                  color: ColorConstants.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Download As Image',
                  style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.white,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
