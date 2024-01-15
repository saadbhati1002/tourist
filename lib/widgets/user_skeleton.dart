import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tourist/utility/color.dart';

class UserSkeleton extends StatefulWidget {
  const UserSkeleton({super.key});

  @override
  State<UserSkeleton> createState() => _UserSkeletonState();
}

class _UserSkeletonState extends State<UserSkeleton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: SkeletonTheme(
        themeMode: ThemeMode.light,
        child: SkeletonItem(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        shape: BoxShape.circle, width: 45, height: 45),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .55,
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            // height: 10,
                            borderRadius: BorderRadius.circular(8),
                            minLength: MediaQuery.of(context).size.width / 6,
                            maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: ColorConstants.greyLight,
                width: MediaQuery.of(context).size.width * 1,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
