import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourist/api/repository/message/message.dart';
import 'package:tourist/api/repository/user/user.dart';
import 'package:tourist/models/all_user/all_user_model.dart';
import 'package:tourist/models/message/message_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/chat/chat_screen.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_app_bar.dart';
import 'package:tourist/widgets/custom_drawer.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:tourist/widgets/user_skeleton.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<UserData> chatUsers = [];
  bool isLoading = false;
  bool isLoadingMessage = false;
  List<UserData> userList = [];
  Timer? _debounce;
  String? searchedName;
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await getUserData();
    await getChatUserList();
  }

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        searchedName = query;
      });
    });
  }

  getUserData() async {
    try {
      setState(() {
        isLoading = true;
      });
      AllUserRes response = await UserRepository().allUsersApiCall();
      if (response.data != null) {
        userList = response.data!;
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
    return userList;
  }

  getChatUserList() async {
    try {
      setState(() {
        isLoadingMessage = true;
      });
      MessageRes response = await MessageRepository().getMessageApiCall();
      if (response.chatUsers != null) {
        chatUsers = response.chatUsers!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoadingMessage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        endDrawer: const CustomDrawer(),
        key: _key,
        appBar: customAppBar(_key, context: context, setState: setStateNow),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomTextFormField(
                  // controller: email,
                  hintText: "Search For Participants",
                  suffix: Icon(
                    Icons.search,
                    size: 30,
                    color: ColorConstants.black,
                  ),
                  onChanged: _onSearchChanged,
                  context: context,
                ),
              ),
              SizedBox(
                height: chatUsers.isEmpty ? 0 : 20,
              ),
              chatUsers.isEmpty
                  ? const SizedBox()
                  : customHeadingText(title: 'Recent Chat'),
              SizedBox(
                height: chatUsers.isEmpty ? 0 : 10,
              ),
              chatUsers.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 97,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: chatUsers.length,
                        itemBuilder: (context, index) {
                          return recentChatUser(index);
                        },
                      ),
                    ),
              // customHeadingText(title: 'Recommended Participants'),
              // const SizedBox(
              //   height: 10,
              // ),
              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: 3,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding:
              //           const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //       child: UserListData(
              //         userType: userType[index],
              //       ),
              //     );
              //   },
              // ),
              const SizedBox(
                height: 20,
              ),
              customHeadingText(title: 'All Participants'),
              const SizedBox(
                height: 10,
              ),
              !isLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return AppConstant.userData!.id == userList[index].id
                            ? const SizedBox()
                            : searchedName == null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: UserListData(
                                      onProfileTap: () async {
                                        await Get.to(
                                          () => ProfileScreen(
                                            isFromGuest: true,
                                            id: userList[index].id.toString(),
                                          ),
                                        );
                                        await getChatUserList();
                                      },
                                      userData: userList[index],
                                      onChatTap: () async {
                                        await Get.to(
                                          () => ChatScreen(
                                            userData: userList[index],
                                          ),
                                        );
                                        await getChatUserList();
                                      },
                                    ),
                                  )
                                : getUserName(userList[index])
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchedName!.toLowerCase())
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: UserListData(
                                          userData: userList[index],
                                          onProfileTap: () async {
                                            await Get.to(
                                              () => ProfileScreen(
                                                isFromGuest: true,
                                                id: userList[index]
                                                    .id
                                                    .toString(),
                                              ),
                                            );
                                            await getChatUserList();
                                          },
                                          onChatTap: () async {
                                            await Get.to(
                                              () => ChatScreen(
                                                userData: userList[index],
                                              ),
                                            );
                                            await getChatUserList();
                                          },
                                        ),
                                      )
                                    : const SizedBox();
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return const UserSkeleton();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  getUserName(UserData? userData) {
    String name = userData!.firstName!;
    if (userData.middleName != null) {
      name = "$name ${userData.middleName}";
    }
    if (userData.lastName != null) {
      name = "$name ${userData.lastName}";
    }
    return name;
  }

  Widget customHeadingText({String? title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        title!,
        style: const TextStyle(
            color: ColorConstants.greyLight,
            fontSize: 12,
            fontFamily: 'inter',
            fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget recentChatUser(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ChatScreen(
              userData: chatUsers[index],
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: (chatUsers[index].logo3 != null &&
                      chatUsers[index].logo3 != "")
                  ? CachedNetworkImage(
                      imageUrl: chatUsers[index].logo3 ?? "",
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Theme.of(context).hoverColor,
                          highlightColor: Theme.of(context).highlightColor,
                          enabled: true,
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.white,
                                border: Border.all(
                                    width: 1, color: ColorConstants.greyLight)),
                            child: const FaIcon(
                              FontAwesomeIcons.solidUser,
                              size: 30,
                              color: ColorConstants.greyLight,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Shimmer.fromColors(
                          baseColor: Theme.of(context).hoverColor,
                          highlightColor: Theme.of(context).highlightColor,
                          enabled: true,
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.white,
                                border: Border.all(
                                    width: 1, color: ColorConstants.greyLight)),
                            child: const FaIcon(
                              FontAwesomeIcons.solidUser,
                              size: 30,
                              color: ColorConstants.greyLight,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      height: 70,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.white,
                          border: Border.all(
                              width: 1, color: ColorConstants.greyLight)),
                      child: const FaIcon(
                        FontAwesomeIcons.solidUser,
                        size: 30,
                        color: ColorConstants.greyLight,
                      ),
                    ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(chatUsers[index].firstName ?? '')
          ],
        ),
      ),
    );
  }
}
