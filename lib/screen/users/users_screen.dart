import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/api/repository/user/user.dart';
import 'package:tourist/models/all_user/all_user_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/screen/chat/chat_screen.dart';
import 'package:tourist/screen/profile/profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:tourist/widgets/user_skeleton.dart';

class UsersScreen extends StatefulWidget {
  final String? userType;
  const UsersScreen({super.key, this.userType});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  bool isLoading = false;
  List<UserData> userList = [];
  String? searchedName;
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    try {
      setState(() {
        isLoading = true;
      });
      AllUserRes response = await UserRepository().allUsersApiCall();
      if (response.data != null) {
        for (int userLength = 0;
            userLength < response.data!.length;
            userLength++) {
          if (response.data![userLength].userType == widget.userType) {
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
                height: 30,
              ),
              !isLoading
                  ? userList.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * .8,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Center(
                            child: Text("${widget.userType} not found"),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: UserListData(
                                userData: userList[index],
                                onProfileTap: () {
                                  Get.to(
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
                            );
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
