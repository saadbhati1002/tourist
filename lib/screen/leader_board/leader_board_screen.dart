import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/leader_board/leader_board.dart';
import 'package:tourist/models/leaderboard/leaderboard_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/chat/chat_screen.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/leader_board_user.dart';
import 'package:tourist/widgets/user_skeleton.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  Timer? _debounce;
  String? searchedName;
  bool isLoading = false;
  List<UserData> userList = [];
  @override
  void initState() {
    setAnalytics();
    getLeaderBoardUsers();
    super.initState();
  }

  setAnalytics() async {
    await FirebaseAnalytics.instance
        .logScreenView(screenName: 'Leader Board Screen');
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

  getLeaderBoardUsers() async {
    try {
      setState(() {
        isLoading = true;
      });
      LeaderboardRes response =
          await LeaderBoardRepository().getLeaderboardApiCall();
      if (response.data != null) {
        for (int userLength = 0;
            userLength < response.data!.length;
            userLength++) {
          if (response.data![userLength].userStatus == '1') {
            userList.add(response.data![userLength]);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Leader Board",
                style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "To make your friends top the leader board, save them to your favorites.",
                  style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextFormField(
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
            const SizedBox(
              height: 20,
            ),
            !isLoading
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return searchedName == null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: LeaderBoardUser(
                                index: (index + 1).toString(),
                                onProfileTap: () async {
                                  await Get.to(
                                    () => ProfileScreen(
                                      isFromGuest: true,
                                      id: userList[index].id.toString(),
                                    ),
                                  );
                                },
                                userData: userList[index],
                                onChatTap: () async {
                                  await Get.to(
                                    () => ChatScreen(
                                      userData: userList[index],
                                    ),
                                  );
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
                                  child: LeaderBoardUser(
                                    index: (index + 1).toString(),
                                    userData: userList[index],
                                    onProfileTap: () async {
                                      await Get.to(
                                        () => ProfileScreen(
                                          isFromGuest: true,
                                          id: userList[index].id.toString(),
                                        ),
                                      );
                                    },
                                    onChatTap: () async {
                                      await Get.to(
                                        () => ChatScreen(
                                          userData: userList[index],
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
