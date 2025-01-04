

import 'package:doit_today/core/resources/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyStyles {
  static final TextStyle _defaultTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: MyColors.primary,
    height: 1.2,
  );

  static TextStyle textStyle({
    double fontSize = 16.0,
    Color? color,
    double height = 1.2,
    TextDecoration? decoration,
    FontWeight fontWeight = FontWeight.bold,
  //  String fontFamily = FontFamily.inter,
  }) {
    return _defaultTextStyle.copyWith(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
 //     fontFamily: fontFamily,
    );
  }
  static BorderRadius borderRadius({
    double radius = 20.0,
    BorderRadiusType type = BorderRadiusType.all,
  }) {
    switch (type) {
      case BorderRadiusType.all:
        return BorderRadius.circular(radius).r;
      case BorderRadiusType.top:
        return BorderRadius.vertical(top: Radius.circular(radius)).r;
      case BorderRadiusType.bottom:
        return BorderRadius.vertical(bottom: Radius.circular(radius)).r;
      case BorderRadiusType.left:
        return BorderRadius.horizontal(left: Radius.circular(radius)).r;
      case BorderRadiusType.right:
        return BorderRadius.horizontal(right: Radius.circular(radius)).r;
      case BorderRadiusType.reverse:
        return BorderRadius.only(
          bottomRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        ).r;
    }
  }

  static BorderSide borderSide({
    Color? color,
    double width = 1.0,
  }) =>
      BorderSide(
        color: color ?? MyColors.black,
        width: width,
      );

  static BoxBorder borderAll({
    double width = 1.0,
    Color? color,
  }) =>
      Border.all(
        color: color ?? MyColors.black,
        width: width,
      );

  static InputBorder inputBorder({
    double radius = 5.0,
    Color? color,
    double width = 0.6,
  }) {
    return OutlineInputBorder(
      borderRadius: borderRadius(radius: radius),
      borderSide: borderSide(
        color: color ?? MyColors.black,
        width: width,
      ),
    );
  }
}

enum BorderRadiusType { all, top, bottom, left, right, reverse }
