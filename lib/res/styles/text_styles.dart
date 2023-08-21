import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle headingLarge() {
    return TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold);
  }

  static TextStyle headingMedium() {
    return TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold);
  }

  static TextStyle headingSmall() {
    return TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold);
  }

  static TextStyle bodyMedium() {
    return TextStyle(
      fontSize: 15.sp,
    );
  }

  static TextStyle bodySmall() {
    return TextStyle(
      fontSize: 15.sp,
    );
  }

  static TextStyle bodySmallBold() {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bodyVerySmall() {
    return TextStyle(
      fontSize: 12.sp,
    );
  }

  static TextStyle bodyVerySmallBold() {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bodyLarge() {
    return TextStyle(
      fontSize: 18.sp,
    );
  }

  static TextStyle bodyMediumBold() {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bodyLargeBold() {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    );
  }
}
