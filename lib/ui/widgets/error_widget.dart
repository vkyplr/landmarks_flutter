import 'package:flutter/material.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyles.bodyMediumBold(),
      ),
    );
  }
}
