import 'package:flutter/material.dart';

void bottomSheetW(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 3 / 4)), // <= thi,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(53)),
    backgroundColor: Colors.white,
    builder: (context) => child,
  );
}