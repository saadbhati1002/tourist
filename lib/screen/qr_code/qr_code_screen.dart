import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:tourist/widgets/custom_app_bar.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? imageInMemory;
  String? imagePath;
  File? capturedFile;
  @override
  void initState() {
    setAnalytics();
    super.initState();
  }

  setAnalytics() async {
    await FirebaseAnalytics.instance
        .logScreenView(screenName: 'QR Code Screen');
  }

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
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Stack(
          children: [
            qrImage(),
            Container(
              color: ColorConstants.white,
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImageView(
                            constrainErrorBounds: true,
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
                        getUserName(),
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.black,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        AppConstant.userData!.jobTitle!,
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.black,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        AppConstant.userData!.companyName!,
                        style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.black,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _saveLocalImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .65,
                      height: 35,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            stops: [0, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF85153E),
                              Color(0xFF30141D),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(7)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.download,
                            color: ColorConstants.bagColor,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Download As Image',
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorConstants.bagColor,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget qrImage() {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImageView(
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
              height: 20,
            ),
            Text(
              getUserName(),
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              AppConstant.userData!.jobTitle!,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              AppConstant.userData!.companyName!,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.black,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * .8,
              child: Image.asset(Images.logoName),
            ),
          ],
        ),
      ),
    );
  }

  _saveLocalImage() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      if (result["isSuccess"] == true) {
        toastShow(message: "Image saved to gallery");
      }
    }
  }
}
