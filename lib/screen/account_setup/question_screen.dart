import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/common_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.loose,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .12,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(Images.dubai),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .045,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "DUBAI WEDDING SYMPOSIUM DUBAI 2024",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    pageIndex == 1
                        ? "Whats your role?"
                        : "Question if ${AppConstant.selectedRole}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: ListView.builder(
                    itemCount: pageIndex == 1
                        ? AppConstant.roleType.length
                        : AppConstant.rolesSubRole.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return optionBox(
                          index: index,
                          title: pageIndex == 1
                              ? AppConstant.roleType[index]
                              : AppConstant.rolesSubRole[index]);
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .07,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CommonButton(
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      checkNavigation();
                    },
                    title: "Proceed",
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 65,
                width: 65,
                child: Image.asset(Images.vivah),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget optionBox({String? title, int? index}) {
    return GestureDetector(
      onTap: () {
        if (pageIndex == 1) {
          setState(() {
            AppConstant.selectedRole = title;
          });
        } else if (pageIndex == 2) {
          setState(() {
            AppConstant.selectedSubRole = title;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 34,
        width: MediaQuery.of(context).size.width * .1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: getColorBoxCOlor(title: title)),
        alignment: Alignment.center,
        child: Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              color: getTextColor(title: title),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  getColorBoxCOlor({String? title}) {
    Color color = ColorConstants.greyLight;
    if (pageIndex == 1) {
      if (AppConstant.selectedRole == title!) {
        color = ColorConstants.mainColor;
      }
    }
    if (pageIndex == 2) {
      if (AppConstant.selectedSubRole == title!) {
        color = ColorConstants.mainColor;
      }
    }
    return color;
  }

  getTextColor({String? title}) {
    Color color = ColorConstants.black;
    if (pageIndex == 1) {
      if (AppConstant.selectedRole == title!) {
        color = ColorConstants.white;
      }
    }
    if (pageIndex == 2) {
      if (AppConstant.selectedSubRole == title!) {
        color = ColorConstants.white;
      }
    }
    return color;
  }

  checkNavigation() {
    if (pageIndex == 1) {
      if (AppConstant.selectedRole == null) {
        toastShow(message: "Please select your role.");
        return;
      } else if (AppConstant.selectedRole != null) {
        setState(() {
          pageIndex = 2;
        });
      }
    } else if (pageIndex == 2) {
      if (AppConstant.selectedSubRole == null) {
        toastShow(message: "Please select your sub role.");
        return;
      } else {}
    }
  }
}
