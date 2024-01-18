import 'package:flutter/material.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_user_list.dart';

class ChatScreen extends StatefulWidget {
  final UserData? userData;
  const ChatScreen({super.key, this.userData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: customAppBarBack(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: UserListData(
              userData: widget.userData,
              isFromChat: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              physics: const BouncingScrollPhysics(),
              reverse: true,
              itemBuilder: (context, index) {
                return chatBoxWidget(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .805,
                    height: 40,
                    child: CustomTextFormField(
                      hintText: "Start writing something ....",
                      context: context,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.send,
                    color: ColorConstants.mainColor,
                    size: 35,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chatBoxWidget(index) {
    return Row(
      mainAxisAlignment: (index == 0 || index == 3)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.7],
                  colors: [
                    ColorConstants.gradientColor,
                    ColorConstants.mainColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(maxWidth: 300),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lorem ipsum dolor sit amet consectetur. Augue pretium mus feugiat commodo posuere nunc risus elit ipsum. Suspendisse ultrices sed magna lacinia tincidunt quis. Enim congue eu condimentum in in consequat rutrum ullamcorper aliquet. Blandit cras rutrum malesuada enim adipiscing dignissim fames interdum.",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${2024 - 01 - 18} | 03:25 PM',
                        maxLines: 3,
                        style: TextStyle(
                            fontFamily: "inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: ColorConstants.white),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
