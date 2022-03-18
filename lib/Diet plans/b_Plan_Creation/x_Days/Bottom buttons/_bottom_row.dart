import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget daysBottomButtons() {
  return Container(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () async {}, icon: Icon(MdiIcons.folderPlusOutline)),
        Text("|"),
        IconButton(
            onPressed: () async {},
            icon: Icon(MdiIcons.plusBoxMultipleOutline)),
        Text("|"),
        IconButton(onPressed: () async {}, icon: Icon(MdiIcons.penPlus)),
      ],
    ),
  );
}
