import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tourist/widgets/app_bar_back.dart';

class QuickScreen extends StatefulWidget {
  const QuickScreen({super.key});

  @override
  State<QuickScreen> createState() => _QuickScreenState();
}

class _QuickScreenState extends State<QuickScreen> {
  HtmlEditorController controller = HtmlEditorController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBack(
        context: context,
      ),
      body: HtmlEditor(
        controller: controller, //required

        htmlEditorOptions: const HtmlEditorOptions(
          hint: "Your text here...",
          spellCheck: true,

          //initalText: "text content initial, if any",
        ),

        otherOptions: const OtherOptions(
          height: 400,
        ),
      ),
    );
    ;
  }
}
