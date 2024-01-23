import 'package:flutter/material.dart';
import 'package:tourist/api/repository/event/event.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_button.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/show_progress_bar.dart';

class EventReviewScreen extends StatefulWidget {
  final String? eventID;
  const EventReviewScreen({super.key, this.eventID});

  @override
  State<EventReviewScreen> createState() => _EventReviewScreenState();
}

class _EventReviewScreenState extends State<EventReviewScreen> {
  TextEditingController review = TextEditingController();
  bool isLoading = false;
  bool isReviewSubmitted = false;
  Future<bool> willPopScope() {
    if (isReviewSubmitted == true) {
      Navigator.pop(context, review.text.trim);
    } else {
      Navigator.pop(context);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            if (isReviewSubmitted == true) {
              Navigator.pop(context, review.text.trim);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .07,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Add event Review",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomTextFormField(
                      isMaxLine: true,
                      controller: review,
                      hintText: "Enter review",
                      context: context,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: CommonButton(
                      width: MediaQuery.of(context).size.width,
                      onTap: () {
                        submitReview();
                      },
                      title: "Submit",
                    ),
                  )
                ],
              ),
            ),
            isLoading ? const ShowProgressBar() : const SizedBox()
          ],
        ),
      ),
    );
  }

  submitReview() async {
    if (review.text.isEmpty) {
      toastShow(message: "Please enter review to submit");
      return;
    }
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {
        isLoading = true;
      });
      Common response = await EventRepository().addEventReviewApiCall(
          eventID: widget.eventID, review: review.text.toString());
      if (response.message == 'Review saved successfully') {
        isReviewSubmitted = true;
        toastShow(message: response.message);
      } else {
        toastShow(message: "Getting some error");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
