import 'package:company/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static textStyle14(Color textColor, context,{background}) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      fontFamily: kMainFont,
      color: textColor,
      background: background,
    );
  }

  static textStyle20(Color textColor, context,{background}) {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      fontFamily: kMainFont,
      color: textColor,
      background: background,
      overflow: TextOverflow.visible
    );
  }

  static textStyle16(Color textColor, context,{background}) {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      fontFamily: kMainFont,
      color: textColor,
      background: background,
    );
  }

  static textStyleBold16(Color textColor, context,{background}) {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      fontFamily: kMainFont,
      color: textColor,
      background: background,
    );
  }

  static textStyleBold24(Color textColor, context,{background}) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      fontFamily: kMainFont,
      color: textColor,
      background: background,
    );
  }

  static textStyle12(Color textColor, context,{background}) {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      fontFamily: kMainFont,
      color: textColor,
      background: background,
    );
  }
}
