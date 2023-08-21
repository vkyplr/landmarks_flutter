import 'package:flutter/material.dart';
import 'package:world_famous_landmarks/res/colors/app_colors.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: kBlackColor,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Loading',
            style: TextStyles.bodyMediumBold(),
          )
        ],
      ),
    );
  }
}
