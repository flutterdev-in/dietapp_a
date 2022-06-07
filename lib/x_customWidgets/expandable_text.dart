import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

Widget? expText(
  String? text, {
  Color? textColor,
  double? fontSize,
  bool expandOnTextTap = false,
  bool collapseOnTextTap = true,
}) {
  final Color expandableTextColor = Colors.cyan.shade700;
  return (text == null || text.isEmpty)
      ? null
      : ExpandableText(
          text,
          expandOnTextTap: expandOnTextTap,
          collapseOnTextTap: collapseOnTextTap,
          animation: true,
          animationDuration: const Duration(milliseconds: 700),
          expandText: "more",
          collapseText: "show less",
          style: TextStyle(
            color: textColor ?? expandableTextColor,
            fontSize: fontSize,
          ),
        );
}
