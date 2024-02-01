import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/models/updateProfile/update_profile_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class QuickScreen extends StatefulWidget {
  const QuickScreen({super.key});

  @override
  State<QuickScreen> createState() => _QuickScreenState();
}

class _QuickScreenState extends State<QuickScreen> {
  bool isLoading = false;
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            saveNote();
            var txt = await controller.getText();

            AppConstant.userData!.userNote = txt;
            AppConstant.userDetailSaved(
              jsonEncode(AppConstant.userData),
            );
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
        body: Stack(
          children: [
            HtmlEditor(
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
            isLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  saveNote() async {
    try {
      setState(() {
        isLoading = true;
      });
      var txt = await controller.getText();

      UpdateProfile response =
          await AuthRepository().updateUserNotesApiCall(notes: txt.toString());
      if (response.message == 'Profile updated successfully') {
        AppConstant.userData = response.data;
        toastShow(message: "Note saved");
        AppConstant.userDetailSaved(
          jsonEncode(AppConstant.userData),
        );
        AppConstant.userData!.userNote = txt;
        AppConstant.userDetailSaved(
          jsonEncode(AppConstant.userData),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    toastShow(message: "Note saved successfully to device");
  }
}
