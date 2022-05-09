import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuItemsTimingViewHS extends StatelessWidget {
  final DocumentReference<Map<String, dynamic>> thisTimingDR;
  const MenuItemsTimingViewHS({Key? key,required this.thisTimingDR}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: const Icon(MdiIcons.dotsVertical),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text("Add Foods from Web"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text("Add Foods from Collection"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text("Add Foods from Plans"),
              ),
            ),
            PopupMenuItem(
              child: TextButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text("Delete this timing"),
              ),
            ),
          ];
        },
      ),
    );
  }

  
}
