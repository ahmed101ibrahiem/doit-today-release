

import 'package:doit_today/core/base/bloc/generic_cubit/generic_cubit.dart';
import 'package:doit_today/core/resources/my_color.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:doit_today/widgets/custom_text/custom_text.dart';
import 'package:doit_today/widgets/custom_text_field/custom_password_eye.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.maxLines = 1,
    this.maxLength = 350,
    this.initialValue = "",
    this.hintText = "",
    this.title = "",
    this.restorationId = "",
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.cancelButton,
    this.controller,
    this.suffixIcon,
    this.showIcon = false,
    this.showFlag = false,
    this.passwordBloc,
    this.isShowBorder = false,
    this.titleStyle,
    this.hintStyle,
    this.textColor,
    this.filled = false,
    this.fillColor,
    this.hFieldPadding,
    this.passwordIconColor,
  });

  final String? initialValue, hintText, title, restorationId;

  final TextInputType? keyboardType;
  final bool isShowBorder;
  final TextEditingController? controller;
  final int? maxLength, maxLines;
  final bool? readOnly, obscureText, showIcon, showFlag;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged, onFieldSubmitted;
  final VoidCallback? onTap;
  final GenericCubit<bool>? cancelButton;
  final Widget? suffixIcon;
  final GenericCubit<bool>? passwordBloc;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final Color? textColor;
  final bool? filled;
  final Color? fillColor;
  final double? hFieldPadding;
  final Color? passwordIconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hFieldPadding ?? 14).r,
      child: Column(
        children: [
          Offstage(
            offstage: title == '',
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    title: title!,
                    style: titleStyle ??
                        MyStyles.textStyle(
                          color: MyColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.4
                        ),
                  ),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
            bloc: passwordBloc ?? GenericCubit(true),
            builder: (context, state) {
              return TextFormField(
                // restorationId: restorationId,
                keyboardType: keyboardType,
                controller: controller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(maxLength),
                ],
                style: MyStyles.textStyle(
                  fontSize: 13,
                  color: textColor ?? MyColors.black.withOpacity(
                    0.8
                  ),
                ),
                onTap: onTap,
                focusNode: focusNode,
                obscureText: obscureText! && state.data,
                maxLines: maxLines,
                readOnly: readOnly!,
                textInputAction: textInputAction,
                onFieldSubmitted: onFieldSubmitted,
                decoration: InputDecoration(
                  suffixIcon: buildSuffixIcon(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: hintText,
                  fillColor: fillColor,
                  filled: filled,
                  hintStyle: hintStyle ??
                      MyStyles.textStyle(
                        fontSize: 14,
                        color: MyColors.white,
                      ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ).r,
                  border: isShowBorder
                      ? MyStyles.inputBorder(
                          color: MyColors.grey,
                          width: 1,
                          radius: 8.r,
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8).r,
                          borderSide: BorderSide.none,
                        ),
                  enabledBorder: isShowBorder
                      ? MyStyles.inputBorder(
                          color: MyColors.grey,
                          width: 1,
                          radius: 8.r,
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8).r,
                          borderSide: BorderSide.none,
                        ),
                ),
              );
            },
          ),
          7.verticalSpace,
        ],
      ),
    );
  }

  Widget buildSuffixIcon() {
    if (showFlag!) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30.h,
              width: 2.w,
              color: Colors.red.withOpacity(.5),
            ),
            5.horizontalSpace,
            CustomText(
              title: '966',
              style: MyStyles.textStyle(
                fontSize: 14,
                height: 1.7,
                color: MyColors.white,
              ),
            ),
            5.horizontalSpace,
          ],
        ),
      );
    }

    if (showIcon!) {
      return suffixIcon!;
    }
    if (obscureText!) {
      return CustomPasswordEye(
        passwordBloc: passwordBloc,
        color: passwordIconColor,
      );
    }
    return const SizedBox.shrink();
  }
}
