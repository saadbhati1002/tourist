import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';

class ShowProgressBar extends StatelessWidget {
  const ShowProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        child: const Center(
          child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                color: ColorConstants.mainColor,
              )),
        ),
      ),
    );
  }
}
