
import 'package:doit_today/core/resources/my_color.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:doit_today/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.icon = '',
    this.marginHorizontal = 16,
    this.marginVertical = 0,
    this.color,
    this.style,
  });

  final String title;
  final String? icon;
  final VoidCallback? onTap;
  final double marginHorizontal;
  final double marginVertical;
  final Color? color;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13).h,
        margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal,
          vertical: marginVertical,
        ).r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: MyStyles.borderRadius(radius: 10),
          border: MyStyles.borderAll(
            color: MyColors.white,
            width: 1.5,
          ),
          color: color ?? MyColors.lightGreen,
        ),
        child: CustomText(
          textAlign: TextAlign.center,
          title: title,
          style: style ??
              MyStyles.textStyle(
                color: MyColors.white,
                fontSize: 11,
              ),
        ),
      ),
    );
  }
}
