import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:world_famous_landmarks/res/colors/app_colors.dart';
import 'package:world_famous_landmarks/res/dimensions/app_dimensions.dart';

class TextInputStyles {
  static InputDecoration searchTextInputStyle() {
    return InputDecoration(
      isCollapsed: true,
      isDense: true,
      hintText: 'Search Landmark',
      suffixIcon: Icon(
        Icons.search,
        size: 3.h,
      ),
      contentPadding: EdgeInsets.only(left: 3.h),
      filled: true,
      fillColor: kCardColor,
      border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(kCardBorderRadius))),
    );
  }

  static InputDecoration textInputStyle({String hint = '', String? errorText}) {
    return InputDecoration(
      errorText: errorText,
      isCollapsed: true,
      isDense: true,
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 2.h),
      filled: true,
      fillColor: kCardColor,
      border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(kCardBorderRadius))),
    );
  }
}
