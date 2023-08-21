import 'package:flutter/material.dart';
import 'package:world_famous_landmarks/res/styles/text_input_styles.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField(
      {super.key,
      required this.onChange,
      required this.controller,
      this.errorMessage});

  final Function(String) onChange;
  final String? errorMessage;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      keyboardType: TextInputType.emailAddress,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyles.bodyMediumBold(),
      maxLines: 1,
      decoration: TextInputStyles.textInputStyle(
          hint: 'Email', errorText: errorMessage),
    );
  }
}
