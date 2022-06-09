import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Rx<String> chatSearchString = "".obs;

Widget chatSearchFieldRow = Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Expanded(
      flex: 1,
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          MdiIcons.arrowLeft,
        ),
        color: Colors.black54,
      ),
    ),
    Expanded(
      child: chatSearchField,
      flex: 6,
    ),
  ],
);

Widget chatSearchField = TextField(
  decoration:
      const InputDecoration(prefix: Text("@"), hintText: "search userID"),
  autofocus: true,
  textInputAction: TextInputAction.search,
  onChanged: (value) async {
    await Future.delayed(const Duration(seconds: 1));
    chatSearchString.value = value;
  },
);
