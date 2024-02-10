import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/auth/auth.dart';
import 'package:tourist/models/favorite/favorite_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/chat/chat_screen.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:tourist/widgets/user_skeleton.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isLoading = false;
  List<Data> userData = [];
  Timer? _debounce;
  String? searchedName;
  @override
  void initState() {
    setAnalytics();
    getFavoriteUserList();
    super.initState();
  }

  setAnalytics() async {
    await FirebaseAnalytics.instance
        .logScreenView(screenName: 'Favorite Screen');
  }

  getFavoriteUserList() async {
    try {
      setState(() {
        isLoading = true;
      });
      FavoriteRes response = await AuthRepository().favoriteUsersListApiCall();
      if (response.data != null) {
        userData = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        searchedName = query;
      });
    });
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
                  onChanged: _onSearchChanged,
                  hintText: "Search For Participants",
                  suffix: Icon(
                    Icons.search,
                    size: 30,
                    color: ColorConstants.black,
                  ),
                  context: context,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              !isLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        return AppConstant.userData!.id ==
                                userData[index].joinedUsers!.id
                            ? const SizedBox()
                            : searchedName == null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: UserListData(
                                      userData: userData[index].joinedUsers,
                                      onProfileTap: () async {
                                        var response = await Get.to(
                                          () => ProfileScreen(
                                            isFromGuest: true,
                                            id: userData[index]
                                                .joinedUsers!
                                                .id
                                                .toString(),
                                          ),
                                        );
                                        if (response == 0) {
                                          userData.removeAt(index);
                                          setState(() {});
                                        }
                                      },
                                      onChatTap: () async {
                                        await Get.to(
                                          () => ChatScreen(
                                            userData:
                                                userData[index].joinedUsers,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : getUserName(userData[index].joinedUsers)
                                        .toString()
                                        .toLowerCase()
                                        .contains(searchedName!.toLowerCase())
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: UserListData(
                                          userData: userData[index].joinedUsers,
                                          onProfileTap: () {
                                            Get.to(
                                              () => ProfileScreen(
                                                isFromGuest: true,
                                                id: userData[index]
                                                    .joinedUsers!
                                                    .id
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          onChatTap: () async {
                                            await Get.to(
                                              () => ChatScreen(
                                                userData: userData[index]
                                                    .joinedUsers!,
                                              ),
                                            );
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

  getUserName(UserData? userData) {
    String name = userData!.firstName!.replaceAll(" ", "").trim();
    if (userData.middleName != null &&
        userData.middleName != "null" &&
        userData.middleName != " ") {
      name = "$name ${userData.middleName!.replaceAll(" ", "").trim()}";
    }
    if (userData.lastName != null) {
      name = "$name ${userData.lastName!.replaceAll(" ", "").trim()}";
    }
    return name;
  }
}
