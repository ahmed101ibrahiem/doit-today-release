

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  const CustomText({
    required this.title,
    super.key,
    this.textAlign,
    this.style,
    this.maxLines,
    this.isOverflow = false,
    this.isSelectedText = false,
  });
  final String title;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? maxLines;
  final bool isOverflow;
  final bool isSelectedText;

  @override
  Widget build(BuildContext context) {
    if (isSelectedText) {
      return SelectableText(
        title,
        textAlign: textAlign,
        style: style,
        maxLines: maxLines,
      );
    } else {
      return Text(
        title,
        softWrap: true,
        textAlign: textAlign,
        style: style,
        maxLines: maxLines,
        overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
      );
    }
  }
}
