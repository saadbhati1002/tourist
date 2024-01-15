import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final vcardData = 'BEGIN:VCARD\n'
      'VERSION:3.0\n'
      'N:${AppConstant.userData!.firstName};${AppConstant.userData!.lastName};\n'
      'TEL;TYPE=CELL:${AppConstant.userData!.mobile}\n'
      'EMAIL:${AppConstant.userData!.email}\n'
      'ORG:${AppConstant.userData!.companyName}\n'
      'TITLE:${AppConstant.userData!.jobTitle}\n'
      'END:VCARD';
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
              QrImage(
                data: vcardData,
                version: QrVersions.auto,
                size: 300.0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(25.0),
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
