import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourist/utility/color.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imagePath;
  final bool? isFromAppBar;

  const CustomImage(
      {super.key, this.height, this.imagePath, this.width, this.isFromAppBar});

  @override
  Widget build(BuildContext context) {
    return (imagePath != null && imagePath!.isNotEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: imagePath!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
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
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.image),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Shimmer.fromColors(
                  baseColor: Theme.of(context).hoverColor,
                  highlightColor: Theme.of(context).highlightColor,
                  enabled: true,
                  child: Container(
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.image),
                  ),
                );
              },
            ),
          )
        : Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                border: Border.all(width: 1, color: ColorConstants.greyLight)),
            child: FaIcon(
              FontAwesomeIcons.solidUser,
              size: isFromAppBar == true ? 15 : 30,
              color: ColorConstants.greyLight,
            ),
          );
  }
}
