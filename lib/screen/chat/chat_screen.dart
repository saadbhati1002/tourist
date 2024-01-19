import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/message/message.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/message/message_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final UserData? userData;
  const ChatScreen({super.key, this.userData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;
  List<ChatHistory> chatHistory = [];
  TextEditingController messageText = TextEditingController();
  @override
  void initState() {
    getChatMessageList();
    super.initState();
  }

  getChatMessageList() async {
    try {
      setState(() {
        isLoading = true;
      });
      MessageRes response = await MessageRepository().getMessageApiCall();
      if (response.chatUsers != null) {
        for (int i = 0; i < response.chatUsers!.length; i++) {
          if (widget.userData!.id == response.chatUsers![i].id) {
            chatHistory = response.chatUsers![i].chatHistory!;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: UserListData(
              onProfileTap: () {
                Get.to(
                  () => ProfileScreen(
                    isFromGuest: true,
                    id: widget.userData!.id.toString(),
                  ),
                );
              },
              onChatTap: () async {
                await Get.to(
                  () => ChatScreen(
                    userData: widget.userData!,
                  ),
                );
              },
              userData: widget.userData,
              isFromChat: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: isLoading
                ? ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return chatSkeleton();
                    })
                : ListView.builder(
                    itemCount: chatHistory.length,
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index) {
                      int itemCount = chatHistory.length;
                      int reversedIndex = itemCount - 1 - index;
                      return chatBoxWidget(reversedIndex);
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
                      controller: messageText,
                      hintText: "Start writing something ....",
                      context: context,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (messageText.text.isEmpty) {
                        toastShow(message: "Please enter message");
                        return;
                      }
                      sendMessage();
                    },
                    child: const Icon(
                      Icons.send,
                      color: ColorConstants.mainColor,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chatSkeleton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * .35,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          alignment: Alignment.topRight,
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstants.greySimple),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      height: 12,
                      randomLength: true,
                      // height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 12,
                      // height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
            )
          ]),
        )
      ]),
    );
  }

  Widget chatBoxWidget(index) {
    return Row(
      mainAxisAlignment:
          (chatHistory[index].senderId == AppConstant.userData!.id)
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
                    Text(
                      chatHistory[index].message ?? '',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      chatHistory[index].timestamp ?? "",
                      maxLines: 3,
                      style: TextStyle(
                          fontFamily: "inter",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: ColorConstants.black),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  sendMessage() async {
    try {
      Common response = await MessageRepository().sendMessageMessageApiCall(
          message: messageText.text.toString(),
          receiverID: widget.userData!.id.toString());
      if (response.message == "Message send successfully") {
        chatHistory.insert(
          chatHistory.length,
          ChatHistory(
            id: '0',
            message: messageText.text.trim(),
            senderId: AppConstant.userData!.id,
            receiverId: widget.userData!.id,
            timestamp:
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          ),
        );

        messageText.clear();
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
