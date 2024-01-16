import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tourist/api/repository/user/user.dart';
import 'package:tourist/models/all_user/all_user_model.dart';
import 'package:tourist/models/user/user_model.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/constant.dart';
import 'package:tourist/widgets/app_bar_back.dart';
import 'package:tourist/widgets/common_text_field.dart';
import 'package:tourist/widgets/custom_user_list.dart';
import 'package:tourist/widgets/user_skeleton.dart';

class FindPeopleScreen extends StatefulWidget {
  const FindPeopleScreen({super.key});

  @override
  State<FindPeopleScreen> createState() => _FindPeopleScreenState();
}

class _FindPeopleScreenState extends State<FindPeopleScreen> {
  bool isLoading = false;
  List<UserData> userList = [];
  Timer? _debounce;
  String? searchedName;
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
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
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return AppConstant.userData!.id == userList[index].id
                          ? const SizedBox()
                          : searchedName == null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: UserListData(
                                    userData: userList[index],
                                    userType: 'Delegate',
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
                                        userType: 'Delegate',
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
    String name = userData!.firstName!;
    if (userData.middleName != null) {
      name = "$name ${userData.middleName}";
    }
    if (userData.lastName != null) {
      name = "$name ${userData.lastName}";
    }
    return name;
  }
}
