import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/api/repository/message/message.dart';
import 'package:tourist/models/common.dart';
import 'package:tourist/models/favorite/favorite_model.dart';
import 'package:tourist/models/message/message_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:intl/intl.dart';
import 'package:tourist/widgets/gradient_text.dart';

class ChatScreen extends StatefulWidget {
  final UserData? userData;
  const ChatScreen({super.key, this.userData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isApiLoading = false;
  bool isLoading = false;
  List<ChatHistory> chatHistory = [];
  TextEditingController messageText = TextEditingController();
  @override
  void initState() {
    setAnalytics();
    getData();
    super.initState();
  }

  setAnalytics() async {
    await FirebaseAnalytics.instance.logScreenView(screenName: 'Chat Screen');
  }

  getData() async {
    await getChatMessageList();
    await getFavoriteUserList();
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

  getFavoriteUserList() async {
    FavoriteRes response = await AuthRepository().favoriteUsersListApiCall();
    if (response.data != null) {
      var checked = response.data!.where((element) =>
          element.joinedUsers!.id.toString() == widget.userData!.id.toString());
      if (checked.isNotEmpty) {
        setState(() {
          widget.userData!.isUserFavorite = true;
        });
      }
    }
  }

  Future<bool> willPopScope() {
    if (widget.userData!.isUserFavorite == true) {
      Navigator.pop(context, 1);
    } else {
      Navigator.pop(context, 0);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        appBar: customAppBarBack(
          context: context,
          onTap: () {
            if (widget.userData!.isUserFavorite == true) {
              Navigator.pop(context, 1);
            } else {
              Navigator.pop(context, 0);
            }
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: UserListData(
                onProfileTap: () async {
                  var response = await Get.to(
                    () => ProfileScreen(
                      isFromGuest: true,
                      id: widget.userData!.id.toString(),
                    ),
                  );
                  if (response == 1) {
                    widget.userData!.isUserFavorite = true;
                  } else {
                    widget.userData!.isUserFavorite = false;
                  }
                  setState(() {});
                },
                onFavoriteTap: () {
                  if (widget.userData!.isUserFavorite == true) {
                    removeUserFromFavorite();
                  } else {
                    saveToFavorite();
                  }
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
                  : chatHistory.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .74,
                        )
                      : ListView.builder(
                          itemCount: chatHistory.length,
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 10),
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
                gradient: LinearGradient(
                  stops: [0, 2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF433C3D),
                    Color(0xFF1B1819),
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
                          color: ColorConstants.bagColor,
                          fontWeight: FontWeight.w700),
                    ),
                    GradientText(
                      chatHistory[index].timestamp ?? "",
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w600),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFF0D4B6),
                            Color(0xFF6C4D34),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
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

  saveToFavorite() async {
    try {
      setState(() {
        isApiLoading = true;
      });
      Common response = await AuthRepository()
          .addFavoriteUsersApiCall(favoriteUserID: widget.userData!.id);
      if (response.message == 'User saved to favorite successfully') {
        setState(() {
          widget.userData!.isUserFavorite = true;
        });
        toastShow(message: "User saved to favorite successfully");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }

  removeUserFromFavorite() async {
    try {
      setState(() {
        isApiLoading = true;
      });
      Common response = await AuthRepository()
          .removeFavoriteUsersApiCall(favoriteUserID: widget.userData!.id);
      if (response.message == 'User saved to favorite successfully') {
        setState(() {
          widget.userData!.isUserFavorite = false;
        });
        toastShow(message: "User removed from favorite list");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }
}
