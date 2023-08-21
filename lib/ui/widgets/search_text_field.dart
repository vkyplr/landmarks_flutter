import 'package:flutter/material.dart';
import 'package:world_famous_landmarks/res/styles/text_input_styles.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key, required this.onChange, required this.controller});

  final Function(String) onChange;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyles.bodyMediumBold(),
      maxLines: 1,
      decoration: TextInputStyles.searchTextInputStyle(),
    );
  }
}
