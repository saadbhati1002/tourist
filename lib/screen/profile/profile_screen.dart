import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist/screen/auth/edit_profile/edit_profile_screen.dart';
import 'package:tourist/utility/color.dart';
import 'package:tourist/utility/images.dart';
import 'package:tourist/widgets/app_bar_back.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        Images.profileBox,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 90,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 90,
                                          width: 90,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 90,
                                                width: 90,
                                                child: Image.asset(
                                                  Images.userMain,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  height: 15,
                                                  width: 90,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                              10,
                                                            ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          color: ColorConstants
                                                              .delegateColor),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Delegate',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'poppins',
                                                        color: ColorConstants
                                                            .white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Company Name',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: ColorConstants.white,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thomas Brian Samuel',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorConstants.white,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'FOUNDER & CEO',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorConstants.white,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '+971 503 489 009',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: ColorConstants.white,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'email@gmail.com',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstants.white,
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'United Arab Emirates',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: ColorConstants.white,
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButtons(
                    Images.edit,
                    'Edit profile',
                    () {
                      Get.to(() => const EditProfileScreen());
                    },
                  ),
                  customButtons(
                    Images.qr,
                    'Share Card',
                    () {},
                  ),
                  // customButtons(
                  //   Images.visibility,
                  //   'Visibility',
                  //   () {},
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            customDataBox("Bio",
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi."),
            const SizedBox(
              height: 20,
            ),
            customDataBox("Company Bio",
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi."),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget customButtons(String? image, String? title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        height: 35,
        width: MediaQuery.of(context).size.width * .3,
        decoration: BoxDecoration(
          color: ColorConstants.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image!,
              color: ColorConstants.white,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'poppins',
                color: ColorConstants.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customDataBox(String? title, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        elevation: 2,
        shadowColor: ColorConstants.greyLight,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "poppins",
                    color: ColorConstants.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                data!,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: "poppins",
                    color: ColorConstants.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
