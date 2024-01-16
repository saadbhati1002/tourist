import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';

class QuickScreen extends StatefulWidget {
  const QuickScreen({super.key});

  @override
  State<QuickScreen> createState() => _QuickScreenState();
}

class _QuickScreenState extends State<QuickScreen> {
  HtmlEditorController controller = HtmlEditorController();
  @override
  void initState() {
    checkForData();
    super.initState();
  }

  checkForData() {
    if (AppConstant.userData!.userNote != null) {
      Future.delayed(const Duration(seconds: 1), () {
        controller.insertHtml(AppConstant.userData!.userNote!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var txt = await controller.getText();

          AppConstant.userData!.userNote = txt;
          AppConstant.userDetailSaved(
            jsonEncode(AppConstant.userData),
          );
          toastShow(message: "Note saved successfully to device");
        },
        isExtended: true,
        backgroundColor: ColorConstants.mainColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: Text(
          'Save',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorConstants.white,
              fontFamily: "inter"),
        ),
      ),
      body: HtmlEditor(
        controller: controller, //required

        htmlEditorOptions: const HtmlEditorOptions(
          hint: "Your text here...",
          spellCheck: true,

          //initalText: "text content initial, if any",
        ),

        otherOptions: const OtherOptions(
          height: 600,
        ),
      ),
    );
  }
}
